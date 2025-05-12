# Déploiement Kubernetes – Projet Tsundoku

Ce dossier contient les manifestes Kubernetes organisés pour déployer l'ensemble de l'application **Tsundoku** : backend, frontend, nginx, et bases de données (PostgreSQL, MongoDB, Redis).

## 🗂 Structure

```bash
kubernetes/
├── backend/
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── secret.yaml
│   └── service.yaml
├── frontend/
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── secret.yaml
│   └── service.yaml
├── nginx/
│   ├── configmap.yaml
│   ├── deployment.yaml
│   └── service.yaml
└── bdd/
    ├── postgres/
    │   ├── configmap.yaml
    │   ├── secret.yaml
    │   ├── deployment.yaml
    │   └── service.yaml
    ├── mongodb/
    │   ├── configmap.yaml
    │   ├── secret.yaml
    │   ├── deployment.yaml
    │   └── service.yaml
    └── redis/
        ├── configmap.yaml
        ├── deployment.yaml
        └── service.yaml
```
## 🚀 Objectif

Ce dossier a pour but de **déployer avec Kubernetes** de l'application dans un cluster. Il répond aux bonnes pratiques DevOps : séparation des responsabilités, sécurité (via secrets), et scalabilité.

## 📦 Instructions de déploiement

```bash
  # À la racine du dossier kubernetes/
kubectl apply -f .

Ou pour un composant spécifique :

kubectl apply -f backend/
kubectl apply -f frontend/
kubectl apply -f bdd/postgres/
```
🔐 Sécurité

Les informations sensibles (identifiants des BDD, etc.) sont stockées dans des fichiers secret.yaml.
