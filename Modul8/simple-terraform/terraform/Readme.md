# Build once, deploy many

Dette prosjektet demonstrerer "Build Once, Deploy Many" prinsippet med Terraform og Azure.

## Konsept
- bygg en artifact basert på infrastrukturen
- deploy samme artifact til flere miljøer
- opprett workflows for å automatisere pull request

## Struktur
```
simple-terraform/
├── terraform/          # Terraform kode (felles)
├── environments/       # Miljø-spesifikk config
├── backend-configs/    # Backend config per miljø
└── scripts/            # Build og deploy scripts
```

## Lokal Testing

### Steg 1: Bygge infrastruktur

- terraform configuration med main.tf, variables.tf, outputs.tf, versions.tf og backend.tf
- miljø-spesifikke variabler i (miljø).tfvars

### Steg 2: Bygge artifact
```
./scripts/build.sh
```
opprettet terraform-TALL.tar.gz

### Steg 3: Deploy til Dev og Test
```
./scripts/deploy.sh (miljø) terraform-TALL.tar.gz
```
Artifacten ble brukt til å deploye to forskjellige miljøer.

## GitHub

### Steg 1: Opprettelse av andre branch for testing
Før man slår endringer sammen med main.

### Steg 2: Terraform CI

Integrasjon ved bruk av terraform validate, kjører automatisk ved Pull Request fra en branch til annen. Prod krever autorisering.

### Steg 3: Terraform CD

Deployment til tre miljøer, men Prod krever autorisering i GitHub.

