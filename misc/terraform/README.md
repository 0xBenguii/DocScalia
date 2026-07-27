# Infra DMZ (Terraform + Proxmox)

Déploiement des 5 VM de la DMZ Paris sur pve3-ovh, via l'API Proxmox uniquement (pas de shell sur l'hyperviseur). Le disque de chaque VM est importé côté serveur depuis l'image cloud officielle Debian 12, uploadée une fois en OVA (`local:import/debian12-genericcloud-eq9.ova`, ne pas la supprimer du storage).

| VMID | VM | Rôle | DMZ | Management | Tailscale |
|---|---|---|---|---|---|
| 911 | PRS-RVP-01 | HAProxy | 10.9.175.10 | 10.9.99.110 | 10.10.10.10 |
| 912 | PRS-RVP-02 | HAProxy | 10.9.175.11 | 10.9.99.111 | 10.10.10.11 |
| 913 | PRS-WEB-01 | Nginx | 10.9.175.20 | 10.9.99.120 | 10.10.10.20 |
| 914 | PRS-WEB-02 | Nginx | 10.9.175.21 | 10.9.99.121 | 10.10.10.21 |
| 915 | PRS-WEB-03 | Nginx | 10.9.175.22 | 10.9.99.122 | 10.10.10.22 |

RAM totale : 8,5 Go. Gateway DMZ : 10.9.175.1 (VIP CARP pfSense). La VIP HAProxy 10.9.175.9 sera posée par keepalived (phase Ansible).

Réseau par VM :

- net0 `prsbaie9l2` : production DMZ, porte la default route
- net1 `prsbaie9l4` : management, sans gateway
- net2 `prsbaie9t1` : accès admin via routeur Tailscale, bridge temporaire à supprimer en fin de maquette

## Utilisation

```bash
terraform init
terraform plan
terraform apply
terraform output -raw ansible_inventory > ../ansible/inventory.ini
```

Accès aux VM : compte `ansible` (sudo sans mdp), clé `~/.ssh/id_ed25519_scalia-dmz` en SSH, ou mdp du tfvars via la console Proxmox. Utiliser la console xterm.js : noVNC est en qwerty tant que le keymap fr n'est pas posé.

## À savoir

- Token API : droits via le pool `prs-bai-eq9`, secret dans terraform.tfvars (exclu de git)
- `qemu_agent = false` tant que le guest agent n'est pas installé (sinon apply bloque)
- L'image de base est vanilla, le durcissement ANSSI arrive avec les rôles Ansible (tâche 4.4 du WBS)
- Import qcow2 direct impossible en PVE 8.3 sans shell, d'où le passage par l'OVA (natif en 8.4)

## Suite

Phase Ansible dès que le routeur Tailscale est monté : rôles common (keymap fr, durcissement, guest-agent), web (nginx), haproxy (LB + keepalived). Puis page DocScalia `doc-technique/dmz/deploiement-dmz-iac.mdx`.
