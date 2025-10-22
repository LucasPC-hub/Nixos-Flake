# Análise da Estrutura do Flake NixOS

## 🔴 Erros Críticos (Precisam ser Corrigidos)

### 1. Inputs Não Declarados (flake.nix:45)
- `nixvim` e `quickshell` usados nos outputs mas não declarados nos inputs
- **Solução**: Adicionar aos inputs ou remover dos outputs

### 2. Paths Incorretos (configuration.nix:6-12)
```nix
# ERRADO:
"${self}/system/programs/steam.nix"

# CORRETO:
"${self}/hosts/system/programs/steam.nix"
```
Aplicar correção em todas as linhas 6-12

### 3. Arquivo Inexistente (configuration.nix:9)
- `"${self}/system/environment.nix"` não existe
- **Solução**: Remover import ou criar o arquivo

### 4. Grupo Duplicado (configuration.nix:36,42)
- "video" aparece duas vezes em `extraGroups`
- **Solução**: Remover duplicata

### 5. Portainer no Local Errado (configuration.nix:13)
- Importado de `home/programs/` mas é config de sistema
- **Solução**: Mover para `hosts/system/services/`

---

## 📋 Sugestões de Reorganização

### Estrutura Proposta

```
flake/
├── flake.nix
├── flake.lock
│
├── hosts/
│   ├── nixos/                    # Renomear "default" → "nixos"
│   │   ├── default.nix           # Configuração principal
│   │   ├── hardware.nix          # Hardware específico
│   │   └── user.nix              # Usuário lpc
│   │
│   └── common/                   # Renomear "system" → "common"
│       ├── boot.nix
│       ├── networking.nix
│       ├── fonts.nix
│       ├── filesystems.nix
│       │
│       ├── hardware/
│       │   ├── nvidia.nix
│       │   ├── bluetooth.nix
│       │   ├── audio.nix
│       │   └── graphics.nix
│       │
│       ├── programs/
│       │   ├── docker.nix
│       │   ├── steam.nix
│       │   ├── openfortivpn.nix
│       │   └── stylix.nix
│       │
│       └── services/
│           ├── portainer.nix     # Mover de home/
│           ├── xdg.nix
│           └── greeter.nix
│
├── home/
│   ├── editors/
│   │   └── vscode.nix
│   │
│   ├── programs/
│   │   ├── fish.nix
│   │   ├── kitty.nix
│   │   ├── obs.nix
│   │   ├── rmpc.nix
│   │   ├── fastfetch.nix
│   │   └── vesktop/
│   │
│   └── niri/
│       ├── default.nix
│       ├── settings.nix
│       ├── keybinds.nix
│       ├── rules.nix
│       ├── autostart.nix
│       ├── applications.nix
│       └── scripts.nix
│
├── packages/                     # Novo: pacotes customizados
│   └── default.nix
│
└── assets/
    ├── icons/
    ├── themes/
    └── wallpapers/
```

### Benefícios da Reorganização

1. **Clareza**: `common` é mais descritivo que `system`
2. **Modularidade**: Hardware, serviços e programas separados
3. **Escalabilidade**: Fácil adicionar novos hosts
4. **Manutenibilidade**: Arquivos menores e mais focados
5. **Convenções**: Segue padrões da comunidade NixOS

---

## 🔧 Melhorias Específicas por Arquivo

### flake.nix
- [ ] Adicionar `quickshell` aos inputs
- [ ] Remover `nixvim` dos outputs ou adicionar aos inputs
- [ ] Documentar cada input com comentário

### hosts/nixos/default.nix (configuration.nix)
- [ ] Corrigir todos os paths de import
- [ ] Remover import de environment.nix
- [ ] Remover grupo "video" duplicado
- [ ] Separar em módulos menores:
  - Boot → `common/boot.nix`
  - Hardware NVIDIA → `common/hardware/nvidia.nix`
  - Bluetooth → `common/hardware/bluetooth.nix`
  - Rede → `common/networking.nix`
  - Fontes → `common/fonts.nix`
  - Usuários → `hosts/nixos/user.nix`

### hosts/common/packages.nix
- [ ] Corrigir formatação (remover espaço extra linha 1)
- [ ] Adicionar comentários por categoria de pacote

### home/programs/portainer.nix
- [ ] Mover para `hosts/common/services/portainer.nix`
- [ ] Atualizar import em configuration.nix

---

## 🎨 Convenções Recomendadas

### 1. Nomenclatura de Arquivos
- `default.nix` - Arquivo principal que importa outros
- `hardware.nix` - Configuração gerada pelo nixos-generate-config
- Nomes descritivos e em minúsculas

### 2. Estrutura de Módulos
```nix
{ config, lib, pkgs, ... }:

{
  # Imports (se necessário)
  imports = [ ];

  # Options (se for módulo reutilizável)
  options = { };

  # Config
  config = {
    # configurações aqui
  };
}
```

### 3. Comentários
```nix
# Descrição do módulo no topo
# Propósito: Configurar X para Y

{ config, lib, pkgs, ... }:

{
  # Seção de hardware
  hardware.bluetooth = {
    enable = true;
    # Ativa ao boot para reconexão automática
    powerOnBoot = true;
  };
}
```

### 4. Agrupamento Lógico
```nix
# ❌ EVITAR
services.printing.enable = true;
hardware.bluetooth.enable = true;
services.pipewire.enable = true;

# ✅ PREFERIR
# Serviços de sistema
services = {
  printing.enable = true;
  pipewire.enable = true;
};

# Hardware
hardware.bluetooth.enable = true;
```

---

## 📝 Checklist de Ação Imediata

### Correções Urgentes (Evitar Erros)
1. [ ] Adicionar `quickshell` aos inputs do flake.nix
2. [ ] Corrigir paths em configuration.nix (adicionar `hosts/`)
3. [ ] Remover import de environment.nix
4. [ ] Remover grupo "video" duplicado
5. [ ] Corrigir formatação de packages.nix

### Melhorias de Organização (Recomendado)
1. [ ] Renomear `hosts/default/` → `hosts/nixos/`
2. [ ] Renomear `hosts/system/` → `hosts/common/`
3. [ ] Mover portainer.nix para hosts/common/services/
4. [ ] Separar hardware em módulos (nvidia, bluetooth, audio)
5. [ ] Criar módulos boot.nix, networking.nix, fonts.nix
6. [ ] Adicionar comentários de documentação

### Opcional (Boas Práticas)
1. [ ] Padronizar uso de paths (só ${self} ou só relativo)
2. [ ] Criar pasta packages/ para derivações customizadas
3. [ ] Documentar estrutura em README.md
4. [ ] Adicionar .editorconfig para consistência de formatação

---

## 🏆 Qualidade do Flake Atual

**Nota Geral**: 7/10

**Pontos Fortes**:
- ✅ Boa separação home-manager
- ✅ Modularização do Niri bem estruturada
- ✅ Uso de Stylix para temas centralizados
- ✅ Configuração de hardware bem detalhada

**Pontos Fracos**:
- ❌ Erros de referência (inputs, paths)
- ❌ Falta de documentação
- ❌ Nomenclatura confusa (default, system)
- ❌ Arquivo monolítico (configuration.nix)

**Com as melhorias propostas**: 9/10
