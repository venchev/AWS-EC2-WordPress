# First, we need to create a key for Backups Encryption
# Then, to specify the time frame for backups retention and deletion after.

resource "aws_kms_key" "backup_key" {
  description             = "Backup KMS key"
  deletion_window_in_days = 10
}

# Next step - to create the Backup Vault, where the backups will be kept.
# Using the created key inside, as reference.

resource "aws_backup_vault" "backup_vault" {
  name        = "backup-vault"
  kms_key_arn = aws_kms_key.backup_key.arn
}

# Creation of IAM backup policy

data "aws_iam_policy_document" "backup" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
  }
  version = "2012-10-17"
}

data "aws_iam_policy" "backup" {
  name = "AWSBackupServiceRolePolicyForBackup"
}

resource "aws_iam_role" "backup" {
  name               = "backup_iam_role"
  assume_role_policy = data.aws_iam_policy_document.backup.json
}

resource "aws_iam_role_policy_attachment" "backup" {
  policy_arn = data.aws_iam_policy.backup.arn
  role       = aws_iam_role.backup.name
}

# Creation of EBS backup volume

resource "aws_ebs_volume" "backup_volume" {
  availability_zone = var.regional_availability_zone
  size              = var.backup_volume_size
  encrypted         = true
  type              = "gp2"
  tags = merge(
    {
      Name = "backup-volume"
    },
  )
}

# Activation of the volume for usage.

resource "aws_backup_selection" "backup_volume" {
  iam_role_arn = aws_iam_role.backup.arn
  name         = "back-selection"
  plan_id      = aws_backup_plan.plan.id
  resources = [
    aws_ebs_volume.backup_volume.arn
  ]
}

# Creation of backup plan.
# For lifecycle - data will be moved in the cold storage after 14 days and will
# be kept there for one year.

resource "aws_backup_plan" "plan" {
  name = "aws-backup-plan"
  rule {
    rule_name         = "nightly"
    target_vault_name = aws_backup_vault.backup_vault.name
    schedule          = "cron(0 20 * * ? *)"
    start_window      = 60
    completion_window = 120
    lifecycle {
      cold_storage_after = var.cold_storage_move
      delete_after       = var.cold_storage_retentioin
    }
  }
}