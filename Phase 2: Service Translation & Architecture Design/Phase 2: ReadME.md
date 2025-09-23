Mapping AWS Services to Design Considerations
 
## This phase focuses on the Architecture Design, mapping operational needs to select the best-suited services from the many that AWS offers. This diagram from Post 1 illustrates the foundation these services map to. I used the AWS Well-Architected Framework to guide service selection. Here are the selections for this simulation:
 
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
* AWS Direct Connect: Instead of VPN for low latency
* Transit Gateway: For its hub-and-spoke structure, used instead of VPC peering to connect VPCs and on-prem (more expensive but better suited for a hospital network)
* Route 53, ALBs, Shield, and WAF: For DNS and traffic control/protection
* AWS NAT Gateway: For outbound-only internet access for private subnets
* AWS Systems Manager: To manage and patch the EC2 instances remotely

## VPC Design: Designed 3 logically isolated VPCs to separate traffic for:
* Primary hospital
* Management Site
* Disaster Recovery failover region
 
## For Security & Compliance:
* Mapped controls to support HIPAA and Zero Trust adherence:
* AWS IAM + on-prem AD integration
* KMS for key management: CloudHSM: For hardware encryption
* Security Hub, GuardDuty, CloudTrail: For monitoring and logging
 
## Database Considerations For Oracle:
* RDS minimizes operational overhead but also limits customization options
* EC2 provides full control over the Oracle environment, enables fine-grained IAM policies, encrypted EBS volumes, and custom configurations
 
## Resilience & DR Planning:
* DR region will be located in US-East-2, an active-passive setup (slower failover compared to an active-active setup but costs for resource reservation is lower)
* Only critical workloads are replicated in the DR site
* Used S3 tiering and automated RDS snapshots to cut storage and deployment costs



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
	  - Use AWS Systems Manager
         ◊ The SSH protocol is chose as it can be disabled when maintenance is completed on the sever

	 □ For automated data transfer between on-prem and AWS services like S3AWS DataSync:
	  - For automated data transfer between on-prem and AWS services like S3
			
	 □ For Monitoring & Alerts:
	  - Setup CloudWatch agents on the on-prem and cloud servers
					
	 □ IAM:
	  - Needs to be combined with on-premises AD to allow access to the cloud resources
			
