resource "google_container_cluster" "selenium_grid" {
  name = "selenium-grid"

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "selenium" {
  name       = "selenium"
  cluster    = "${google_container_cluster.selenium_grid.name}"
  node_count = 1
}
