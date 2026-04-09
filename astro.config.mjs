import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

const REPO_NAME = 'DocScalia';

export default defineConfig({
  site: 'https://0xBenguii.github.io',
  base: `/${REPO_NAME}`,
  integrations: [
    starlight({
      title: 'SCALIA Docs',
      logo: {
        src: './src/assets/scalia.jpg',
        alt: 'Scalia',
      },
      customCss: ['./src/styles/custom.css'],
      social: {
        github: 'https://github.com/0xBenguii/DocScalia',
      },
      sidebar: [
        {
          label: 'Guides',
          items: [
            { label: 'Introduction', slug: 'guides/introduction' },
            { label: 'Déploiement GitHub Pages', slug: 'guides/getting-started' },
          ],
        },
        {
          label: 'Gestion de Projet',
          items: [
            { label: 'Vue d\'ensemble', slug: 'gestion-projet' },
            { label: 'RACI', slug: 'gestion-projet/raci' },
            { label: 'WBS', slug: 'gestion-projet/wbs' },
            { label: 'Planning & Gantt', slug: 'gestion-projet/planning' },
            { label: 'Matrice des risques', slug: 'gestion-projet/risques' },
            { label: 'Réunion hebdomadaire', slug: 'gestion-projet/reunion-hebdo' },
          ],
        },
        {
          label: 'Infrastructure',
          items: [
            { label: 'Vue d\'ensemble', slug: 'infrastructure' },
            { label: 'Plan d\'adressage IP', slug: 'infrastructure/plan-adressage' },
            { label: 'Topologie réseau', slug: 'infrastructure/topologie' },
            { label: 'Budget RAM Proxmox', slug: 'infrastructure/budget-ram' },
          ],
        },
        {
          label: 'Documentations Technique',
          items: [
            { label: 'Introduction', slug: 'doc-technique' },
            { 
              label: 'Active Directory',
              items: [
                { label: 'Active Directory', slug: 'doc-technique/active-directory/doc-active-directory' },
                { label: 'Sites et Services Active Directory', slug: 'doc-technique/active-directory/doc-site-services-ad' },
                { label: 'Structure de l\'annuaire', slug: 'doc-technique/active-directory/doc-structure-ou-ad' },
                { label: 'Réplication des mots de passe (PRP)', slug: 'doc-technique/active-directory/doc-replication-mdp-prp' },
                { label: 'Stratégie de groupe (GPO)', slug: 'doc-technique/active-directory/doc-gpo' },
                
              ],
            },
          ],
        },
      ],
    }),
  ],
});
