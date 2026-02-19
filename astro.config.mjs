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
        github: 'https://github.com/benguiii/DocScalia',
      },
      sidebar: [
        {
          label: 'Guides',
          items: [
            { label: 'Introduction', slug: 'guides/introduction' },
            { label: 'Déploiement GitHub Pages', slug: 'guides/getting-started' },
          ],
        },
      ],
    }),
  ],
});
