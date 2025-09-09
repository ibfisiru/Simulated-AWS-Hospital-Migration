In the final phase of this simulated hospital migration, I shifted from infrastructure execution to operational stability, focusing on business continuity through disaster recovery, monitoring, testing, and cutover. Here was my approach:
 
	- Backup & Disaster Recovery:
The DR site mirrored the primary site in a separate AWS region (us-east-2), with 3 AZs and a non-overlapping CIDR (10.1.0.0/24). It isolates failures and enables fast recovery without the cost of an active-active config. After defining RTO/RPO targets, the priorities were:
		○ S3 tiering for archives
		○ ISO replication for app servers
		○ RDS snapshots and data integrity validation
		○ VPC connections & security group mirroring
		○ DNS switching via Route 53
		○ Set up a backup vault in a separate AWS account with cross-account backups, scoped IAM roles, and retention policies
 
	- Monitoring & Compliance:
		○ A centralized CloudWatch dashboard tracked:
		○ EC2 CPU, memory & network stats
		○ DB query throughput
		○ Load Balancer errors and response times
		○ Auto scaling metrics
		○ Logs from VPC Flow Logs, CloudWatch Agent, RDS, CloudTrail & AWS Config
		○ Used CloudWatch Insights for IAM queries, flow log analysis, and RDS errors
 
	- Testing & Validation:
		○ Testing-wise, I created and followed documented procedures for:
		○ Weekly DR tests
		○ Quarterly region failovers
		○ Simulations of app failure, data corruption, and network outages
		○ Root cause and impact docs for each scenario
		○ Performance tests used clinical workflows such as:
			§ Patient registration
			§ Record retrieval
			§ Pharmacy and billing operations
			§ Compliance checks covering, audit trails, access logs, and data encryption (at rest and in transit)
 
	- Cutover Planning:
		○ Cutover & rollbacks also followed a strict sequence:
		○ DNS reversions
		○ DB syncs from DR
		○ Snapshot checkpoints
		○ Role-based training on AWS console, incident response, and compliance tools, using workshops, labs, and KBs
		○ Go-live checklists were used
 
	-  Areas Of Improvement:
Post-migration, I identified the following areas for refinement:
		○ IAM:
			§ Monitor and adjust roles as roles shift
			§ Adopt AWS Organizations service to tighten security boundaries
		○ Networking:
			§ Continuously monitor NAT gateway and AWS Direct Connect for saturation and evaluate a shift to AWS Transit Gateway or Site-to-Site VPN
		○ Application Tier:
			§ Cerner EHR integrates with several external systems. Should latency or sync issues appear:
			§ Consider AWS App Mesh service for better service communication and observability
		○ Security:
			§ Add GuardDuty for behavioral detection and compliance alerts
		○ DR & HA:
			§ Use Lambda functions to automate certain tasks like snapshot validation and config drift detection
		○ Testing:
Use AWS Inspector to scan for vulnerabilities<img width="1080" height="1635" alt="image" src="https://github.com/user-attachments/assets/6026e16c-da1b-42f5-a744-ce1aefe21b6d" />
