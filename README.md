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
Infrastructre testing is done by provisioning development infrastructure through PR and running tests using terratest (https://terratest.gruntwork.io/).

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
Jenkins can be used to run CI pipeline for IAC and configuration (all commands available in MAKE file) while spinnaker can be used to continously deploy the changes (https://spinnaker.io/docs/guides/tutorials/codelabs/kubernetes-v2-source-to-prod/).

### Jenkins Example
```
pipeline {
  agent { label 'linux'}
  options {
    skipDefaultCheckout(true)
  }
  stages{
    stage('clean workspace') {
      steps {
        cleanWs()
      }
    }
    stage('checkout') {
      steps {
        checkout scm
      }
    }
    stage('terraform-init') {
      steps {
        sh 'make terraform-init'
      }
    }
    stage('terraform-plan') {
      steps {
        sh 'make terraform-plan'
      }
    }
    stage('terraform-apply') {
      steps {
        sh 'make terraform-apply'
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}
```

### Spinnaker Example
![alt text](https://d2908q01vomqb2.cloudfront.net/ca3512f4dfa95a03169c5a670a4c91a19b3077b4/2019/07/02/prabhat-spinnaker-8.7.1-pipeline.png)

### Github Example
- Kubernetes countinous security scanning using kubesec https://github.com/Schoaib/microservices-demo/blob/main/.github/workflows/kubesec.yml
- Terraform  security scanning using tfsec https://github.com/Schoaib/microservices-demo/blob/main/.github/workflows/tfsec.yml

Scan reports here 
https://github.com/Schoaib/microservices-demo/security/code-scanning


## References:
https://github.com/terraform-aws-modules/terraform-aws-eks
https://microservices-demo.github.io/
https://www.cloudbees.com/blog/terraform-and-jenkins-iac-from-your-build
https://aws.amazon.com/blogs/opensource/deployment-pipeline-spinnaker-kubernetes/
