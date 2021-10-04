install:
	bundle install
	yarn install

test:
	bin/rails test

lint:
	rubocop

.PHONY: test