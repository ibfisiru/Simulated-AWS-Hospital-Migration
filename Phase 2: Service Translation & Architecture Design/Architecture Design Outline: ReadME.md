	## Phase 2: Service Translation & Architecture Design
      This phase builds on phase 1 and focuses on mapping the operational needs to select the best-suited services from the many that AWS offers.
	## VPC Creation:
					□ The goal to ensure strong network isolation and management, so there will be 3 VPC's for:
						◊ The main hospital site 
						◊ The management site
						◊ The DR site
				  □ On-Prem Locations:
				  	◊ Outpatient Clinic
					  ◊ Satellite location 1
					  ◊ Satellite location 2

			






	## Services To Use 
       □ Connecting The Cloud Environment To The On-Prem Locations:
					- Both the VPC's and on-prem sites will all be linked AWS Transit Gateway
					- Why AWS Transit Gateway?
						◊ It provides consistent network design which makes for easier network management
						◊ Uniform security configuration
						◊ Designed for architectures that demand low-latency & demand high-security
						◊ Higher cost compared to site-to-site VPN but is more reliable

					□ To manage the on-prem servers and update them via SSH:
						  ◊ Use AWS Systems Manager
              ◊ The SSH protocol is chose as it can be disabled when maintenance is completed on the sever

					□ For automated data transfer between on-prem and AWS services like S3AWS DataSync:
						  ◊ For automated data transfer between on-prem and AWS services like S3
			
          □ For Monitoring & Alerts:
						  ◊ Setup CloudWatch agents on the on-prem and cloud servers
					
          □ IAM:
						◊ Needs to be combined with on-premises AD to allow access to the cloud resources
			
			
			

				
		A) In Main Hospital Site VPC:
		○ VPC: 10.0.0.0
		○ Public Subnets:
			§ ONLY for the internet-facing load balancers and NAT gateways. This separates the part of the network receiving public traffic from sensitive resources
			§ One subnet per AZ
			§ CIDR range: 10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24

		○ Private Application Subnet:
			§ For the Cerner HER servers & clinical applications
			§ One subnet per AZ
			§ CIDR range suggestion: 10.0.10.0/24, 10.0.11.0/24, 10.0.12.0/24
			
		○ Private Database Subnets:
			§ For the database servers and storage of sensitive data
			§ One subnet per AZ
			§ CIDR range suggestion: 10.0.20.0/24, 10.0.21.0/24, 10.0.22.0/24
	
		B) In Management Site/VPC:
			○ VPC: 10.2.0.0/16
			○ Deployed in 2 AZ's
			○ Public Subnets:
				§ Has Internet Gateway to manage traffic for server updates,etc
				§ Has a NAT gateway for outgoing traffic
				§ Subnet is 10.2.0.0/24
			○ Private Admin Subnets:
				§ For administrative servers and monitoring systems like:
					□ Domain controllers for AD services
					□ Admin jump servers that the IT team uses to manage other sustems securely
					□ System Admin tools like the management servers, patch management systems, and ITSM tools that track and manage IT incidents across the network
					□ Backup management servers and consoles like those that manage the on-prem backups during the migration, and cloud-based backups after the migration
				§ One subnet per AZ (2 AZ's)
				§ CIDR range for the privat subnet:
					□  10.2.10.0/24
				§ Crea
			○ Create A Internet Gateway:
				§ Connect public route tables in both AZ's
			○ Create NAT Gateway For Private Subnet Internet Access:
				§ Create one for each private subnet for both AZ's
		
		C) In DR Site (Same as Main Hospital Site + Backup Management Servers):
			§ VPC: 10.1.0.0/16
			§ Public Subnets:
				§ ONLY for the internet-facing load balancers and NAT gateways. This separates the part of the network receiving public traffic from sensitive resources
				§ One subnet per AZ
				§ CIDR range: 10.0.0.0/24, 10.0.1.0/24, 10.0.2.0/24
	
			○ Backup Application Subnet:
				§ For the Cerner HER servers & clinical applications
				§ One subnet per AZ
				§ CIDR range suggestion: 10.0.10.0/24, 10.0.11.0/24, 10.0.12.0/24
				
			○ Backup Database Subnets:
				§ For the database servers and storage of sensitive data
				§ One subnet per AZ
				§ CIDR range suggestion: 10.0.20.0/24, 10.0.21.0/24, 10.0.22.0/24
			
			○ Backup Admin Subnets:
				§ For administrative servers and tools and monitoring systems like:
					□ Domain controllers for AD services
					□ Admin jump servers that the IT team uses to manage other sustems securely
					□ System Admin tools like the management servers, patch management systems, and ITSM tools that track and manage IT incidents across the network
					□ Backup management servers and consoles like those that manage the on-prem backups during the migration, and cloud-based backups after the migration
				§ One subnet per AZ
				§ CIDR range suggestion: 10.0.30.0/24, 10.0.31.0/24, 10.0.32.0/24
			
			
		C) 2 Satellite Locations (Connects to Transit Gateway via Direct Connect):
			○ The 2 satellite locations need to access the following within AWS:
				§ Cerner EHRs app
				§ App DB
				§ Send monitoring data to CloudWatch
					□ Install CloudWatch agents on the on-prem servers
				§ Stored backups of the on-prem servers within AWS
			○ Network Infrastructure:
				§ Routers for Direct Connect connectivity
				§ Internal switches
				§ Firewalls
				§ Local DNS servers
			○ Servers (Compute):
				§ Local app servers
				§ Local DB servers
				§ Files servers
				§ Print servers
				§ Local domain controllers
			○ Workstations:
				§ Clinical workstations: 
					□ Used by clinical staff to access the EHR System
				§ Administrative workstations:
					□ Used by the admin staff for tasks like scheduling, billing, and other admin functions
			○ Medical Devices (Imaging):
				§ Blood pressure
				§ Scales
				§ x-ray
				§ Ultrasound
				
			
		D) 1 Outpatient Clinic (Connects to transit gateway via Direct Connect):
			○ Servers:
				□ 2 servers handling core apps (limited version of EHRn so no DB)
			○ Network:
				□ A router, switch, and firewall
			○ Workstations:
				□ For clinical staff
			○ Medical devices:
				□ Blood pressure
				□ Scales
				□ x-ray
Ultrasound
