.PHONY: lint

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/