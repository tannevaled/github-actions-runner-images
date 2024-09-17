locals {
  repo_path = "${path.root}../.."
  provisioner_path = "${local.repo_path}/.provisioner"
  scripts_path = "${local.provisioner_path}/images/ubuntu/scripts"
  assets_path  = "${local.provisioner_path}/images/ubuntu/assets"
  toolsets_path = "${local.provisioner_path}/images/ubuntu/toolsets"
  helpers_path = "${local.provisioner_path}/images/ubuntu/helpers"
  common_helpers_path = "${local.provisioner_path}/helpers"
  #managed_image_name = var.managed_image_name != "" ? var.managed_image_name : "packer-${var.image_os}-${var.image_version}"
  managed_image_name = "packer-${var.SYSTEM_DISTRIBUTION_NAME}-${var.SYSTEM_DISTRIBUTION_VERSION_NUMBER}"
}
