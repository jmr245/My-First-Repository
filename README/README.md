### Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.
- (Images/Network-Diagram.png) 

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the entire deployment pictured above. Alternatively, select portions of the YAML file may be used to install only certain pieces of it, such as Filebeat.
- elkplay.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly reliable, in addition to restricting overflow to the network.
- Load balancers protect the availability aspect of the CIA security model.  They ensure the stability and reliability of the system/servers by making
  sure one system/server is not overloaded with traffic, resulting in a failure/shutdown.  The advantage of having a Jump Box is that it allows for you
  to access and manage devices in a separate security zone.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
- Filebeat is used for collecting data about the file system and logs.
- Metricbeat is used for collecting machine metrics, such as uptime, cpu usage, etc.

The configuration details of each machine may be found below.

| Name                 | Function | IP Address | Operating System |
|----------------------|----------|------------|------------------|
| Jump-Box-Provisioner | Gateway  | 10.0.0.7   | Linux            |
| Web-2                | DVWA     | 10.0.0.6   | Linux            |
| Web-1                | DVWA     | 10.0.0.5   | Linux            |
| First-Project-VM     | ELK      | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box-Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 172.119.196.192/32

Machines within the network can only be accessed by the Jump-Box-Provisioner.
- Jump-Box-Provisioner IP: 13.64.131.13 / 10.0.0.7

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IP Addresses    |
|----------------------|---------------------|-------------------------|
| Jump-Box-Provisioner | Yes                 | 172.119.196.192/32      |
| Web-2                | No                  | 13.64.131.13 / 10.0.0.7 |
| Web-1                | No                  | 13.64.131.13 / 10.0.0.7 |
| First-Project-VM     | No                  | 13.64.131.13 / 10.0.0.7 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- The main advantage to using ansible to configure a machine (ELK, etc.) is that it automates the tasks required for proper installation.  Thus, it saves time for the admin/worker and allows 
  them to work on other high priority work.  Ansible is also simple and easy to use, as well as makes for better workflow. 

The playbook implements the following tasks:
- Install docker.io
- Install Docker module
- Download and launch a docker elk container
- Enable service docker on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
- (Images/docker-ps-output.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1, Web-2

We have installed the following Beats on these machines:
- Filebeat, Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects data about the file system/logs.  By performing multiple ssh logins with an incorrect username, I was able to monitor and examine all failed login attempts via Kibana, thanks to Filebeat.
- Metricbeat collects machine metrics like uptime, cpu usage, and more.  With Metricbeat installed I was able to monitor each machine's cpu usage, and by running a stress test on each machine I could
  see the percentage of cpu usage by each machine during the stress test, thus proving it was functioning properly and showing accurate data. 

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the elkplay.yml file to /etc/ansible.  I recommend placing filebeat-playbook.yml and metricbeat-playbook.yml in the roles/ directory.
- Update the hosts file to include the IP addresses of the webservers and elk server VM's.  
  - Under [webservers] include:
   - 10.0.0.5 ansible_python_interpreter=/usr/bin/python3
   - 10.0.0.6 ansible_python_interpreter=/usr/bin/python3
  - Under [elk] include: 
   - 10.1.0.4 ansible_python_interpreter=/usr/bin/python3
- Run the playbook, and navigate to http://13.68.168.59:5601/app/kibana to check that the installation worked as expected.

### Commands For Running Playbooks & Updating
- For updating the hosts file use 'nano' or 'vi' (As well as for editing playbooks).
- For running the playbook: ansible-playbook <playbook> 
