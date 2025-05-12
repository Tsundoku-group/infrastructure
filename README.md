# Infrastructure - Tsundoku

Ce répertoire centralise toute la logique d'infrastructure du projet **Tsundoku**, qui regroupe les services backend (Symfony), frontend (Next.js) et les configurations Docker/CI-CD associées. Il est conçu pour permettre une gestion claire, professionnelle et isolée de la logique de déploiement.

---

## Sommaire

1. [Structure des dossiers](#structure-des-dossiers)
2. [Docker & Docker Compose](#docker--docker-compose)
3. [CI/CD GitHub Actions](#cicd-github-actions)
4. [Stratégie de build et de déploiement](#stratégie-de-build-et-de-déploiement)
5. [Scans de sécurité](#scans-de-sécurité)
6. [Releases GitHub](#releases-github)
7. [Tags et versionning](#tags-et-versionning)

---

## Structure des dossiers

```bash
infrastructure/
├── compose/                  # Docker Compose (dev et prod)
│   ├── dev/
│   └── prod/
├── docker/                   # Dockerfiles spécifiques
│   ├── php/
│   ├── nextjs/
│   └── nginx/
├── .github/
│   └── workflows/            # CI/CD centralisée
│       ├── docker-build.yaml
│       ├── frontend-check.yaml
│       └── backend-check.yaml
└── README.md
```

---

## Docker & Docker Compose

Le projet est organisé pour que chaque service ait son propre `Dockerfile` en **production**, avec un `docker-compose.yaml` pour lier le tout.

* Les **images frontend et backend** sont construites avec un focus sur la séparation des étapes (multi-stage build).
* Le service **nginx** n’est pas buildé ici mais utilise directement une image officielle + un `default.conf` custom.

---

## CI/CD GitHub Actions

### Actions locales aux projets :

* **Frontend** : lint + type-check (à chaque PR de `develop` vers `pre-prod`)
* **Backend** : phpstan, ecs, phpunit (à chaque PR de `develop` vers `pre-prod`)

### Action centralisée dans `infrastructure` :

* **docker-build.yaml** :

    * Build & push des images `php`, `nextjs`, `nginx`
    * Lancement uniquement sur `main` et `develop`
    * Ajout des tags : `prod`, SHA, et date

---

## Stratégie de build et de déploiement

* **PR vers `pre-prod`** : vérifications de code
* **Push sur `develop` ou `main`** : build + push d’images docker en `prod`
* **Push de tag** : génère une release GitHub

---

## Scans de sécurité

Via Trivy, vérifie automatiquement :

* les secrets
* les vulnérabilités des dépendances (backend, frontend, infra)

---

## Releases GitHub

Un fichier release est généré automatiquement avec :

* le nom des images
* les tags associés (SHA, date)

---

## Tags et versionning

* Format utilisé : `v1.0.0`
* Triggers : une **release GitHub** + les tags `php:v1.0.0`, `nextjs:v1.0.0`, etc.

