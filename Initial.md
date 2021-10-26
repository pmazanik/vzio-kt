VZIO-SCTV Devops Transfer KT. INITIAL SESSION

**Time**
Toronto 9AM
Minsk   4PM
LA      7AM
 
26.10 CICD       CI/CD with focus for Consent Management (all nuances about multiple envs and AWS accounts)
27.10 AWS        AWS with focus on Lambdas, serverless (again for Consent Management)
28.10 Terraform  Terraform in context of Consent Management and ObserveRTC
29.10 Kubernetes Kubernetes - on example of ObserveRTC

Main applications:
!!! Consent Management Service
Mirror
Calls (freezed)

Branch strategy
feature => dev => staging => master  

**Serverless framework** - deploy Lamda and API Gateway.

**Task**
Simplify config file for CMS
1. Leave 2 Workflows: for dev (dev branch) and feature (except dev branch)
2. Use:
- context, 
- project vars, 
- global parameters in job, 
- default circle vars
- The same structure (workflow, jobs, commands, aws-cli orbs, executor)
3. Check components using echo steps

=======================================

1. KB Epam Onboarding page: https://kb.epam.com/display/VZIO/Accounts+and+accesses
2. CircleCI CMS URL: https://app.circleci.com/pipelines/github/BuddyTV/consent-management-service
3. Github CMS URL: https://github.com/BuddyTV/consent-management-service 
4. Config file (additional files)
