resource "google_container_cluster" "sockshop" {
  name     = "miancu-cluster"
  location = "europe-west1"
  remove_default_node_pool = false
  network    = "miancu-network"
  subnetwork = "miancu-public-subnetwork"

  node_pool {
    name       = "default"
    node_count = 1
    management {
      auto_repair  = false
      auto_upgrade = false
    }
    node_config {
      preemptible  = false
      machine_type = "n1-standard-1"
    }
  }
}
resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.sockshop.name
  location   = google_container_cluster.sockshop.location
  node_count = 2

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

  }
}

