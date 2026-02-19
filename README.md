# 📚 Ma Documentation

Site de documentation construit avec [Astro Starlight](https://starlight.astro.build/) et déployé automatiquement sur GitHub Pages.

## 🚀 Mise en place

### 1. Installer les dépendances

```bash
npm install
```

### 2. Configurer pour ton repo

Dans `astro.config.mjs`, remplace les valeurs suivantes :
- `<your-username>` → ton nom d'utilisateur GitHub
- `my-repo` → le nom de ton repo GitHub

Dans `src/content/docs/index.mdx`, mets à jour les liens aussi.

### 3. Activer GitHub Pages

1. Va dans **Settings** → **Pages** de ton repo GitHub
2. Dans **Source**, sélectionne **GitHub Actions**
3. Push ton code sur `main` — le déploiement se fait automatiquement !

### 4. Développement local

```bash
npm run dev        # Serveur de dev sur localhost:4321
npm run build      # Build de production
npm run preview    # Preview du build
```

## 📁 Structure

```
.
├── .github/workflows/deploy.yml   # GitHub Action pour le déploiement
├── src/
│   ├── content/
│   │   └── docs/                  # Pages de documentation (Markdown/MDX)
│   │       ├── guides/
│   │       └── reference/
│   └── content.config.ts
├── astro.config.mjs               # Configuration Astro + Starlight
├── package.json
└── tsconfig.json
```

## ✏️ Ajouter du contenu

Crée un fichier `.md` ou `.mdx` dans `src/content/docs/` :

```markdown
---
title: Ma nouvelle page
description: Description de la page.
---

Contenu ici...
```

Puis ajoute-le à la sidebar dans `astro.config.mjs`.
