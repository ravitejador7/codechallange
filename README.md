# codechallange
TF code for AWS resources

Requirement:
------------
Instance type should be configurable
Instance EBS volume size should be configurable
Mount the EBS volume
Upload a python program to the EC2 instance
Run the program at the instance creation
Python program should basically create a file, Write the following data 1 to 100 numbers in the file
This EC2 should be in private subnet
Add tags to the ec2 instance
Create s3 bucket
Provide list permission to the ec2 instance on the s3 bucket

Initial Setup
-------------
1. Create AWS account with user having persmissions for programmatic access.
2. Use the access and secret key from step 1 and configure aws config in your local machine.
Command: aws configure

Steps to create:
----------------
1. Clone the below github repo
    Command: git clone https://github.com/ravitejador7/codechallange.git
2. Use the below commands in sequence to deploy the infrastructure
    terraform init
    terraform plan
    terraform apply

Files overview
---------------
vpc -- terraform file to create vpc.
variables.tf -- terraform file containing list of variables
subnets.tf -- terraform file to create the subnets in the infrastructure.
s3.tf -- terraform file to create the s3 bucket
route.tf -- terraform file to create the route tables
igw.tf -- terraform file to create internet gateway in the infrastructure
provider.tf -- terraform providers used within this respository
nat.tf -- terraform file to create the nat gateway
igw.tf -- terraform file to create the internet gateway
ec2.tf -- terraform file to mount the EBS volumes, copy the python code from s3 and execute using python.
ebs.tf -- terraform file to create the ebs volumes
