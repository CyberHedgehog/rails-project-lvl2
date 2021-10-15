install:
	bundle install
	yarn install

test:
	bin/rails test

console:
	bin/rails console

lint:
	rubocop

start:
	bin/rails s

.PHONY: test