#!/bin/sh -e

APP_ROOT_NAME=backend

APP_DB_USER=backend
APP_DB_PASS=!qwerty1
APP_DB_PORT=15432
APP_BACKEND_NAME=backend
APP_FRONTEND_NAME=frontend

USER_HOME=/home/vagrant
PROJECT_ROOT_DIR=$USER_HOME/$APP_ROOT_NAME
PROJECT_BACKEND_DIR=$PROJECT_ROOT_DIR/$APP_BACKEND_NAME
PROJECT_FRONTEND_DIR=$PROJECT_ROOT_DIR/$APP_FRONTEND_NAME

PG_VERSION=9.4

###########################################################
# Changes below this line are probably not necessary
###########################################################
print_db_usage () {
  echo "Your PostgreSQL database has been setup and can be accessed on your local machine on the forwarded port (default: $APP_DB_PORT)"
  echo "  Host: localhost"
  echo "  Port: $APP_DB_PORT"
  echo "  Database: $APP_ROOT_NAME"
  echo "  Username: $APP_DB_USER"
  echo "  Password: $APP_DB_PASS"
  echo ""
  echo "Admin access to postgres user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo ""
  echo "psql access to app database user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h localhost $APP_ROOT_NAME"
  echo ""
  echo "Env variable for application development:"
  echo "  DATABASE_URL=postgresql://$APP_DB_USER:$APP_DB_PASS@localhost:$APP_DB_PORT/$APP_ROOT_NAME"
  echo ""
  echo "Local command to access the database via psql:"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h localhost -p $APP_DB_PORT $APP_ROOT_NAME"
}

export DEBIAN_FRONTEND=noninteractive

PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
  echo ""
  print_db_usage
  exit
fi

PG_REPO_APT_SOURCE=/etc/apt/sources.list.d/pgdg.list
if [ ! -f "$PG_REPO_APT_SOURCE" ]
then
  # Add PG apt repo:
  echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > "$PG_REPO_APT_SOURCE"

  # Add PGDG repo key:
  wget --quiet -O - https://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
fi

echo "##### UPGRADE #####"

# Update package list and upgrade all packages
apt-get update
apt-get -y upgrade

echo "##### Backend #####"

echo "Installing PostgreSQL..."
apt-get -y install "postgresql-$PG_VERSION" "postgresql-contrib-$PG_VERSION"

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"

# Append to pg_hba.conf to add password auth:
echo "host    all             all             all                     md5" >> "$PG_HBA"

# Explicitly set default client_encoding
echo "client_encoding = utf8" >> "$PG_CONF"

# Restart so that all new config is loaded:
service postgresql restart

cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';

-- Create the database:
CREATE DATABASE $APP_ROOT_NAME  WITH OWNER=$APP_DB_USER
                                LC_COLLATE='en_US.utf8'
                                LC_CTYPE='en_US.utf8'
                                ENCODING='UTF8'
                                TEMPLATE=template0;

-- Make superuser (We want this user to be able to create test databases - dev envs only!):
ALTER USER $APP_DB_USER WITH SUPERUSER;
EOF

print_db_usage

echo "Installing Git..."
apt-get -y install git

echo "Installing python setuptools..."
apt-get -y install python-setuptools
easy_install -U pip

echo "Installing required packages for python package 'psycopg2'..."
apt-get -y install python-dev python3-dev libpq-dev

echo "Installing virtualenvwrapper..."
pip install virtualenvwrapper

echo "Setting up virtual environment..."
echo "" >> ${USER_HOME}/.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ${USER_HOME}/.bashrc
echo "cd $PROJECT_ROOT_DIR" >> ${USER_HOME}/.bashrc
echo "workon $APP_ROOT_NAME" >> ${USER_HOME}/.bashrc
echo "export DJANGO_SETTINGS_MODULE=$APP_ROOT_NAME.settings" >> ${USER_HOME}/.bashrc

echo "Setting up django project requirements..."
sudo su - vagrant /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh; \
                                cd ${PROJECT_BACKEND_DIR}; \
                                mkvirtualenv --python=`which python` $APP_ROOT_NAME; \
                                pip install -r requirements/requirements-dev.txt; \
                                python manage.py makemigrations; \
                                python manage.py migrate; \
                                deactivate;"

echo "##### Frontend #####"

echo "Installing Node.js..."
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
apt-get install -y build-essential

echo "Installing Node modules..."
sudo su - vagrant /bin/bash -c "cd ${PROJECT_FRONTEND_DIR}; \
                                npm install;"

# Tag the provision time:
date > "$PROVISIONED_ON"
echo ""
echo "Successfully created dev virtual machine."
echo ""
echo "You can start the machine by running: vagrant up"
echo "You can ssh to the machine by running: vagrant ssh"
echo "You can stop the machine by running: vagrant halt"
echo "You can delete the machine by running: vagrant destroy"
echo ""
exit 0
