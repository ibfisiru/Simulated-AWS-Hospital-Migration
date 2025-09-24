Phase 2: Mapping AWS Services to Design Considerations
 
## This phase focuses on the Architecture Design, mapping operational needs to select the best-suited services from the many that AWS offers. I used the AWS Well-Architected Framework to guide service selection/architecture design. Here are the selections for this simulation:

## VPC Setup:
 	□ Designed 3 logically isolated VPCs to separate traffic for:
		◊ The main hospital site 
		◊ The management site
		◊ The DR site
	 □ On-Prem Locations:
	  	◊ Outpatient Clinic
	  	◊ Satellite location 1
		◊ Satellite location 2

 
## For Compute Services:
	The on-prem workloads were mapped to these EC2 instance types:
	* R6i (memory-optimized instances): For EHR database servers. Lower cost-per-GB and better memory performance than R5
	* C6i (compute-optimized): For the app servers
	* M6i (general purpose): For support services
	* Auto Scaling Groups: For demand fluctuations
 
## For Storage:
	* EBS volumes with provisioned IOPS instead of general purpose SSD for critical DBs
	* S3 Intelligent-Tiering for PACS imaging
	* FSx for Windows File Server to replace legacy shares
	* S3 Glacier service for long-term archives
	* AWS Backup to centralize backups
 
## For Networking:
	* Transit Gateway: For its hub-and-spoke structure, used instead of VPC peering to connect VPCs and on-prem (more expensive but better suited for a hospital network)
	* Route 53, ALBs, Shield, and WAF: For DNS and traffic control/protection
	* AWS NAT Gateway: For outbound-only internet access for private subnets
	* AWS Systems Manager: To manage and patch the EC2 instances remotely

 
## For Security & Compliance:
	* Mapped controls to support HIPAA and Zero Trust adherence:
	* AWS IAM + on-prem AD integration
	* KMS for key management: CloudHSM: For hardware encryption
	* Security Hub, GuardDuty, CloudTrail: For monitoring and logging
 
## Database Considerations For Oracle DBs:
	* RDS minimizes operational overhead but also limits customization
	* EC2 provides full control, enables fine-grained IAM policies, encrypted EBS volumes, and custom configurations

## Resilience & DR Planning:
	* DR region will be located in US-East-2, an active-passive setup (slower failover compared to an active-active setup but costs for resource reservation is lower)
	* Only critical workloads are replicated in the DR site
	* Used S3 tiering and automated RDS snapshots to cut storage and deployment costs


## Connecting The Cloud Environment To The On-Prem Locations:
	* Both the VPCs and on-prem sites will all be linked through AWS Transit Gateway
	 	- Why AWS Transit Gateway?
	   		◊ It provides consistent network design which makes for easier network management
	    	◊ Uniform security configuration
	    	◊ Designed for architectures that demand low-latency & demand high-security
	    	◊ Higher cost compared to site-to-site VPN but is more reliable

## To manage the on-prem servers and update them via SSH:
	* Use AWS Systems Manager
         - The SSH protocol is chosen as it can be disabled when maintenance is completed on the server

			
## For Monitoring & Alerts:
	* Setup CloudWatch agents on the on-prem and AWS servers for unified monitoring and alerting
		
