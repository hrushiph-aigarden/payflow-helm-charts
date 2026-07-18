# PayFlow Pro — Helm Charts & Kubernetes Delivery

> **GitOps-Driven Kubernetes Delivery** | Argo CD + Helm 3

[![Helm](https://img.shields.io/badge/Helm-3.16+-blue)](https://helm.sh)
[![Argo CD](https://img.shields.io/badge/ArgoCD-2.12+-orange)](https://argoproj.github.io/cd/)
[![Kubernetes](https://img.shields.io/badge/EKS-1.30-blue)]()
[![MCP-Powered](https://img.shields.io/badge/MCP-Self--Service-green)]()

## Overview

This repository contains the Helm chart and Argo CD manifests for deploying **PayFlow Pro** across dev, staging, and production Kubernetes environments. All deployments are GitOps-driven — no `kubectl apply` by hand.

## Repository Structure

```
payflow-helm-charts/
├── charts/
│   └── payflow-pro/
│       ├── Chart.yaml
│       ├── values.yaml         # Defaults (prod-safe)
│       ├── values-dev.yaml
│       ├── values-staging.yaml
│       ├── values-prod.yaml
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           ├── hpa.yaml
│           ├── pdb.yaml
│           ├── networkpolicy.yaml
│           ├── serviceaccount.yaml
│           └── _helpers.tpl
├── argocd/
│   └── payflow-app.yaml     # ApplicationSet (all environments)
├── .github/workflows/
│   └── helm-lint-test.yml
├── agents/
│   └── helm-provisioner-agent.md
└── README.md
```

## 🤖 Helm Provisioner Agent (MCP Self-Service)

Ask your IDE agent:
```
"Deploy PayFlow Pro v1.2.0 to staging using the PCI-compliant values"
"What are the resource limits in production?"
"Show me the difference between staging and prod configurations"
```

See [agents/helm-provisioner-agent.md](./agents/helm-provisioner-agent.md)

## Quick Deploy

```bash
# Dev
helm upgrade --install payflow-pro ./charts/payflow-pro \
  -f charts/payflow-pro/values-dev.yaml \
  -n payflow-dev --create-namespace

# Staging
helm upgrade --install payflow-pro ./charts/payflow-pro \
  -f charts/payflow-pro/values-staging.yaml \
  -n payflow-staging

# Prod (via Argo CD only — no manual helm apply)
argo app sync payflow-pro-prod  # After CAB approval
```

## Environment Comparison

| Parameter | Dev | Staging | Prod |
|---|---|---|---|
| Replicas | 1 | 2 | 3 (HPA: 3-20) |
| Instance | t-shirt:small | t-shirt:medium | t-shirt:large |
| Vault | disabled | enabled | enabled |
| Gateway | mock | sandbox | production |
| Auto-sync | yes | yes | no (manual) |
| PDB | no | minAvailable:1 | minAvailable:2 |
| WAF | no | no | yes |

## Related Jira Epic
- [SCRUM-7](https://ainursery.atlassian.net/browse/SCRUM-7) — Helm Charts & Kubernetes Delivery

---
*Part of the "The End of Documentation: MCP-Based Living Platform for Developer Self-Service" POC*
