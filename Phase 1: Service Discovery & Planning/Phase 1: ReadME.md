Discovery & Planning

## Here’s what went into the first phase, Discovery & Planning for this hospital cloud migration.

## Discovery Goals & Planning Focus:
Before deploying any infrastructure, I simulated what a real discovery and fact gathering phase might look like for a hospital network preparing to move to the cloud. Key considerations included:
	- Services & applications: EHR, billing, Imaging (x-rays, MRI's etc.)
	- End user types: doctors, nurses, IT teams, patients
	- Access patterns & permissions by role
	- Data classification & retention (HIPAA, logs, audits)
	- RTO/RPO & disaster recovery expectations
	- High availability systems vs. those that can tolerate longer downtime
	- Chokepoints in the on-prem design that can be addressed with a migration to the AWS cloud
	- Hybrid design plan:
		○ 1 main hospital
		○ 2 satellite clinics
		○ 1 outpatient center
		○ 1 admin office
Only the hospital & admin office moved to AWS. The rest stayed on-prem

## AI Use Case and Assumptions:
Since I don’t have hands-on healthcare IT experience, I used AI tools like ChatGPT to simulate realistic constraints and test assumptions. The AI tools helped define:
	- Actual core clinical applications like: 
		○ Cerner (for Electronic Health Records)
		○ Oracle (For Databases)
		○ PACS (For medical imaging technology)
		○ Pharmacy
		○ Labs
	- Data volume sizing for:
		○ EHR & clinical data
		○ Imaging archives
		○ Backups & historical data
	- Access patterns:
		○ Active records needing sub-second access
		○ Historical records (lower access frequency, but always online for auditing and such)
		○ Imaging (large, high-bandwidth transfers)
	- Security & compliance:
		○ SIEM (To detect, analyze, and respond to traffic on the network)
		○ Monitoring and log collection
		○ IAM role design (for least privilege access)
		○ Active Directory integration
		○ Encryption services
	- Migration risks and service translation strategies
		○ To keep the simulation grounded in real-world complexity and not just an idealized cloud setup

## In short, the AI tools helped to:
	- Validate storage tiers
	- Brainstorm realistic hospital workloads
	- Identify compliance blind spots
	- Stress-test assumptions (like large imaging archives).
The goal: a design grounded in real-world constraints.


## Infrastructure baseline I simulated:
	- 2 data centers (main + DR site)
	- Approx 150 VMs on ESXi across 20–25 physical servers
	- Enterprise file/block storage
	- Redundant internet
	- Firewalls, IAM, segmentation (clinical/admin/guest)
	- Load balancers
	- SIEM & audit logging
