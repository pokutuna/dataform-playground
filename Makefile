PROJECT := pokutuna-playground
GCLOUD := gcloud --project=$(PROJECT)
LOCATION := asia-northeast1

.PHONY: deps
deps:
	npm ci


.PHONY: deploy
deploy:
	npx -p @dataform/cli@latest dataform run

.PHONY: test
test:
	npx -p @dataform/cli@latest dataform compile
	npx -p @dataform/cli@latest dataform run --dry-run

.PHONY: application-default-credentials
application-default-credentials:
	$(GCLOUD) auth application-default login \
		--scopes=https://www.googleapis.com/auth/cloud-platform,https://www.googleapis.com/auth/spreadsheets.readonly,https://www.googleapis.com/auth/drive.readonly --disable-quota-project
