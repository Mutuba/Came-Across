README
Come Across that list the places a person has visited and lets the user creates new entries.

The application offers two main functions:

1. Ability to view places one has visited
2. Ability to add new entries

This application uses Ruby version 3.1.2 To install, use rvm or rbenv.

RVM

rvm install 3.0.2

rvm use 3.0.2

Rbenv
rbenv install 3.0.2

Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed. I recommend bundler version 2.0.2. To install:

You need Rails. The rails version being used is rails version 7

To install:

gem install rails -v '~> 7'

\*To get up and running with the project locally, follow the following steps.

Clone the app

With SSH

git@github.com:Mutuba/Came-Across.git

With HTTPS
https://github.com/Mutuba/Came-Across.git

Move into the directory and install all the requirements.

cd came-across

Setup with Docker

Ensure Docker is installed

Docker needs a database, user and password for the postgres service.

Type `psql` or `sudo -u <your-postres-admin-user> psql` to connect to the a local postgres terminal

Run `CREATE ROLE your_username WITH LOGIN PASSWORD 'your_password';` to create a role for docker instance

run bundle install to install application packages

Run rails db:create to create a database for the application

Run rails db:migrate to run database migrations and create database tables

The application can be run by running the below command:-

rails s or rails server

The application uses redis and sidekiq for backgroun d job processing
Run this commands in separate terminals to start redis and sidekiq
redis-server to start redis server and bundle exec sidekiq to start sidekiq server
