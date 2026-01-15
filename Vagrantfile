Vagrant.configure("2") do |config|
  # Configuration commune pour toutes les VMs
  config.vm.box = "ubuntu/focal64"  # Ubuntu 20.04 LTS

  # VM1 : Jenkins Master
  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = "jenkins"
    jenkins.vm.network "private_network", ip: "192.168.56.10"
    jenkins.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"  # 2GB RAM
      vb.cpus = 2
    end
    # Provisioning : Installer Jenkins, Java, Maven, Docker, Git
    jenkins.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y openjdk-11-jdk maven git docker.io
      sudo systemctl start docker
      sudo systemctl enable docker
      sudo usermod -aG docker vagrant
      # Installer Jenkins
      curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
      echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
      sudo apt-get update
      sudo apt-get install -y jenkins
      sudo systemctl start jenkins
      sudo systemctl enable jenkins
    SHELL
  end

  # VM2 : Deployment Server
  config.vm.define "deploy" do |deploy|
    deploy.vm.hostname = "deploy"
    deploy.vm.network "private_network", ip: "192.168.56.11"
    deploy.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"  # 1GB RAM
      vb.cpus = 1
    end
    # Provisioning : Installer Docker et Git (pour pull les images si besoin)
    deploy.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y docker.io git
      sudo systemctl start docker
      sudo systemctl enable docker
      sudo usermod -aG docker vagrant
    SHELL
  end
end