# Simulated-AWS-Hospital-Migration
Simulated AWS migration of a multi-site hospital network with HIPAA-style security. Built according to the AWS Well-Architected framework.

How do you modernize and migrate an organization to the cloud without breaking compliance, losing visibility, or compromising user data? That’s the question I set out to answer when I designed and executed a simulated AWS cloud migration for a mid-sized regional hospital network.

## Hospital organizational profile: 
- 1 main hospital site
- 2 satellite clinics offering limited services
- 1 outpatient clinic
- 1 central admin office
The outpatient clinic and two satellite locations would remain on-prem for the time being, making for a hybrid infrastructure. Attached is the cloud design diagram I created and worked backwards from, with minor design tweaks along the way.


## Note: This was a self-directed simulation, not a client project. All components from zero-trust principles design, network design, app and DB migrations, and industry compliance needs, was modeled on real-world healthcare constraints.

## How I approached it:
- While I don’t have deep healthcare network experience, I used a combination of: 
- My AWS knowledge attained from the 'Solution Architect - Associate' learning path
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

## The Following aiagram is what I designed first, and worked backwards from to build out the infrastructure.
![FPHN Architecture](https://github.com/user-attachments/assets/28ed0aba-21d7-44fe-bc02-a66694870c3f)


