
variable "instance_name" {
  type        = string
  default     = "example-machine"
  description = "GCP Network Name. [Oficial GCP Documentation](https://cloud.google.com/compute/docs/machine-types) - [Terraform provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#machine_type)"
}

variable "project_region" {
  type        = string
  default     = "us-west1"
  description = "GCP Network Name. [Oficial GCP Documentation](https://cloud.google.com/compute/docs/machine-types) - [Terraform provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#machine_type)"
}

variable "google_project" {
  type      = string
  sensitive = true
  default   = ""
}

variable "network_name" {
  type    = string
  default = "gcp-network"
}

variable "instance_ipv4_name" {
  type    = string
  default = "ipv4-instance-gcp"
}

variable "gcp_project_id" {
  type      = string
  sensitive = true
}

variable "bucket_name" {
  type        = string
  default     = "my-bucket"
  description = "Your instance's network on GCP."
}

variable "permissions" {
  type        = string
  default     = "publicread"
  description = "Your instance's network on GCP."
}

variable "firestore_name" {
  type        = string
  default     = "firestore-db-1"
  description = "Your instance's network on GCP."
}
