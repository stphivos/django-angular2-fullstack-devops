# django-angular2-fullstack-compact
All-in-one django/angular2 environment seed with devops cli interface

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
$ vim devops  # Edit project variables to your project
$ ./devops setup  # Equivalent to `vagrant up` in this scenario, except that it destroys and re-creates the machine
$ vagrant ssh  # Log into the virtual machine. Vagrant commands: https://www.vagrantup.com/docs/cli/
```

## Develop

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

## Build
```bash
$ ./devops build dev backend    # Uses packer/ansible to provision an amazon machine image
$ ./devops build dev frontend   # Uses gulp to create a target environment distribution
```

## Deploy
```bash
$ ./devops deploy dev core      # Uses terraform to launch shared infrastructure such as vpc/gateway/subnet/keypair etc.
$ ./devops deploy dev rds       # Uses terraform to launch a db instance on RDS
$ ./devops deploy dev backend   # Uses terraform to launch an EC2 instance and load balancer for the backend api
$ ./devops deploy dev frontend  # Uses aws-cli to upload the frontend static files to a bucket on S3

# or simply

$ ./devops deploy dev           # Calls all the above in the order stated
```

## Credits
* Frontend seed - slightly modified version of [mgechev/angular2-seed](https://github.com/mgechev/angular2-seed)
* Ansible playbook for Django - based on [jcalazan/ansible-django-stack](https://github.com/jcalazan/ansible-django-stack)
