source "docker" "ubuntu" {
  image   = "ubuntu:20.04"
  commit  = true
}

build {
  sources = [
    "source.docker.ubuntu",
  ]

  provisioner "shell" {
    inline = [
        "apt update -y",
        "DEBIAN_FRONTEND='noninteractive' apt install puppet -y",
        "puppet module install hardening-os_hardening",
    ]
  }

  provisioner "puppet-masterless" {
      manifest_file     = "config/users.pp"
      prevent_sudo      = true
      guest_os_type     = "unix"
      ignore_exit_codes = true
  }

  provisioner "puppet-masterless" {
      manifest_file     = "config/hardening.pp"
      prevent_sudo      = true
      guest_os_type     = "unix"
      ignore_exit_codes = true
  }

  provisioner "inspec" {
    inspec_env_vars = ["CHEF_LICENSE=accept"]
    profile         = "https://github.com/dev-sec/linux-baseline"
    extra_arguments = [ "--no-distinct-exit" ]
  }

  provisioner "inspec" {
    inspec_env_vars = ["CHEF_LIENCSE=accept"]
    profile         = "tests/"
  }

  provisioner "shell" {
    inline = [
        "apt remove puppet -y",
        "apt autoremove -y",
    ]
  }

  post-processor "docker-tag" {
    repository = "raygervais/ubuntu-packer-build"
    tags       = ["1.0"]
  }
}
