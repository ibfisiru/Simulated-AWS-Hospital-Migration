# Simulated-AWS-Hospital-Migration
A simulated AWS migration of a multi-site hospital network with HIPAA-style security, designed according to the AWS Well-Architected Framework

How do you modernize and migrate an organization to the cloud without breaking compliance, losing visibility, or compromising user data? This project explores that challenge through a self-directed AWS migration simulation for a mid-sized regional hospital network


Note: This project is not built for production scale. It is a self-directed simulation designed to highlight the workflow and thought process behind building AWS architectures. The build incorporates zero-trust principles, network segmentation, application and database migrations, and compliance considerations modeled on real-world healthcare constraints

## Hospital organizational profile: 
- 1 main hospital site
- 2 satellite clinics offering limited services
- 1 outpatient clinic
- 1 central admin office
The outpatient clinic and two satellite locations would remain on-prem for the time being, making for a hybrid infrastructure. The design diagram below served as the starting point, refined with minor adjustments along the way.



## How I approached it:
While I don’t have deep healthcare network experience, I used a combination of: 
- My AWS knowledge, developed through the Solutions Architect - Associate learning path
- AI tools like ChatGPT and Claude to explore:
    * Realistic hospital tech stacks
    * Technical edge cases
    * Security/compliance constraints
    * Feedback loops
The goal was to stress-test a cloud migration framework in a regulated, high-stakes context.

## The Migration Framework: 
To keep everything structured, I used the ITIL framework to develop my own high-level, 5-phase framework made of the following steps: 
1) Discovery & Planning
2) Service Translation & Architecture Design
3) Migration & Deployment Execution
4) Compliance & Optimization
5) Cutover & Training

## Terraform Setup
   Each section has an associate terraform directory which contains the code used to deploy that section. For example:
      - 'Phase 3: VPC Setup' has an associated directory within phase 3 that holds the code used to deploy the VPC's in the diagram below


## The following diagram was designed first and used as the blueprint for building the infrastructure:
![FPHN Architecture](https://github.com/user-attachments/assets/28ed0aba-21d7-44fe-bc02-a66694870c3f)


