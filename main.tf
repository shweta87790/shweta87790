resource "google_compute_instance" "test-build" {
  project                   = "Internal POCs- Cloud Team"
  name                      = "linux-amey"
  machine_type              = "e2-medium"
  zone = "asia-south1-c"
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20230918"
    }
  }
  network_interface {
    subnetwork         = "default"
    subnetwork_project = "default"
    access_config      = {}
  }
  metadata {
    ssh-keys = "jon:${{secrets.DEPLOY_KEY}}"
  }

provisioner "file" {
  source = "HelloWorld.py"
  destination = "/"

  connection {
    type = "ssh"
    user = "amey123"
    private_key = "${{secrets.PublicKey}}"
    agent = "false"
  }
}
}
