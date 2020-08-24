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
        "DEBIAN_FRONTEND='noninteractive' apt install puppet -y curl",
        "DEBIAN_FRONTEND='noninteractive' curl -L https://omnitruck.chef.io/install.sh | bash -s -- -P inspec"
    ]
  }

  provisioner "puppet-masterless" {
      manifest_file     = "config/app.pp"
      prevent_sudo      = true
      guest_os_type     = "unix"
      ignore_exit_codes = true
  }

  provisioner "inspec" {
    inspec_env_vars = ["CHEF_LICENSE=accept"]
    profile         = "https://github.com/dev-sec/cis-dil-benchmark/blob/master/inspec.yml"
  }

  post-processor "docker-tag" {
    repository = "raygervais/ubuntu-packer-build"
    tags       = ["1.0"]
  }
}
