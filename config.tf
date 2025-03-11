terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.76.1"
    }
  }
}

variable "api_key" {
  type = string
}

variable "sm_instance_id" {
  type = string
}

variable "sm_instance_crn" {
  type = string
}

variable "iks_cluster_id" {
  type = string
}

provider "ibm" {
  ibmcloud_api_key = var.api_key
}

resource "ibm_sm_arbitrary_secret" "sm_arbitrary_secret" {
  name          = "secret-name"
  instance_id   = var.sm_instance_id
  region        = "eu-gb"
  custom_metadata = {"key":"value"}
  payload = "secret-credentials"
}

resource "ibm_container_ingress_instance" "instance" {
  cluster = var.iks_cluster_id
  instance_crn = var.sm_instance_crn
  is_default = true
}
