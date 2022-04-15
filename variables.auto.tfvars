credentials        = "./terraform-gkecluster-keyfile.json"
project_id         = "<project-name>"
region             = "<region>"
zones              = ["<region>-a"]
name               = "gke-cluster"
machine_type       = "<machine_type>"
min_count          = 1
max_count          = 3
disk_size_gb       = 10
service_account    = "<service-account-name>@<project-name>.iam.gserviceaccount.com"
initial_node_count = 3