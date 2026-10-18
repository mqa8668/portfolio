%{
  title: "Kubernetes GitOps: Lessons from Running 24 Microservices",
  description: "Lessons from running a FIDO2 authentication platform on Kubernetes with ArgoCD, Istio and a GitOps workflow.",
  tags: ["devops", "kubernetes", "gitops"],
  date: ~D[2025-01-10]
}
---

At VinCSS, I managed the infrastructure for a FIDO2 authentication platform running 24 microservices on Kubernetes. Over two years, we moved from manual kubectl deployments to a full GitOps pipeline. These are the lessons that cost us the most time.

## ArgoCD setup: start simple

We started with ArgoCD in its default configuration, and that was the right call. It is tempting to set up ApplicationSets, multi-cluster sync and custom health checks straight away. Don't.

Our initial setup was one ArgoCD Application per microservice, each pointing to a directory in the GitOps repo. The repo looked like this:

```
gitops-repo/
  apps/
    auth-service/
      base/
        deployment.yaml
        service.yaml
        kustomization.yaml
      overlays/
        staging/
        production/
    fido2-server/
      ...
```

Kustomize overlays handled environment differences. We tried Helm first, but for our team plain YAML with Kustomize patches was easier to review in pull requests, and the whole deployment for a service showed up in a single diff.

The best GitOps tool is the one your team can debug at 3 AM. Helm chart abstractions that nobody understands are worse than verbose YAML that everyone can read.

## Istio service mesh: useful, but expensive to run

We adopted Istio for mTLS between services, traffic management and observability. It delivered all three, at a significant operational cost.

The first problem was resource overhead. Each sidecar proxy used 100-200MB of memory, which across 24 services with multiple replicas added up to a lot of cluster capacity.

The second was debugging. When a request fails, it could be the application, the sidecar, the ingress gateway or a misconfigured VirtualService. We spent entire sprints on issues that turned out to be Istio configuration, not application bugs.

What worked for us:

- Strict mTLS everywhere, with no exceptions. This made security audits much simpler for a FIDO2 platform where compliance was critical.
- Conservative retry policies. We started with aggressive retries and caused cascading failures during incidents. Two retries with exponential backoff became our standard.
- A dedicated Istio owner. One team member became the Istio expert, and without that person we would have been buried in configuration.

Don't adopt a service mesh unless you have a specific, measurable problem it solves. For us that problem was mTLS compliance. If you only need observability, lighter options like OpenTelemetry may be enough.

## Blue/green deployments

We used blue/green deployments for critical services: the FIDO2 server, the authentication gateway and the token service. The process:

1. Deploy the new version (green) alongside the current one (blue).
2. Run automated smoke tests against green.
3. Switch the Istio VirtualService to route traffic to green.
4. Keep blue running for 30 minutes as a rollback target.
5. Scale down blue after that period.

The switch happens at the traffic layer, not the deployment layer, which makes it atomic. Istio VirtualService weight-based routing handled it:

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
spec:
  http:
    - route:
        - destination:
            host: auth-service
            subset: green
          weight: 100
        - destination:
            host: auth-service
            subset: blue
          weight: 0
```

Rollback meant flipping the weights back, and we could do it in under 30 seconds, which mattered for our SLA.

Blue/green costs more, since you run double the resources during a deployment. For services where downtime has direct business impact, the instant rollback is worth it.

## Monitoring: Prometheus, Grafana and Alertmanager

The monitoring stack was the standard Prometheus and Grafana combination. What we monitored mattered more than the tooling.

The four golden signals (latency, traffic, errors, saturation) formed the base of every service dashboard. We added FIDO2-specific metrics: authentication ceremony success rate, attestation verification latency and credential registration throughput.

The most useful alert we built was a deployment regression detector. It compared error rates and p99 latency in the 15 minutes after a deployment against the 15 minutes before. If either degraded by more than 10%, it fired an alert and the on-call engineer decided whether to roll back. It caught three production incidents before users noticed them.

Alert on symptoms (error rate, latency), not causes (CPU, memory). A page should answer "are users affected?", not "is a metric high?"

## Disaster recovery with a 15-minute RTO

Our RTO target was 15 minutes, and we met it consistently in quarterly DR drills. The main pieces:

1. Velero for cluster backup: scheduled snapshots of all resources and persistent volumes every 6 hours, with continuous backup of critical namespaces.
2. Multi-region database replication: PostgreSQL streaming replication to a standby region, with automatic failover through Patroni.
3. GitOps as the source of truth: all cluster state lived in Git, so spinning up a new cluster meant pointing ArgoCD at the same repo. Infrastructure was defined in Terraform, also in Git.
4. Documented runbooks: every DR scenario had a step-by-step runbook, tested quarterly. The runbook for total cluster loss had 12 steps and took about 11 minutes to execute.

Because all cluster configuration was declarative and version-controlled, we could rebuild the whole platform from scratch. The database restore was the bottleneck, not the application deployment.

If you haven't tested your recovery procedure this quarter, you don't have one.

## Operational discipline

Running 24 microservices on Kubernetes showed me that the technology is the easier part. The harder part is operational discipline: consistent naming conventions, mandatory PR reviews for infrastructure changes, regular DR drills and on-call rotations that don't burn people out.

GitOps gave us an audit trail, repeatable deployments and confidence that production matches what is in Git.
