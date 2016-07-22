# AWS Settings

## Credentials
Set your default AWS access key id and secret key:
```bash
$ vim ~/.aws/credentials
```

Paste credentials and save:
```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

## Config
Set your default aws cli region/output format:
```bash
$ vim ~/.aws/config
```

Paste settings and save:
```
[default]
region=eu-central-1
output=json
```

Alternatively you can set all the above interactively using:
```bash
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

## SSH key pair

Create a new key pair for the project:
```bash
$ ssh-keygen -t rsa -f ~/.ssh/fullstack
```

If you prefer to use your default `id_rsa` key pair make sure to update key `SSH_KEY_NAME` in the `vars` file.

