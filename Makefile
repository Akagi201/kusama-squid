.PHONY: all
all:help

.PHONY: process # run squid processor
process: migrate
	@node -r dotenv/config lib/processor.js

.PHONY: build # build squid
build:
	@npm run build

.PHONY: serve # run graphql server
serve:
	@npx squid-graphql-server

.PHONY: migrate # run migration
migrate:
	@npx squid-typeorm-migration apply

.PHONY: codegen # run codegen
codegen:
	@npx squid-typeorm-codegen

.PHONY: typegen # run typegen
typegen:
	@npx squid-substrate-typegen typegen.json

.PHONY: up # run docker-compose up
up:
	@docker-compose up -d

.PHONY: down # run docker-compose down
down:
	@docker-compose down

.PHONY: help # Generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
