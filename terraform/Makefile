.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+(\/?[a-zA-Z_-]+)+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

SHELL := /bin/bash -l

TERRAFORM_FOLDER ?= .
TARGET_ENV ?= dev
BACKEND ?= dev
AWS_DEFAULT_REGION=eu-west-1

# Format the terraform code
terraform-fmt:
	terraform fmt ${TERRAFORM_FOLDER}

# Perform a terraform init
terraform-init:
	cd ${TERRAFORM_FOLDER} && \
	terraform init -backend-config=backend/${BACKEND}.conf -input=false
	terraform get -update ${TERRAFORM_FOLDER}

terraform-workspace:
	cd ${TERRAFORM_FOLDER} && \
	terraform workspace select ${TARGET_ENV} || terraform workspace new ${TARGET_ENV}

# Perform a validation of the terraform files
terraform-validate:
	cd ${TERRAFORM_FOLDER} && \
	terraform validate

# Produce the terraform plan
terraform-plan:
	cd ${TERRAFORM_FOLDER} && \
	terraform plan -var-file=vars/${TARGET_ENV}.tfvars \
		-input=false -out=tfplan && \
  terraform show -json tfplan>tfplan.json

# Apply the terraform plan
terraform-apply:
	cd ${TERRAFORM_FOLDER} && \
	terraform apply -input=false -auto-approve tfplan

# Produce the terraform plan to destroy the infrastructure
terraform-plan-destroy:
	cd ${TERRAFORM_FOLDER} && \
	terraform plan -destroy -var-file=vars/${TARGET_ENV}.tfvars \
		-input=false -out=tfplan

# Destroy the infrastructure provisioned
terraform-destroy:
	cd ${TERRAFORM_FOLDER} && \
	terraform destroy -input=false -auto-approve -refresh=false \
	-var-file=vars/${TARGET_ENV}.tfvars

# conftest-plan
conftest-plan:
	cat ${TERRAFORM_FOLDER}/tfplan.json | conftest test -p ${CONF_POLICIES}/terraform -o table -

# Clear the terraform temporary files
clean:
	rm -rf terraform*

# kustomzie install
kustomize-install: kustomize-clean
	@cd ${KUSTOMIZE_SPINNAKER_FOLDER} && \
	curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash -s -- ${KUSTOMIZE_VERSION}

# kustomize clean:
kustomize-clean:
	@cd ${KUSTOMIZE_SPINNAKER_FOLDER} && \
	rm -f kustomize

# kustomize-build
kustomize-build: kustomize-install
	@cd ${KUSTOMIZE_SPINNAKER_FOLDER} && \
	./kustomize build .

# kustomize-apply
kustomize-apply:
	@cd ${KUSTOMIZE_SPINNAKER_FOLDER} && \
	./kustomize build . | kubectl apply -f -

# kustomize-delete
kustomize-delete:
	@cd ${KUSTOMIZE_SPINNAKER_FOLDER} && \
	./kustomize build . | kubectl delete -f-

# kustomize-plan
kustomize-plan:
	@cd ${KUSTOMIZE_SPINNAKER_FOLDER} && \
	./kustomize build . | kubectl diff -f-


# kustomize-upgrade:
kustomize-upgrade:
	@curl https://codeload.github.com/armory/spinnaker-kustomize-patches/zip/master -o spin-kustomize.zip && \
	unzip -d spinnaker-kustomize-patches -uj spin-kustomize.zip && rm spin-kustomize.zip