ENV=dev
PROJECT_ID=joshuampeck
GOOGLE_APPLICATION_CREDENTIALS=~/.config/gcloud/application_default_credentials.json

export $(cat ../.env | xargs)

.SILENT: refresh plan apply

refresh:
	terraform refresh  -var="project_id=$(PROJECT_ID)" -var="env=$(ENV)" 

plan:
	terraform plan -var="project_id=$(PROJECT_ID)" -var="env=$(ENV)" 

apply:
	terraform apply -var="project_id=$(PROJECT_ID)" -var="env=$(ENV)" 

certificate-status:
	gcloud compute ssl-certificates describe joshuampeck-com-cert --global --project=joshuampeck --format='value(managed.status)'

benchmark:
	npx lighthouse https://joshuampeck.com --only-categories=performance,seo,accessibility --view

auth:
	gcloud auth login
	gcloud auth application-default login

