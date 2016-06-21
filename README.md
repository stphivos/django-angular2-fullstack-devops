# django-angular2-fullstack-compact
All-in-one django/angular2 environment seed with devops cli interface for aws

Save weeks or even months of work!

## Features
* Vagrant box
* Ansible playbook
* Devops cli interface
* Travis CI configurations
* Tests with code coverage
* Isolated frontend/backend projects
* Build virtual images with packer
* Launch infrastructure using terraform
* Central project variables configuration
* Jenkins pipeline workflow server (TODO)

## Stack

### Frontend
* Angular 2.0
* TypeScript 1.8
* Bootstrap 3.3

### Backend
* Django 1.9
* PostgreSQL 9.4
* Django REST Framework 3.3

## Requirements
* [Vagrant](https://www.vagrantup.com/docs/installation)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

The following are needed for building and deploying your infrastructure:

* [Packer](https://www.packer.io/intro/getting-started/setup.html)
* [Terraform](https://www.terraform.io/intro/getting-started/install.html)
* [AWS Account](https://aws.amazon.com)

## Setup
```bash
$ git clone https://github.com/stphivos/django-angular2-fullstack-compact
$ cd django-angular2-fullstack-compact
$ vim devops  # Edit project variables based on your project
$ ./devops setup  # Equivalent to `vagrant up` the first time, except that it destroys and re-creates the machine
$ vagrant ssh  # Log into the virtual machine. See all vagrant commands: https://www.vagrantup.com/docs/cli/
```

## Run

### Frontend
```bash
$ cd frontend
$ npm start
```
[README..](frontend/README.md)

### Backend
```bash
$ cd backend
$ ./manage.py runserver
```
[README..](backend/README.md)

## Devops

### Build

The first time:
```bash
$ ./devops build dev            # Calls commands below in the order shown
```

For building a specific project, either of the following can be run separately:
```bash
$ ./devops build dev backend    # Uses packer/ansible to provision an amazon machine image
$ ./devops build dev frontend   # Uses gulp to create a target environment distribution
```

### Deploy

The first time:
```bash
$ ./devops deploy dev           # Calls commands below in the order shown
```

After updating a specific component, either of the following can be run separately:
```bash
$ ./devops deploy dev core      # Uses terraform to launch shared infrastructure such as vpc/gateway/subnets etc.
$ ./devops deploy dev rds       # Uses terraform to launch a db instance on RDS
$ ./devops deploy dev backend   # Uses terraform to launch an EC2 instance and load balancer for the backend api
$ ./devops deploy dev frontend  # Uses aws-cli to upload the frontend static files to a bucket on S3
```

### Examples

Rebuild and deploy frontend for prod environment:
```bash
$ ./devops pipeline dev frontend  # ~30 seconds
```

Rebuild and deploy backend for prod environment:
```bash
$ ./devops pipeline dev backend  # ~8 minutes
```

## Credits
* Frontend seed - slightly modified version of [mgechev/angular2-seed](https://github.com/mgechev/angular2-seed)
* Ansible playbook for Django - based on [jcalazan/ansible-django-stack](https://github.com/jcalazan/ansible-django-stack)
