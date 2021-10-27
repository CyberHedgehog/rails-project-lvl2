install:
	bundle install
	yarn install

migrate:
	bin/rails db:migrate

test:
	bin/rails test

console:
	bin/rails console

lint:
	rubocop

start:
	bin/rails s

.PHONY: test