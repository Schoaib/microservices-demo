# A Microservice Demo Application

The application is the user-facing part of an online shop that sells socks. It is intended to aid the demonstration and testing of microservice and cloud native technologies.

It is built using [Spring Boot](http://projects.spring.io/spring-boot/), [Go kit](http://gokit.io) and [Node.js](https://nodejs.org/) and is packaged in Docker containers.

## Deployment Platforms

The [terraform folder](./terraform/) contains terraform code and instructions to provision the application infrastucture in AWS.

The [kubernetes folder](./kubernetes/) contains scripts and instructions to provision the application onto kubernetes platform.

## Testing

### Static Testing
- [Terraform validate] (https://www.terraform.io/cli/commands/validate#command-validate)
- [Kubernetes lint] (https://github.com/stackrox/kube-linter)
- [Conftest for Terraform] (https://www.conftest.dev/) using rego policies (https://github.com/open-policy-agent/conftest/tree/master/examples/hcl1)
- [Conftest for Kubernetes] (https://www.conftest.dev/) using rego policies (https://github.com/open-policy-agent/conftest/tree/master/examples/kubernetes)

### Integration Testing
Infrastructre testing is done by provisioning development infrastructure through PR.

### Load Testing
- Using python to create load on the system .(https://github.com/Schoaib/microservices-demo/tree/main/kubernetes/manifests-loadtest)

## Observability

### Logging
- EFK Stack (https://github.com/Schoaib/microservices-demo/tree/main/kubernetes/manifests-logging)
- Cloudwatch
### Monitoring & Alerting
- Prometheus & Grafana (https://github.com/Schoaib/microservices-demo/tree/main/kubernetes/manifests-monitoring)
### Tracing 
- Jaeger (https://github.com/Schoaib/microservices-demo/tree/main/kubernetes/manifests-jaeger)

## CI/CD
Jenkins can be used to run CI pipeline for IAC and configuration (all commands available in MAKE file) while spinnaker can be used to continously deploy the changes.

## References:
https://github.com/terraform-aws-modules/terraform-aws-eks
https://microservices-demo.github.io/
