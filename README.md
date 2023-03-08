### About

This is a simple tool to deploy an EC2 instance, a RDS instance, and supporting resources like VPC and Internet Gateway to AWS.

### Initial Steps

1. Create a key/pair under the AWS EC2 Management Console. Remember the name that you assigned to this key pair. We'll use it later.

2. Clone this repo and `cd` into the clone.

3. `cd ./user/backends`

### User Specific Secrets and Other Parameters

1. Enter your Terraform back-end information in the 2 files, one for an Elastic IP and one for the rest of the resources. The reason I did it this way is because the back-end files will be copied to the deploy directory before executing `terraform` commands like `plan` and `apply`. Then this copy will be deleted after running each `terraform` command. The `terraform` commands are run using `make` so the copying and deletion of the back-end files are automatic. I didn't want to include the back-end settings in the deploy directories because different users will have different back-ends. Hence, the back-end source files are found in the `./user` directory.

2. Go back to the repo root directory.

3. Create a secrets file. This file should ideally be outside this repo's directory. Information about what should be entered in the secrets file is found in the example secrets file. This is the file where you enter the name of the key/pair you created earlier.

4. Edit `./user/path-to-secrets` and enter the path to the secrets file you created in step 6.

### Configuration

The `./config` directory contains Terraform var files. An example of a configuration item that you might want to change is `region` which is the AWS region you'd like to deploy the resources like `us-west-`.

### Deploying the Elastic IP

I've separated the Elastic IP from the rest of the resources because I might leave this resource deployed for a longer time than the rest of the resources. As of 2023/03/08, EIP costs $0.005 per hour if it's not used. It costs a lot less than the rest of the resources. I may assign this IP address for use on a domain name. It takes about an hour for a domain name to propagate. So I could destroy the EC2 instance, the RDS instance, etc. as I'm developing. Destroying this development environment after each use will reduce AWS costs. But I don't want to destroy the IP address because that would mean waiting an hour for the domain name to propagate each time a new IP is assigned to the domain name.

Run these commands. Proceed to the next number only if there are no errors:

1. `cd ./live/long-term/eip`

2. `make init`

3. `make plan`

4. `make approve=true apply` # This will create AWS resources.

5. If you want to destroy the created resources, run `make approve=true destroy`.

### Deploying the EC2 Instance, RDS, Etc.

The Elastic IP must be deployed before running these commands. Run these commands. Proceed to the next number only if there are no errors:

1. `cd ./live/dev/instance+postgresql`

2. `make init`

3. `make plan`

4. `make approve=true apply` # This will create AWS resources.

5. If you want to destroy the created resources, run `make approve=true destroy`.

### Results

You can remove the `approve=true` option in the `apply` and `destroy` commands. If you should CTRL-C while being asked for approval, the back-end temp file won't be deleted. You can delete this file manually.

After deployment, the IP address and RDS endpoint should be displayed on screen. You can now SSH into the instance using the IP address and set up your app. You can now enter the RDS endpoint along with the user name and password into your database settings.
