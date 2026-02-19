import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

const REPO_NAME = 'DocScalia';

export default defineConfig({
  site: 'https://0xBenguii.github.io',
  base: `/${REPO_NAME}`,
  integrations: [
    starlight({
      title: 'Documentation SCALIA',
      social: {
        github: 'https://github.com/benguiii/DocScalia',
      },
      sidebar: [
        {
          label: 'Guides',
          items: [
            { label: 'Introduction', slug: 'guides/introduction' },
            { label: 'Démarrage rapide', slug: 'guides/getting-started' },
          ],
        },
        {
          label: 'Référence',
          autogenerate: { directory: 'reference' },
        },
      ],
    }),
  ],
});
