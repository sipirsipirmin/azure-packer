source "azure-arm" "azure-k8s-environment" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  
  managed_image_resource_group_name = var.managed_image_resource_group_name
  managed_image_name = "base-node-{{ timestamp }}"

  os_type = "Linux"
  image_publisher = "Canonical"
  image_offer = "UbuntuServer"
  image_sku = "18.04-LTS"
  
  location = var.location
  vm_size = var.vm_size
  
  disk_additional_size = [10]
}

build {
  sources = ["sources.azure-arm.azure-k8s-environment"]
  
  provisioner "file" {
    source = "./files/k8s-sysctl.conf"
    destination = "/tmp/k8s.conf"
  }
  
  provisioner "shell" {
    inline = [
      // docker data disk mount operation
         "sudo parted /dev/sda --script mklabel gpt mkpart xfspart xfs 0% 100%",
         "sudo mkfs.xfs -L docker_data /dev/sda1",
         "sudo partprobe /dev/sda1",
         "sudo mkdir -p /var/lib/docker",
         "sudo mount -L docker_data /var/lib/docker",
         "sudo sh -c \"echo 'LABEL=docker_data /var/lib/docker xfs   defaults,nofail   1   2' >> /etc/fstab\"",
         "sudo mount -a",
      // k8s & docker prerequirements
         "sudo apt-get update",
         "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release",
         "sudo sh -c \"echo 'br_netfilter' >> /etc/modules-load.d/k8s.conf\"",
         "sudo cp /tmp/k8s.conf /etc/sysctl.d/k8s.conf",
         "sudo sysctl --system"
    ]
  }
}
