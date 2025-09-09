This section covers their implementation across a multi-VPC setup with segmented subnets, scoped IAM roles, and hardened security zones. The AWS-hosted components are as follows:
 
## Primary Hospital VPC (CIDR 10.0.0.0/16)
Split across 3 AZs: 1 public and 2 private subnets for isolation & HA:
Public Subnet:
- Hosts NAT Gateways, load balancer, and S3 Endpoints
- Load balancer handles inbound HTTPS traffic, routed internally via security groups/routing rules. NAT gives EC2/DB servers secure internet access as needed
- Security groups are designed to restrict access to known IPs only
Private Subnets:
- Host the EC2 app servers, encrypted DBs, and PACS
- App and DB are shielded from public traffic. EC2 instances use NAT for outbound-only access
- RDS and PACS block outbound traffic to maintain Zero Trust boundaries
Key Components Of VPC:
- Route Tables: Defined per subnet role. Public subnets route to the IGW. Private subnets route to the NAT
- IAM Roles: EC2 scoped to SSM/S3 access. DMS scoped for Oracle migration only
- Provisioning: EC2 AMIs were imported from on-prem systems, preloaded with server/app configurations, then registered to Systems Manager for patching/session control
 
 
## Management VPC (CIDR 10.1.0.0/16)
Public Subnet:
- Like the primary VPC, contains a NAT gateway, open to IGW to manage traffic 
- The idea is for it to be reachable from on-prem sites during setup and restricted (via SGs) to allow RDP/LDAP access from admin IPs
Private Subnet:
- Hosts admin servers used for logging, DNS, CloudTrail, backups, and AWS Config recorder
- VPC endpoints (S3, SSM, KMS) reduce reliance on IGW
- Goal: Isolate security/audit infrastructure from general workloads for compliance boundaries
 

## Disaster Recovery VPC ( CIDR 10.2.0.0/16)
Public Subnets:
- Serves as a replication of the primary VPC, with a load balancer, NAT Gateway and Route 53 Health Check targets
- Used to support DNS-based failover routing and warm standby access
Private Subnets:
- Holds EC2 servers, DB snapshots, S3 replicas, and the private subnet from the management VPC to cut costs of deploying an additional management DR site
- Staged for active-passive failover so only critical workloads are replicated
- Automated snapshots and S3 tiering used, with Glacier Deep Archive for long-term storage
- Route tables isolate DR traffic. IAM roles scoped to read-only/failover testing access
 

## Overall Highlights: Each VPC is designed for task-specific isolation
- Private subnets use scoped access and restrict public exposure
- IGWs are only attached where required and controlled via routing/security groups
- SSM and IAM reduce the need for bastion hosts
