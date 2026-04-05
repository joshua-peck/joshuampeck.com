ENV=dev
PROJECT_ID=virtualbusinessmailbox
GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/application_default_credentials.json

export $(cat ../.env | xargs)

.SILENT: refresh plan apply

refresh:
	terraform refresh  -var="project_id=$(PROJECT_ID)" -var="env=$(ENV)" \
		-var="stripe_secret_key=${STRIPE_SECRET_KEY}" \
  		-var="stripe_webhook_secret=${STRIPE_WEBHOOK_SECRET}" \
  		-var="teams_webhook_url=${TEAMS_WEBHOOK_URL}"

plan:
	terraform plan -var="project_id=$(PROJECT_ID)" -var="env=$(ENV)" \
		-var="stripe_secret_key=${STRIPE_SECRET_KEY}" \
  		-var="stripe_webhook_secret=${STRIPE_WEBHOOK_SECRET}" \
  		-var="teams_webhook_url=${TEAMS_WEBHOOK_URL}"

apply:
	terraform apply -var="project_id=$(PROJECT_ID)" -var="env=$(ENV)" \
		-var="stripe_secret_key=${STRIPE_SECRET_KEY}" \
  		-var="stripe_webhook_secret=${STRIPE_WEBHOOK_SECRET}" \
  		-var="teams_webhook_url=${TEAMS_WEBHOOK_URL}"

certificate-status:
	gcloud compute ssl-certificates describe virtualbusinessmailbox-com-cert --global --project=virtualbusinessmailbox --format='value(managed.status)'

benchmark:
	npx lighthouse https://virtualbusinessmailbox.com --only-categories=performance,seo,accessibility --view

auth:
	gcloud auth login
	gcloud auth application-default login

