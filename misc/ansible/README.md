# Ansible DMZ

Durcissement ANSSI-BP-028 et déploiement des services de la DMZ Paris.

## Structure

- `site.yml` : playbook principal
- `inventory.ini` : machines et groupes
- `roles/common` : durcissement, appliqué à toutes les machines Linux
- `roles/web` : nginx
- `roles/haproxy` : haproxy + keepalived (VIP)

## Lancer

```bash
ansible-playbook site.yml --ask-vault-pass
```

Le `--ask-vault-pass` déchiffre le mot de passe du cluster keepalived, stocké chiffré dans `group_vars/haproxy/vault.yml`.

Cibler un groupe :

```bash
ansible-playbook site.yml --limit web --ask-vault-pass
```
