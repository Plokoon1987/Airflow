#! /bin/bash

# Variables
export USERNAME=airflow
export PASSWORD=airflow
export DATABASE=airflow
export AIRFLOW_HOME=`pwd`/airflow

# Install PostgreSQL and setting it up
echo 'Downloading PostgreSQL'
git clone https://github.com/Plokoon1987/PostgreSQL.git
echo ''
echo 'Running init.sh'
./PostgreSQL/init.sh
echo ''
echo 'Removing PostgreSQL'
rm -rf PostgreSQL
echo '...'
echo '...'
echo ''

# Creating User, and Database for airflow
echo 'Removing old Databases and Users'
dropdb $DATABASE
dropuser $USERNAME
echo ''
echo 'Creating User, and Database for Airflow'
./create_postgresql_user/init.sh -u $USERNAME -p $PASSWORD -d $DATABASE
echo '...'
echo '...'
echo ''

# Installing Python-pip and Virtualenv
echo "Installing Python-Pip"
sudo apt-get install python-pip
echo ''
echo "Installing Virtualenv"
sudo pip install virtualenv
echo '...'
echo '...'
echo ''

# Airflow Specific Setup
echo 'Removing old folders'
rm -rf env airflow
echo ''

echo 'Creating new Virtualenv'
virtualenv -p `which python3` env
echo ''

echo 'Activating Virtualenv'
. env/bin/activate
echo ''

echo 'Upgrading pip setuptools wheel'
pip install --upgrade pip setuptools wheel
echo ''

echo 'Installing apache-airflow'
pip install apache-airflow
echo ''

echo 'Initiating database'
airflow initdb
rm ./airflow/airflow.db
echo ''
