variable "instance_name" {}
variable "instance_zone" {}
variable "instance_type" {}
variable "instance_subnetwork" {}
variable "instance_network" {}
variable "instance_network_ip" {
  default = ""
}
variable "deletion_protection" {
  default = false
}
variable "instance_service_account_scopes" {}
variable "instance_service_account_email" {
  default = ""
}
variable "instance_desired_status" {
  type        = string
  description = "desired_status - (Optional) Desired status of the instance. RUNNING or TERMINATED"
  default     = ""
}
variable "instance_boot_sourceImage" {}
variable "instance_tags" {}
variable "instance_boot_diskType" {
  description = "Set the disk type for the instance boot disk. Possible values are 'pd-standard', 'pd-balanced' or 'pd-ssd'"
}
variable "instance_boot_diskSizeGb" {}
variable "instance_boot_disklabels" {
  default = {}
}
variable "instance_boot_diskautodelete" {
  default = true
  description = "Whether the boot disk will be auto-deleted when the instance is deleted"
}
variable "instance_access_config" {
  description = "Allocate a one-to-one NAT IP to the instance"
  default     = {}
}
variable "instance_ssh_user" {}
variable "instance_ssh_key_path" {}
variable "instance_ssh_pub_key_file" {}
variable "instance_ssh_priv_key_file" {}
variable "ansible_vm_ssh_user" {
  default = ""
}
variable "ansible_vm_ssh_priv_key_file" {
  default = ""
}
variable "ansible_vm_instance_ip" {
  default = ""
}
variable "instance_labels" {
  description = " A map of key/value label pairs to assign to the instance."
  default     = {}
}
