build {
  name = "github-actions-runner-images"
  
  sources = [
    "source.openstack.image"
  ]

  provisioner shell {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = [
      "mkdir ${var.image_folder}",
      "chmod 777 ${var.image_folder}"
    ]
  }

  provisioner file {
    destination = "${var.helper_script_folder}"
    source      = "${local.scripts_path}/helpers"
  }

  provisioner shell {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${local.scripts_path}/build/configure-apt-mock.sh"
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "DEBIAN_FRONTEND=noninteractive"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/install-ms-repos.sh",
      "${local.scripts_path}/build/configure-apt-sources.sh",
      "${local.scripts_path}/build/configure-apt.sh"
    ]
  }

  provisioner shell {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    script          = "${local.scripts_path}/build/configure-limits.sh"
  }

  provisioner file {
    destination = "${var.installer_script_folder}"
    source      = "${local.scripts_path}/build"
  }

  provisioner file {
    destination = "${var.image_folder}"
    sources     = [
      "${local.assets_path}/post-gen",
      "${local.scripts_path}/tests",
      "${local.scripts_path}/docs-gen"
    ]
  }

  provisioner file {
    destination = "${var.image_folder}/docs-gen/"
    source      = "${local.common_helpers_path}/software-report-base"
  }

  provisioner file {
    destination = "${var.installer_script_folder}/toolset.json"
    source      = "${local.toolsets_path}/toolset-2404.json"
  }

  provisioner shell {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    inline          = [
      "mv ${var.image_folder}/docs-gen ${var.image_folder}/SoftwareReport",
      "mv ${var.image_folder}/post-gen ${var.image_folder}/post-generation"
    ]
  }

  provisioner shell {
    environment_vars = [
      "IMAGE_VERSION=${var.image_version}",
      "IMAGEDATA_FILE=${var.imagedata_file}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/configure-image-data.sh"
    ]
  }

  provisioner shell {
    environment_vars = [
      "IMAGE_VERSION=${var.image_version}",
      "IMAGE_OS=${var.image_os}",
      "HELPER_SCRIPTS=${var.helper_script_folder}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/configure-environment.sh"
    ]
  }

  provisioner shell {
    environment_vars = [
      "DEBIAN_FRONTEND=noninteractive",
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/install-apt-vital.sh"
    ]
  }

provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/install-powershell.sh"
    ]
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} pwsh -f {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/Install-PowerShellModules.ps1",
      "${local.scripts_path}//build/Install-PowerShellAzModules.ps1"
    ]
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}",
      "DEBIAN_FRONTEND=noninteractive"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/install-actions-cache.sh",
      "${local.scripts_path}/build/install-runner-package.sh",
      "${local.scripts_path}/build/install-apt-common.sh",
      "${local.scripts_path}/build/install-azcopy.sh",
      "${local.scripts_path}/build/install-azure-cli.sh",
      "${local.scripts_path}/build/install-azure-devops-cli.sh",
      "${local.scripts_path}/build/install-bicep.sh",
      "${local.scripts_path}/build/install-apache.sh",
      "${local.scripts_path}/build/install-aws-tools.sh",
      "${local.scripts_path}/build/install-clang.sh",
      "${local.scripts_path}/build/install-cmake.sh",
      "${local.scripts_path}/build/install-codeql-bundle.sh",
      "${local.scripts_path}/build/install-container-tools.sh",
      "${local.scripts_path}/build/install-dotnetcore-sdk.sh",
      "${local.scripts_path}/build/install-gcc-compilers.sh",
      "${local.scripts_path}/build/install-gfortran.sh",
      "${local.scripts_path}/build/install-git.sh",
      "${local.scripts_path}/build/install-git-lfs.sh",
      "${local.scripts_path}/build/install-github-cli.sh",
      "${local.scripts_path}/build/install-google-chrome.sh",
      "${local.scripts_path}/build/install-haskell.sh",
      "${local.scripts_path}/build/install-java-tools.sh",
      "${local.scripts_path}/build/install-kubernetes-tools.sh",
      "${local.scripts_path}/build/install-miniconda.sh",
      "${local.scripts_path}/build/install-mysql.sh",
      "${local.scripts_path}/build/install-nginx.sh",
      "${local.scripts_path}/build/install-nodejs.sh",
      "${local.scripts_path}/build/install-bazel.sh",
      "${local.scripts_path}/build/install-php.sh",
      "${local.scripts_path}/build/install-postgresql.sh",
      "${local.scripts_path}/build/install-pulumi.sh",
      "${local.scripts_path}/build/install-ruby.sh",
      "${local.scripts_path}/build/install-rust.sh",
      "${local.scripts_path}/build/install-julia.sh",
      "${local.scripts_path}/build/install-selenium.sh",
      "${local.scripts_path}/build/install-vcpkg.sh",
      "${local.scripts_path}/build/configure-dpkg.sh",
      "${local.scripts_path}/build/install-yq.sh",
      "${local.scripts_path}/build/install-android-sdk.sh",
      "${local.scripts_path}/build/install-pypy.sh",
      "${local.scripts_path}/build/install-python.sh",
      "${local.scripts_path}/build/install-zstd.sh"
    ]
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}",
      "DOCKERHUB_PULL_IMAGES=NO"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/install-docker.sh"
    ]
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} pwsh -f {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/Install-Toolset.ps1",
      "${local.scripts_path}/build/Configure-Toolset.ps1"
    ]
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/install-pipx-packages.sh"
    ]
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}",
      "DEBIAN_FRONTEND=noninteractive",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"
    ]
    execute_command  = "/bin/sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/install-homebrew.sh"
    ]
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPTS=${var.helper_script_folder}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/configure-snap.sh"
    ]
  }

  provisioner shell {
    execute_command   = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    expect_disconnect = true
    inline            = [
      "echo 'Reboot VM'",
      "sudo reboot"
    ]
  }

  provisioner shell {
    execute_command     = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    pause_before        = "1m0s"
    scripts             = [
      "${local.scripts_path}/build/cleanup.sh"
    ]
    start_retry_timeout = "10m"
  }

  provisioner shell {
    environment_vars = [
      "IMAGE_VERSION=${var.image_version}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}"]
    inline           = [
      "pwsh -File ${var.image_folder}/SoftwareReport/Generate-SoftwareReport.ps1 -OutputDirectory ${var.image_folder}",
      "pwsh -File ${var.image_folder}/tests/RunAll-Tests.ps1 -OutputDirectory ${var.image_folder}"
    ]
  }

  provisioner file {
    destination = "${path.root}/../Ubuntu2404-Readme.md"
    direction   = "download"
    source      = "${var.image_folder}/software-report.md"
  }

  provisioner file {
    destination = "${path.root}/../software-report.json"
    direction   = "download"
    source      = "${var.image_folder}/software-report.json"
  }

  provisioner shell {
    environment_vars = [
      "HELPER_SCRIPT_FOLDER=${var.helper_script_folder}",
      "INSTALLER_SCRIPT_FOLDER=${var.installer_script_folder}",
      "IMAGE_FOLDER=${var.image_folder}"
    ]
    execute_command  = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    scripts          = [
      "${local.scripts_path}/build/configure-system.sh"
    ]
  }

  provisioner shell {
    execute_command = "sudo sh -c '{{ .Vars }} {{ .Path }}'"
    #inline          = ["sleep 30", "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    inline          = ["sleep 30", "export HISTSIZE=0 && sync"]
  }

}
