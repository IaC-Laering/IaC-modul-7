# Simple Terraform - Build Once, Deploy Many Demo

Dette prosjektet demonstrerer "Build Once, Deploy Many" prinsippet med Terraform og Azure.

##  Konsept

**Build Once, Deploy Many** betyr:
- Bygg artifact ÉN gang
- Deploy SAMME artifact til flere miljøer
- Garantert konsistens mellom miljøer

##  Struktur

```
simple-terraform/
 terraform/          # Terraform kode (felles)
 environments/       # Miljø-spesifikk config
 backend-configs/    # Backend config per miljø
 scripts/           # Build og deploy scripts
```

##  Lokal Testing

### Forutsetninger
- Terraform >= 1.5.0
- Azure CLI
- Git (for versjonering)

### Steg 1: Bygg Artifact

**Linux/Mac:**
```bash
chmod +x scripts/*.sh
./scripts/build.sh
```

**Windows:**
```powershell
.\scripts\build.ps1
```

Dette oppretter: `terraform-<version>.tar.gz`

### Steg 2: Deploy til Dev

**Linux/Mac:**
```bash
./scripts/deploy.sh dev terraform-<version>.tar.gz
```

**Windows:**
```powershell
.\scripts\deploy.ps1 -Environment dev -Artifact terraform-<version>.tar.gz
```

### Steg 3: Deploy SAMME Artifact til Test

**Linux/Mac:**
```bash
./scripts/deploy.sh test terraform-<version>.tar.gz
```

**Windows:**
```powershell
.\scripts\deploy.ps1 -Environment test -Artifact terraform-<version>.tar.gz
```

##  Verifiser Build Once, Deploy Many

```bash
# Sammenlign lock files (skal være identiske!)
diff workspace-dev/terraform/.terraform.lock.hcl \
     workspace-test/terraform/.terraform.lock.hcl

# Ingen output = success! 
```

##  Cleanup

**Linux/Mac:**
```bash
./scripts/cleanup.sh dev terraform-<version>.tar.gz
```

**Windows:**
```powershell
.\scripts\cleanup.ps1 -Environment dev -Artifact terraform-<version>.tar.gz
```

##  Læringsmål

-  Forstå Build Once, Deploy Many
-  Se forskjellen på artifact og deployment
-  Håndtere miljø-spesifikk konfigurasjon
-  Verifisere konsistens mellom miljøer

##  Neste Steg

Del 2: Artifact Storage i Azure og eksisterende infrastruktur
