# CODDUO OS - Sistema Minimalista para Baixo Consumo

![CODDUO OS](https://img.shields.io/badge/CODDUO%20OS-Sistema%20Minimalista-purple)
![Arch Linux](https://img.shields.io/badge/Base-Arch%20Linux-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## 📋 Descrição

CODDUO OS é uma distribuição Linux minimalista baseada no Arch Linux, desenvolvida especificamente para ambientes de baixo consumo como sistemas embarcados ou caixas de mercado. O sistema roda exclusivamente em modo texto, sem interface gráfica, priorizando performance e eficiência.

## 🎯 Características

- **Sistema Minimalista**: Apenas pacotes essenciais para máxima eficiência
- **Modo Texto**: Interface exclusivamente em linha de comando
- **Boot Dual**: Suporte completo para UEFI e BIOS
- **Instalação Automatizada**: Script interativo com interface colorida
- **Configuração Brasileira**: Teclado ABNT2, fuso horário e locale pt_BR
- **Baixo Consumo**: Otimizado para sistemas com recursos limitados

## 🧩 Pacotes Incluídos

### Sistema Base
- **base**: Sistema base do Arch Linux
- **base-devel**: Ferramentas de desenvolvimento
- **linux**: Kernel Linux
- **linux-firmware**: Firmware do hardware

### Rede
- **networkmanager**: Gerenciador de rede
- **curl**: Cliente HTTP
- **wget**: Download de arquivos
- **openssh**: Cliente/servidor SSH

### Desenvolvimento
- **git**: Controle de versão
- **python**: Interpretador Python
- **python-pip**: Gerenciador de pacotes Python
- **npm**: Gerenciador de pacotes Node.js

### Ferramentas
- **vim**: Editor de texto
- **htop**: Monitor de processos
- **tmux**: Multiplexador de terminal
- **sudo**: Execução com privilégios

## 📂 Estrutura do Projeto

```
codduo_os/
├── airootfs/                 # Sistema de arquivos da ISO
│   ├── etc/
│   │   ├── hostname         # Nome do sistema
│   │   ├── locale.conf      # Configuração de idioma
│   │   ├── motd             # Mensagem de boas-vindas
│   │   └── vconsole.conf    # Configuração do terminal
│   └── root/
│       └── install.sh       # Script de instalação
├── efiboot/                 # Configuração UEFI
├── grub/                    # Configuração GRUB
├── syslinux/                # Configuração SYSLINUX
├── packages.x86_64          # Lista de pacotes
├── profiledef.sh            # Configuração da ISO
└── README.md               # Este arquivo
```

## 🛠️ Pré-requisitos

Para gerar a ISO, você precisa de:

- **Arch Linux** (ou sistema compatível)
- **archiso** instalado
- **Conexão com internet** para download dos pacotes
- **Pelo menos 2GB de RAM** para o processo de build
- **5GB de espaço livre** em disco

### Instalação dos Pré-requisitos

```bash
# Instalar archiso
sudo pacman -S archiso

# Verificar se o archiso está funcionando
archiso -h
```

## 🏗️ Gerando a ISO

### Método 1: Build Simples

```bash
# Clonar/baixar o projeto
git clone <repositorio> codduo_os
cd codduo_os

# Gerar a ISO
sudo mkarchiso -v -w /tmp/archiso-tmp -o out/ ./
```

### Método 2: Build com Limpeza

```bash
# Limpar builds anteriores
sudo rm -rf /tmp/archiso-tmp work/ out/

# Gerar a ISO
sudo mkarchiso -v -w /tmp/archiso-tmp -o out/ ./

# A ISO estará em: out/codduo_os-YYYY.MM.DD-x86_64.iso
```

### Método 3: Build com Script Personalizado

```bash
#!/bin/bash
# build.sh - Script de build personalizado

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${PURPLE}🛠️  Iniciando build do CODDUO OS...${NC}"

# Verificar se está rodando como root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}❌ Este script deve ser executado como root${NC}"
   exit 1
fi

# Limpar builds anteriores
echo -e "${PURPLE}🧹 Limpando builds anteriores...${NC}"
rm -rf /tmp/archiso-tmp work/ out/

# Criar diretório de output
mkdir -p out

# Gerar ISO
echo -e "${PURPLE}📦 Gerando ISO...${NC}"
mkarchiso -v -w /tmp/archiso-tmp -o out/ ./

# Verificar se a ISO foi criada
if ls out/*.iso 1> /dev/null 2>&1; then
    echo -e "${GREEN}✅ ISO gerada com sucesso!${NC}"
    echo -e "${GREEN}📁 Localização: $(ls out/*.iso)${NC}"
    echo -e "${GREEN}📊 Tamanho: $(du -h out/*.iso | cut -f1)${NC}"
else
    echo -e "${RED}❌ Falha ao gerar ISO${NC}"
    exit 1
fi
```

Torne o script executável e execute:

```bash
chmod +x build.sh
sudo ./build.sh
```

## 🧪 Testando a ISO

### Teste em Máquina Virtual (QEMU)

```bash
# Teste básico
qemu-system-x86_64 -cdrom out/codduo_os-*.iso -m 2048

# Teste com aceleração (se disponível)
qemu-system-x86_64 -cdrom out/codduo_os-*.iso -m 2048 -enable-kvm

# Teste UEFI
qemu-system-x86_64 -cdrom out/codduo_os-*.iso -m 2048 -bios /usr/share/ovmf/OVMF.fd

# Teste com disco virtual para instalação
qemu-system-x86_64 -cdrom out/codduo_os-*.iso -m 2048 -hda test.img
```

### Teste em VirtualBox

1. Abra o VirtualBox
2. Crie uma nova VM:
   - Nome: CODDUO OS Test
   - Tipo: Linux
   - Versão: Arch Linux (64-bit)
   - Memória: 2048 MB
   - Disco: 20 GB
3. Nas configurações:
   - Sistema → Habilitar EFI
   - Armazenamento → Adicionar a ISO como CD/DVD
4. Inicie a VM

### Gravação em Pendrive

```bash
# Identificar o dispositivo USB
lsblk

# Gravar a ISO (substitua sdX pelo seu dispositivo)
sudo dd if=out/codduo_os-*.iso of=/dev/sdX bs=4M status=progress oflag=sync

# Ou use o comando mais seguro
sudo cp out/codduo_os-*.iso /dev/sdX
sync
```

## 🚀 Processo de Instalação

### 1. Boot da ISO

- **BIOS**: Selecione "CODDUO OS install medium (x86_64, BIOS)"
- **UEFI**: Selecione "CODDUO OS install medium (x86_64, UEFI)"

### 2. Tela de Boas-vindas

Após o boot, você verá:

```
  ██████╗ ██████╗ ██████╗ ██████╗ ██╗   ██╗ ██████╗ 
 ██╔════╝██╔═══██╗██╔══██╗██╔══██╗██║   ██║██╔═══██╗
 ██║     ██║   ██║██║  ██║██║  ██║██║   ██║██║   ██║
 ██║     ██║   ██║██║  ██║██║  ██║██║   ██║██║   ██║
 ╚██████╗╚██████╔╝██████╔╝██████╔╝╚██████╔╝╚██████╔╝
  ╚═════╝ ╚═════╝ ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝ 

        Sistema Minimalista para Baixo Consumo
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Para instalar o CODDUO OS execute o comando:
sudo /root/install.sh
```

### 3. Executar Instalação

```bash
sudo /root/install.sh
```

### 4. Processo Interativo

O instalador guiará você através de:

1. **Seleção do Disco**: Escolha o disco de instalação
2. **Configuração do Usuário**: Defina usuário e senhas
3. **Particionamento**: Automático (UEFI/BIOS)
4. **Instalação**: Download e instalação dos pacotes
5. **Configuração**: Sistema, rede e bootloader
6. **Finalização**: Desmontagem e reinicialização

### 5. Configurações Aplicadas

- **Timezone**: America/Sao_Paulo
- **Locale**: pt_BR.UTF-8
- **Teclado**: br-abnt2
- **Hostname**: codduo-os
- **Usuário padrão**: codduo (configurável)
- **Serviços**: NetworkManager habilitado

## 🔧 Customização

### Adicionar Pacotes

Edite o arquivo `packages.x86_64`:

```bash
# Adicionar novo pacote
echo "nome-do-pacote" >> packages.x86_64

# Exemplo: adicionar neofetch
echo "neofetch" >> packages.x86_64
```

### Modificar Configurações

Edite arquivos em `airootfs/etc/`:

```bash
# Exemplo: modificar hostname
echo "meu-hostname" > airootfs/etc/hostname

# Exemplo: adicionar configuração personalizada
echo "export EDITOR=vim" >> airootfs/etc/profile
```

### Personalizar Script de Instalação

Modifique `airootfs/root/install.sh` para:

- Alterar particionamento
- Adicionar configurações específicas
- Modificar interface do usuário
- Incluir pós-instalação customizada

## 🐛 Solução de Problemas

### Build Falha

```bash
# Verificar logs
journalctl -u mkarchiso

# Limpar cache
sudo pacman -Scc
sudo rm -rf /tmp/archiso-tmp

# Verificar espaço em disco
df -h
```

### ISO Não Boota

- Verifique se a ISO foi gravada corretamente
- Teste com diferentes ferramentas (dd, cp, Rufus)
- Confirme configurações de boot no BIOS/UEFI

### Instalação Falha

- Verifique conexão com internet
- Confirme integridade do disco
- Verifique logs: `/var/log/archiso.log`

### Problemas de Rede

```bash
# Verificar interfaces
ip link show

# Configurar manualmente
sudo systemctl start NetworkManager
sudo nmcli device wifi connect "SSID" password "senha"
```

## 📋 Checklist de Teste

### Pré-build
- [ ] Arch Linux atualizado
- [ ] archiso instalado
- [ ] Espaço em disco suficiente
- [ ] Conexão com internet estável

### Pós-build
- [ ] ISO gerada sem erros
- [ ] Tamanho da ISO razoável (< 1GB)
- [ ] Boot em QEMU funcional
- [ ] Boot em hardware real

### Teste de Instalação
- [ ] Boot UEFI funcional
- [ ] Boot BIOS funcional
- [ ] Script de instalação inicia
- [ ] Particionamento automático
- [ ] Instalação completa sem erros
- [ ] Sistema inicia após instalação
- [ ] Rede funcional
- [ ] Usuário criado corretamente

## 📚 Recursos Adicionais

### Documentação
- [Arch Linux Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
- [Archiso Documentation](https://wiki.archlinux.org/title/Archiso)
- [GRUB Configuration](https://wiki.archlinux.org/title/GRUB)

### Ferramentas Úteis
- [Ventoy](https://www.ventoy.net/) - Multi-boot USB
- [Rufus](https://rufus.ie/) - Criador de USB bootável
- [Balena Etcher](https://www.balena.io/etcher/) - Gravador de imagem

### Comunidade
- [Arch Linux Forums](https://bbs.archlinux.org/)
- [Arch Linux Reddit](https://www.reddit.com/r/archlinux/)
- [Arch Linux Wiki](https://wiki.archlinux.org/)

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature
3. Faça commit das mudanças
4. Push para a branch
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para detalhes.

## 🎉 Agradecimentos

- Equipe do Arch Linux
- Comunidade archiso
- Contribuidores do projeto

---

**CODDUO OS** - Sistema Minimalista para Baixo Consumo