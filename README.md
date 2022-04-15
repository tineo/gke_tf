gke_tf
######

gcloud init

gcloud services enable compute.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable servicenetworking.googleapis.com

# create a service account

gcloud iam service-accounts create <service-account-name>

# grant the necessary roles for our service account to create a GKE cluster and the associated resources

gcloud projects add-iam-policy-binding <project-name> --member serviceAccount:<service-account-name>@<project-name>.iam.gserviceaccount.com --role roles/compute.admin
gcloud projects add-iam-policy-binding <project-name> --member serviceAccount:<service-account-name>@<project-name>.iam.gserviceaccount.com --role roles/iam.serviceAccountUser
gcloud projects add-iam-policy-binding <project-name> --member serviceAccount:<service-account-name>@<project-name>.iam.gserviceaccount.com --role roles/resourcemanager.projectIamAdmin
gcloud projects add-iam-policy-binding <project-name> --member serviceAccount:<service-account-name>@<project-name>.iam.gserviceaccount.com --role roles/container.admin
 

# create and download a key file that Terraform will use to authenticate as the service account against the Google Cloud Platform API

gcloud iam service-accounts keys create terraform-gkecluster-keyfile.json --iam-account=<service-account-name>@<project-name>.iam.gserviceaccount.com

# Terraform state in Google Cloud Storage

gsutil mb -p <project-name> -c regional -l <location> gs://<bucket-name>/

# activate object versioning to allow for state recovery

gsutil versioning set on gs://<bucket-name>/

#  grant read / write permissions on this bucket to our service account

gsutil iam ch serviceAccount:<service-account-name>@<project-name>.iam.gserviceaccount.com:legacyBucketWriter gs://<bucket-name>/

# Edit bucket name in terraform.tf then 

terraform init

# Edit names in variables.auto.tfvars then 

terraform plan

terraform apply -auto-approve

# After the cluster is created 

gcloud container clusters list

gcloud container clusters get-credentials gke-cluster  --region <region>