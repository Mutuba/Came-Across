## README.md

- Come Across that list the places a person has visited and lets the user creates new entries.

- The application offers two main functions:

* Ability to view places one has visited
* Ability to add new entries

This application uses Ruby version 3.1.2 To install, use rvm or rbenv.

# RVM

`rvm install 3.0.2`

`rvm use 3.0.2`

# Rbenv

`rbenv install 3.0.2`

- Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed. I recommend bundler version 2.0.2. To install:

- You need Rails. The rails version being used is rails version 7

To install:

`gem install rails -v '~> 7'`

- To get up and running with the project locally, follow the following steps.

Clone the app

- With SSH

`git@github.com:Mutuba/Came-Across.git`

- With HTTPS
  `https://github.com/Mutuba/Came-Across.git`

Move into the directory and install all the requirements.

cd came-across

# Setup with Docker

- Ensure Docker is installed

* Run `docker-compose build` to build the Docker image for the application.

* Once the build is complete, run `docker-compose up` to start the Docker container out of the image.

* This will the services listed in the docker-compose file, namely web and postres.

* Docker needs a database, user and password for the postgres service.

In another terminal window:

Type `psql` or `sudo -u <your-postres-admin-user> psql` to connect to the a local postgres terminal.

- Run `CREATE ROLE your_user_for_the_app WITH LOGIN PASSWORD 'your_password';` to create a role for docker instance.

Since your containers are running, access your postres container by running

- `docker-compose exec postgres psql -U  <your_user_for_the_app>`

This will start the postgres terminal within docker container.

Run `CREATE DATABASE your_db_for_the_app;` and then run `GRANT ALL PRIVILEGES ON DATABASE your_db_for_the_app TO your_user_for_the_app;`

This will create a database for postgres service and the app in general.

- Create a .env file and update each environment variable from the `.env.sample` file with your credentials for the postgres database you have created.

For cloudinary, you need to have an account, a free account will do, then go the dashboard and copy `CLOUD_NAME`, `API_KEY`, and `API_SECRET`.

- Run `docker-compose exec web rails db:migrate` to run migrations and create all necessary tables for the app.

- Run `docker-compose exec web rails db:seed` to add initial data, to the database. Predefined categories and dummy locations will be created.

* Go to the terminal where you run `docker-compose up` and stop the container. Then run `docker-compose up -d` to restart the container.

You can access the app on `localhost:3000`.

- There is a `Makefile` with shorthand commands for running utility commands for app. Be sure to check that too.

To run tests

`make test` if you want to use `Makefile` commands

# Set application without Docker.

- This application uses Ruby version 3.1.2 To install, use rvm or rbenv.

# RVM

- rvm install 3.0.2

- rvm use 3.0.2

# Rbenv

- rbenv install 3.0.2

- Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed. I recommend bundler version 2.0.2. To install:

- You need Rails. The rails version being used is rails version 7

- To install:

`gem install rails -v '~> 7'`

- Run `bundle install` to install application packages.

- Run `rails db:create` to create a database for the application

- Run `rails db:migrate` to run database migrations and create database tables

- Run `rails db:seed` to initialize the database with seed data

* The application can be run by running the below command:-

`rails s or rails server`

- The app is up and running here.

https://comeacross.onrender.com/
