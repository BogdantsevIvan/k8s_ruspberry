 variable "image-id" {
     type = string
 }

 variable "OAuth-token" {
     type = string
 }

 variable "cloud-id" {
     type = string
 }

variable "folder-id" {
     type = string
 }

 variable "Vms-count" {
     type = number 
 }

 terraform {
   required_providers {
     yandex = {
       source = "yandex-cloud/yandex"
     }
   }
 }
 
 provider "yandex" {
   token     =  var.OAuth-token
   cloud_id  = var.cloud-id
   folder_id = var.folder-id
   zone      = "ru-central1-a"
 }


resource "yandex_compute_instance" "vms" {
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
  count       = var.Vms-count
  name        = "from-terraform-vm${count.index}"

  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = var.image-id
    }
  }
 
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }
 
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}
 
resource "yandex_vpc_network" "network" {
  name = "from-terraform-network"
}
 
resource "yandex_vpc_subnet" "subnet" {
  name           = "from-terraform-subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network.id}"
  v4_cidr_blocks = ["10.2.0.0/16"]
}
 
output "external_ip" {
  value = yandex_compute_instance.vms.*.network_interface.0.nat_ip_address
}