# django-angular2-fullstack-compact
All-in-one fill-in-the-blanks django/angular2 environment seed

## Features
* Vagrant provisioning
* Travis CI configuration
* Testing infrastructure with coverage
* Separate frontend/backend projects

## Stack

### Frontend
* Angular 2.0
* TypeScript 1.8
* Bootstrap 3.3
* jQuery 2.2

### Backend
* Django 1.9
* PostgreSQL 9.4
* Django REST Framework 3.3

## Requirements
* [Vagrant](https://www.vagrantup.com/docs/installation/)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Setup
```bash
$ git clone https://github.com/stphivos/django-angular2-fullstack-compact
$ cd django-angular2-fullstack-compact
$ vagrant up
$ vagrant ssh
```

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

## Credits
* Frontend seed - slightly modified version of [mgechev/angular2-seed](https://github.com/mgechev/angular2-seed)
* Vagrant provisioning - script based on [jackdb/pg-app-dev-vm](https://github.com/jackdb/pg-app-dev-vm)
