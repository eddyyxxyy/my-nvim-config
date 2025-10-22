# 🚀 Configuração Profissional do Neovim

Configuração moderna, modular e otimizada do Neovim com suporte completo para desenvolvimento web (JavaScript/TypeScript/Vue), Go, PHP, Python e Lua.

---

## 📋 Índice

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Instalação](#-instalação)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Plugins Principais](#-plugins-principais)
- [Atalhos Essenciais](#-atalhos-essenciais)
- [LSP e Formatação](#-lsp-e-formatação)
- [Solução de Problemas](#-solução-de-problemas)

---

## ✨ Características

### **Core**
- ⚡ **Gerenciador de Plugins**: [lazy.nvim](https://github.com/folke/lazy.nvim) com lazy loading
- 🎨 **Tema**: [Tokyo Night](https://github.com/folke/tokyonight.nvim) (+ 6 alternativas)
- 🔍 **Fuzzy Finder**: [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- 📁 **File Explorer**: [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) com preview de imagens
- 💻 **Terminal Integrado**: [ToggleTerm](https://github.com/akinsho/toggleterm.nvim) com REPLs

### **Desenvolvimento**
- 🔧 **LSP**: Configuração automática com Mason (17+ servidores)
- 📝 **Autocompletion**: nvim-cmp com múltiplas fontes
- ✂️ **Snippets**: LuaSnip com jsregexp (transformações LSP)
- 🎯 **Formatação**: Conform.nvim com prettierd/php-cs-fixer
- 🐛 **Debug**: nvim-dap com UI integrada
- 🧪 **Testing**: Neotest com suporte para Jest

### **Git**
- 📊 **Git Signs**: Indicadores visuais de mudanças
- 🔄 **Fugitive**: Comandos Git nativos
- 👀 **Diffview**: Visualização de diffs e histórico
- 💤 **LazyGit**: Interface TUI completa
- ⚔️ **Conflict Resolution**: Resolução visual de conflitos

### **UI/UX**
- 🎨 **Dashboard**: Alpha-nvim com estatísticas
- 🔔 **Notificações**: Noice.nvim + nvim-notify
- 🗺️ **Keymaps**: Which-key para descoberta de comandos
- 🌈 **Syntax Highlighting**: Treesitter
- 📏 **Indentation Guides**: indent-blankline
- ⚡ **Status Line**: Lualine com tema sincronizado

### **Ferramentas Modernas**
- ✅ **TODO Comments**: Destaque de TODO/FIXME/NOTE
- 🔍 **Trouble**: Lista de diagnósticos elegante
- 🔁 **Mini Modules**: Pairs, surround, ai, bufremove, indentscope
- 💡 **Illuminate**: Destaque de referências
- 🎯 **Better Escape**: `jk`/`kj` para sair do insert mode
- 🎨 **Dressing**: UI melhorada para inputs/selects
- 🌐 **Kulala**: Cliente HTTP/REST

---

## 📦 Requisitos

### **Obrigatórios**
- **Neovim** >= 0.10.0
- **Git** >= 2.19.0
- **Node.js** >= 18.0 (para LSP servers)
- **ripgrep** (para Telescope grep)
- **fd** ou **fdfind** (para Telescope find)

### **Recomendados**
- **Nerd Font** (ex: FiraCode Nerd Font) - para ícones
- **xclip** ou **xsel** (Linux) - para clipboard do sistema
- **lazygit** - para integração Git
- **prettierd** - formatador rápido JS/TS (`npm install -g @fsouza/prettierd`)
- **php-cs-fixer** - formatador PHP (`composer global require friendsofphp/php-cs-fixer`)
- **Go** >= 1.21 - para desenvolvimento Go
- **PHP** >= 8.0 + Composer - para desenvolvimento PHP
- **Python** >= 3.8 + pip - para desenvolvimento Python

### **Instalação de Dependências**

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install neovim git nodejs npm ripgrep fd-find xclip

# Arch Linux
sudo pacman -S neovim git nodejs npm ripgrep fd xclip

# macOS
brew install neovim git node ripgrep fd

# Nerd Font (obrigatório para ícones)
# Baixe de: https://www.nerdfonts.com/font-downloads
# Recomendado: FiraCode Nerd Font

# Formatadores (opcional, mas recomendado)
npm install -g @fsouza/prettierd
composer global require friendsofphp/php-cs-fixer

# Adicionar Composer ao PATH (necessário para php-cs-fixer)
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.bashrc
# ou se usar zsh:
echo 'export PATH="$HOME/.config/composer/vendor/bin:$PATH"' >> ~/.zshrc
```

---

## 🚀 Instalação

### **1. Backup da Configuração Antiga** (se existir)

```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

### **2. Clonar Esta Configuração**

```bash
git clone https://github.com/SEU_USUARIO/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
```

### **3. Iniciar o Neovim**

```bash
nvim
```

O Neovim irá automaticamente:
- Instalar o lazy.nvim
- Baixar todos os plugins
- Instalar LSP servers via Mason
- Compilar Treesitter parsers

**Aguarde a instalação completa!** (pode levar alguns minutos)

### **4. Verificar Saúde da Configuração**

```vim
:checkhealth
```

Resolva qualquer WARNING crítico que apareça.

### **5. Instalar LSP Servers e Formatters**

Abra o Mason:

```vim
:Mason
```

Instale manualmente se necessário:
- `lua-language-server` (Lua)
- `typescript-language-server` (JS/TS)
- `vtsls` (TypeScript avançado)
- `vue-language-server` (Vue.js)
- `gopls` (Go)
- `intelephense` (PHP)
- `pyright` (Python)
- `eslint-lsp` (Linting JS/TS)
- `tailwindcss-language-server` (Tailwind CSS)
- `prettierd` ou `prettier` (Formatação)
- `stylua` (Formatação Lua)

---

## 📂 Estrutura do Projeto

```
~/.config/nvim/
├── init.lua                      # Entry point principal
├── lua/
│   ├── core/                     # Configurações essenciais
│   │   ├── init.lua              # Carrega vim-options e autocmds
│   │   ├── keymaps.lua           # Keymaps gerais (não específicos de plugins)
│   │   └── autocmds.lua          # Autocomandos (highlight yank, trim whitespace, etc)
│   ├── plugins/                  # Plugins modulares
│   │   ├── completions.lua       # nvim-cmp + LuaSnip
│   │   ├── dashboard.lua         # Alpha-nvim (dashboard)
│   │   ├── git.lua               # Gitsigns, Fugitive, Diffview, LazyGit, Conflicts
│   │   ├── lsp-configuration.lua # Mason + LSP configs
│   │   ├── modern-tools.lua      # TODO comments, Trouble, Mini, Illuminate, etc
│   │   ├── neotree.lua           # File explorer
│   │   ├── telescope.lua         # Fuzzy finder
│   │   ├── terminal.lua          # ToggleTerm + REPLs
│   │   ├── themes.lua            # Tokyo Night + alternativas
│   │   ├── treesitter.lua        # Syntax highlighting
│   │   └── utils.lua             # Plugins utilitários (tmux-navigator, etc)
│   ├── plugins.lua               # Plugins principais (Conform, Noice, Lualine, etc)
│   └── vim-options.lua           # Opções do Vim (movido para core/init.lua)
├── README.md                     # Esta documentação
└── CHEATSHEET.md                 # Referência rápida de atalhos
```

---

## 🔌 Plugins Principais

### **Gerenciamento e Configuração**
| Plugin | Descrição |
|--------|-----------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Gerenciador de plugins moderno e rápido |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Gerenciador de LSP/DAP/linters/formatters |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Integração Mason + LSP |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configurações LSP |

### **Navegação e Interface**
| Plugin | Descrição |
|--------|-----------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder universal |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer visual |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Dashboard de inicialização |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Guia de keymaps |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Navegação Neovim ↔ Tmux |

### **Edição e Completions**
| Plugin | Descrição |
|--------|-----------|
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Motor de autocompletion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Engine de snippets |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatação assíncrona |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting avançado |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Coleção de utilidades |

### **Git**
| Plugin | Descrição |
|--------|-----------|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Sinais de mudanças Git |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Comandos Git integrados |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Visualização de diffs |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Interface LazyGit |
| [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) | Resolução de conflitos |

### **Debug e Testing**
| Plugin | Descrição |
|--------|-----------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | UI para debugging |
| [neotest](https://github.com/nvim-neotest/neotest) | Framework de testes |
| [neotest-jest](https://github.com/nvim-neotest/neotest-jest) | Adapter Jest |

### **UI/UX**
| Plugin | Descrição |
|--------|-----------|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Tema moderno (padrão) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line elegante |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI melhorada (cmdline, messages) |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notificações animadas |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Lista de diagnósticos |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Destaque de TODOs |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Guias de indentação |

---

## ⌨️ Atalhos Essenciais

> **Leader Key**: `<Space>` (Espaço)

### **Navegação e Arquivos**
| Atalho | Ação |
|--------|------|
| `<C-p>` ou `<leader>ff` | Procurar arquivos |
| `<leader>fg` | Buscar texto (Live Grep) |
| `<leader>fb` | Procurar buffers |
| `<leader>fr` | Arquivos recentes |
| `<leader>e` | Abrir/Fechar Neo-tree |

### **Edição**
| Atalho | Ação |
|--------|------|
| `<leader>w` | Salvar e formatar |
| `<leader>q` | Fechar buffer atual |
| `<leader>Q` | Sair do Neovim |
| `<leader>gf` | Formatar buffer/seleção |
| `jk` ou `kj` | Sair do insert mode |

### **LSP**
| Atalho | Ação |
|--------|------|
| `gd` | Ir para definição |
| `gr` | Ver referências |
| `K` | Mostrar hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Renomear símbolo |
| `[d` / `]d` | Diagnóstico anterior/próximo |

### **Git**
| Atalho | Ação |
|--------|------|
| `<leader>gg` | Abrir LazyGit |
| `<leader>gd` | Diffview |
| `<leader>gs` | Git status (Telescope) |
| `<leader>gc` | Git commits |
| `]c` / `[c` | Próximo/anterior hunk |

### **Terminal**
| Atalho | Ação |
|--------|------|
| `<C-\>` | Toggle terminal flutuante |
| `<leader>th` | Terminal horizontal |
| `<leader>tv` | Terminal vertical |
| `<leader>gg` | LazyGit |

### **Diagnósticos e Erros**
| Atalho | Ação |
|--------|------|
| `<leader>xx` | Trouble: todos os diagnósticos |
| `<leader>xX` | Trouble: diagnósticos do buffer |
| `<leader>fd` | Telescope: diagnósticos |

Para a **lista completa de atalhos**, consulte [CHEATSHEET.md](./CHEATSHEET.md).

---

## 🔧 LSP e Formatação

### **LSP Servers Configurados**

| Linguagem | LSP Server | Status |
|-----------|------------|--------|
| **Lua** | lua_ls, stylua | ✅ |
| **JavaScript/TypeScript** | vtsls, ts_ls, eslint | ✅ |
| **Vue.js** | vue_ls | ✅ |
| **Go** | gopls | ✅ |
| **PHP** | intelephense | ✅ |
| **Python** | pyright | ✅ |
| **HTML** | html | ✅ |
| **CSS/SCSS** | cssls, css_variables | ✅ |
| **JSON** | jsonls | ✅ |
| **Tailwind CSS** | tailwindcss | ✅ |

### **Formatação Automática**

A formatação é executada **automaticamente ao salvar** via Conform.nvim:

```lua
<leader>w  → Salva + Formata automaticamente
<leader>gf → Formata manualmente (sem salvar)
```

**Formatadores configurados:**
- **Lua**: stylua
- **JS/TS/Vue/React**: prettierd → prettier (instalado via npm)
- **HTML/CSS/JSON/YAML/Markdown**: prettierd → prettier
- **Go**: goimports
- **PHP**: php-cs-fixer (instalado via composer)

### **Configurar LSP para Novo Projeto**

1. Abrir arquivo da linguagem desejada
2. LSP deve ativar automaticamente
3. Se não ativar, verificar `:LspInfo`
4. Instalar server faltante via `:Mason`

### **Neo-tree - Recursos Avançados**

Esta configuração inclui plugins opcionais para Neo-tree:

- **image.nvim**: Preview de imagens (PNG, JPG, SVG, etc) diretamente no Neo-tree
- **nvim-lsp-file-operations**: Operações de arquivo sincronizadas com LSP
  - Renomear arquivo → atualiza imports automaticamente
  - Mover arquivo → atualiza paths
  - Deletar arquivo → remove imports
- **nvim-window-picker**: Seletor visual de janelas para comandos `_with_window_picker`

**Navegação no Neo-tree:**
- `.` (ponto) → Mudar raiz para pasta selecionada
- `<Backspace>` → Voltar para pasta pai
- `l` ou `<Enter>` → Expandir pasta/abrir arquivo
- `h` → Fechar pasta

---

## 🔧 Manutenção e Atualizações

### **Atualizar Plugins**
```vim
:Lazy update          # Atualizar todos os plugins
:Lazy sync            # Sincronizar (limpar + instalar + atualizar)
:Lazy clean           # Remover plugins não usados
```

### **Atualizar Formatadores**
```bash
# Prettierd (JS/TS)
npm update -g @fsouza/prettierd

# PHP CS Fixer
composer global update friendsofphp/php-cs-fixer

# Verificar versões
prettierd --version
php-cs-fixer --version
```

### **Atualizar LSP Servers**
```vim
:Mason                # Abrir Mason
# Pressionar 'U' no servidor para atualizar
# Ou usar: :MasonUpdate
```

### **Verificar Saúde da Configuração**
```vim
:checkhealth          # Verificar tudo
:checkhealth conform  # Verificar formatadores
:checkhealth lsp      # Verificar LSP
:checkhealth lazy     # Verificar plugins
```

---

## 🐛 Solução de Problemas

### **1. Plugins Não Carregam**

```vim
:Lazy sync
:checkhealth lazy
```

### **2. LSP Não Funciona**

```vim
:LspInfo          # Ver servidores ativos
:Mason            # Instalar/verificar LSP servers
:checkhealth lsp
```

### **3. Ícones Não Aparecem**

**Solução**: Instale uma Nerd Font

```bash
# Download: https://www.nerdfonts.com/
# Exemplo: FiraCode Nerd Font

# Linux: copiar para ~/.local/share/fonts/
# Configurar no terminal para usar a fonte
```

### **4. Clipboard Não Funciona**

```bash
# Linux
sudo apt install xclip

# macOS - já incluído
```

### **5. Formatação Não Funciona**

```bash
# Verificar se o formatador está instalado
:Mason

# Testar manualmente
:lua require("conform").format()
```

### **6. Erros de Plugin (vim.tbl_flatten, vim.validate)**

Esses são warnings de plugins externos (neotest-jest, nvim-treesitter, noice.nvim) usando APIs antigas. **Não afetam funcionalidade** e serão corrigidos pelos autores dos plugins.

### **7. Treesitter Erros**

```vim
:TSUpdate         # Atualizar parsers
:TSInstall <lang> # Instalar parser específico
```

---

## 📚 Recursos Adicionais

### **Aprender Vim/Neovim**

```vim
:Tutor              # Tutorial interativo do Vim
:help <comando>     # Ajuda sobre qualquer comando
```

### **Documentação de Plugins**

- [lazy.nvim docs](https://lazy.folke.io/)
- [Telescope docs](https://github.com/nvim-telescope/telescope.nvim#usage)
- [LSP config guide](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
- [Which-key bindings](https://github.com/folke/which-key.nvim#%EF%B8%8F-mappings)

### **Comunidade**

- [Neovim Discourse](https://neovim.discourse.group/)
- [r/neovim](https://www.reddit.com/r/neovim/)
- [Neovim Matrix Chat](https://matrix.to/#/#neovim:matrix.org)

---

## 🎯 Próximos Passos

Após instalação, recomendo:

1. ✅ Executar `:checkhealth` e resolver WARNINGs
2. ✅ Abrir `:Mason` e verificar LSP servers instalados
3. ✅ Ler [CHEATSHEET.md](./CHEATSHEET.md) para memorizar atalhos
4. ✅ Praticar com `:Tutor`
5. ✅ Customizar tema em `lua/plugins/themes.lua`
6. ✅ Adicionar seus próprios keymaps em `lua/core/keymaps.lua`

---

## 📝 Licença

Este projeto está disponível sob a licença MIT. Sinta-se livre para usar, modificar e distribuir.

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Abra uma issue ou pull request.

---

**Desenvolvido com ❤️ para a comunidade Neovim**
