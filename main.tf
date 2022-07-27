terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "^4.0.0"
    }
  }
}

resource "google_compute_instance" "gce-instance" {
  name         = var.instance_name
  zone         = var.instance_zone
  machine_type = var.instance_type

  tags                      = var.instance_tags
  allow_stopping_for_update = true
  deletion_protection       = var.deletion_protection
  desired_status            = var.instance_desired_status
  labels                    = var.instance_labels

  boot_disk {
    auto_delete = var.instance_boot_diskautodelete
    initialize_params {
      image  = var.instance_boot_sourceImage
      type   = var.instance_boot_diskType
      size   = var.instance_boot_diskSizeGb
      labels = var.instance_boot_disklabels
    }
  }

  network_interface {
    network    = var.instance_network
    subnetwork = var.instance_subnetwork
    network_ip = var.instance_network_ip
    dynamic "access_config" {
      for_each = [var.instance_access_config]
      content {
        nat_ip = lookup(access_config.value, "nat_ip", null)
      }
    }
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

  metadata = {
    ssh-keys = "${var.instance_ssh_user}:${file("${var.instance_ssh_key_path}${var.instance_ssh_pub_key_file}")}"
  }

  ## https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes
  service_account {
    email  = var.instance_service_account_email
    scopes = var.instance_service_account_scopes
  }
}

resource "null_resource" "ansible_ssh_setup" {
  count      = var.run_ansible_ssh ? 1 : 0
  depends_on = [google_compute_instance.gce-instance]

  # ansible ssh keys transfer
  connection {
    type        = "ssh"
    host        = var.ansible_vm_instance_ip
    user        = var.ansible_vm_ssh_user
    timeout     = "100s"
    private_key = file("${var.instance_ssh_key_path}${var.ansible_vm_ssh_priv_key_file}")
  }

  provisioner "file" {
    source      = "${var.instance_ssh_key_path}${var.instance_ssh_priv_key_file}"
    destination = "${var.instance_ssh_key_path}${var.instance_ssh_priv_key_file}"
  }
}
