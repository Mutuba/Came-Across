# For example, these lines are the same:
#   > make g devise:install
#   > bundle exec rails generate devise:install
# And these:
#   > make add-migration add_deleted_at_to_users deleted_at:datetime
#   > bundle exec rails g migration add_deleted_at_to_users deleted_at:datetime
# And these:
#   > make add-model Order user:references record:references{polymorphic}
#   > bundle exec rails g model Order user:references record:references{polymorphic}
#
RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

add-migration:
	bundle exec rails g migration $(RUN_ARGS)

add-model:
	bundle exec rails g model $(RUN_ARGS)

db-create:
	bundle exec rake db:create

db-migrate:
	bundle exec rake db:migrate

db-rollback:
	bundle exec rake db:rollback

lint-ruby-setup:
	bundle exec rubocop --auto-gen-config

lint-ruby:
	bundle exec rubocop -a

lint-security:
	brakeman

run-console:
	bundle exec rails console

run-generate:
	bundle exec rails generate $(RUN_ARGS)

run-rails:
	bundle exec puma -t 1:1 -b tcp://0.0.0.0:3000

c: run-console

g: run-generate

s: run-rails

build: #: Build containers
	docker-compose build

build: #: Build containers
	docker-compose build

migrate: #: Run migrations in docker container
	docker-compose run web rails db:migrate

ps: #: Show running processes
	docker-compose ps

restart: #: Restart the service container
	docker-compose restart $(SERVICE)

seed: #: Seed the DB in docker container
	docker-compose run web rails db:seed

stop: #: Stop running containers
	docker-compose stop

test: #: Run tests in docker container
	docker-compose run web rspec

up: #: Start containers
	docker-compose up -d

down: #: Bring down the service
	docker-compose down