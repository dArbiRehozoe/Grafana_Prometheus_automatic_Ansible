resource "google_compute_instance" "grafana" {
  name                      = "grafana"
  hostname                  = var.hostnamegrafana
  machine_type              = "e2-standard-2"
  project                   = var.gcp_project
  zone                      = var.gcp_zone

  scheduling {
    preemptible       = true
    automatic_restart = false
  }
 allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = var.image
      size  = 50
      type  = "pd-standard"
    }
  }
  labels = {
    environment = "grafana"
  }
  metadata = {
    enable-oslogin = "TRUE"
  }
  
  tags = ["http-server", "https-server", "lb-health-check"]

  network_interface {
    network = "default" 
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

}


