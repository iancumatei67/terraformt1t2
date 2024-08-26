resource "google_compute_network" "vpc_miancu" {
  name                    = "miancu-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "miancu_public_subnet" {
  name          = "miancu-public-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_miancu.name
}

resource "google_compute_subnetwork" "miancu_private_subnet" {
  name          = "miancu-private-subnetwork"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west1"
  network       = google_compute_network.vpc_miancu.name
  private_ip_google_access = true 
}

resource "google_compute_firewall" "k8s-firewall" {
  name    = "kubernetes-firewall"
  network = google_compute_network.vpc_miancu.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "9411", "30001", "30002", "31601"]
  }

  source_ranges = ["193.109.103.128/32","83.142.187.20/32"]
  
}


resource "google_compute_router" "nat_router" {
  name    = "miancu-nat-router"
  network = google_compute_network.vpc_miancu.name
  region  = "europe-west1"
}

resource "google_compute_router_nat" "nat_gw" {
  name                               = "nat-gateway"
  router                             = google_compute_router.nat_router.name
  region                             = "europe-west1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.miancu_private_subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}