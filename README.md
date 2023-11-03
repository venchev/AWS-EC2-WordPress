# AWS-EC2-WordPress

Prerequisites:

* Create AWS RSA Pair key (pem) - wordpressKey and put it in the same dir, where are tf scripts
* Create S3 bucket for backend of terraform - lab-tfstate-bucket (in this example, or whatever name you like) and configure it in backend.tf
* You need to export in the OS shell your AWS Keys, which are NOT hardcoded in the code here, due to security reasons.

Once this is done and you have access to AWS via CLI, should be able to deploy the resources via terraform.

Enjoy.
