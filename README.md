# 🚀 Configuração Profissional do Neovim

Configuração moderna, modular e otimizada do Neovim com suporte completo para desenvolvimento web (JavaScript/TypeScript/Vue), Go, PHP, Python, C/C++ e Lua.

---

## 📋 Índice

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Instalação Rápida](#-instalação-rápida)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Uso Básico](#-uso-básico)
- [LSP e Formatação](#-lsp-e-formatação)
- [Solução de Problemas](#-solução-de-problemas)
- [Personalização](#-personalização)
- [Recursos Avançados](#-recursos-avançados)

---

## ✨ Características

### **Core**
- ⚡ **Gerenciador de Plugins**: [lazy.nvim](https://github.com/folke/lazy.nvim) com lazy loading
- 🎨 **Tema**: [Tokyo Night](https://github.com/folke/tokyonight.nvim) + 6 alternativas
- 🔍 **Fuzzy Finder**: [Telescope](https://github.com/nvim-telescope/telescope.nvim) com preview
- 📁 **File Explorer**: [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim) com preview de imagens
- 💻 **Terminal Integrado**: [ToggleTerm](https://github.com/akinsho/toggleterm.nvim) com REPLs

### **Desenvolvimento**
- 🔧 **LSP**: Configuração automática com Mason (17+ servidores)
- 📝 **Autocompletion**: nvim-cmp com múltiplas fontes + Tailwind colors
- ✂️ **Snippets**: LuaSnip com jsregexp (transformações LSP)
- 🎯 **Formatação**: Conform.nvim com prettierd/stylua/php-cs-fixer
- 🐛 **Debug**: nvim-dap com UI integrada
- 🧪 **Testing**: Neotest com suporte para Jest

### **Git**
- 📊 **Git Signs**: Indicadores visuais de mudanças (gitsigns)
- 🔄 **Fugitive**: Comandos Git nativos
- 👀 **Diffview**: Visualização de diffs e histórico
- 💤 **LazyGit**: Interface TUI completa
- ⚔️ **Conflict Resolution**: Resolução visual de conflitos

### **UI/UX**
- 🎨 **Dashboard**: Alpha-nvim com estatísticas de startup
- 🔔 **Notificações**: Noice.nvim + nvim-notify (UI moderna)
- 🗺️ **Keymaps**: Which-key traduzido para português com emojis
- 🌈 **Syntax Highlighting**: Treesitter
- 📏 **Indentation Guides**: indent-blankline + mini.indentscope
- ⚡ **Status Line**: Lualine sincronizada com tema

### **Ferramentas Modernas**
- ✅ **TODO Comments**: Destaque de TODO/FIXME/NOTE
- 🔍 **Trouble**: Lista elegante de diagnósticos
- 🔁 **Mini Modules**: Pairs, surround, ai, bufremove, indentscope
- 💡 **Illuminate**: Destaque automático de referências
- 🎯 **Better Escape**: `jk`/`jj` para sair do insert mode
- 🎨 **Dressing**: UI melhorada para inputs/selects
- 🌐 **Kulala**: Cliente HTTP/REST integrado

---

## 📦 Requisitos

### **Obrigatórios**
```bash
# Neovim >= 0.10.0
# Git >= 2.19.0
# Node.js >= 18.0 (para LSP servers)
# ripgrep (para Telescope grep)
# fd (para Telescope find)
```

### **Instalação de Dependências**

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install neovim git nodejs npm ripgrep fd-find xclip -y

# Arch Linux
sudo pacman -S neovim git nodejs npm ripgrep fd xclip

# macOS (Homebrew)
brew install neovim git node ripgrep fd

# Nerd Font (OBRIGATÓRIO para ícones)
# Baixe FiraCode Nerd Font de: https://www.nerdfonts.com/
# Instale e configure no terminal

# Formatadores (recomendado)
npm install -g @fsouza/prettierd
npm install -g prettier
```

---

## 🚀 Instalação Rápida

### **1. Backup da Configuração Antiga**
```bash
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
```

### **2. Clonar Esta Configuração**
```bash
git clone <seu-repositório> ~/.config/nvim
cd ~/.config/nvim
```

### **3. Iniciar o Neovim**
```bash
nvim
```

**O Neovim irá automaticamente:**
1. Instalar o lazy.nvim
2. Baixar todos os plugins
3. Instalar LSP servers via Mason
4. Compilar Treesitter parsers

**⏱️ Aguarde a instalação completa!** (2-5 minutos na primeira vez)

### **4. Verificar Saúde**
```vim
:checkhealth
```

Resolva qualquer WARNING crítico.

### **5. Instalar LSP Servers**
```vim
:Mason
```

**Servers recomendados:**
- `lua_ls` (Lua)
- `vtsls` ou `ts_ls` (TypeScript/JavaScript)
- `eslint` (Linting JS/TS)
- `tailwindcss` (Tailwind CSS)
- `gopls` (Go)
- `intelephense` (PHP)
- `pyright` (Python)
- `clangd` (C/C++)

---

## 📂 Estrutura do Projeto

```
~/.config/nvim/
├── init.lua                     # Entry point
├── lua/
│   ├── core/                    # Configurações essenciais
│   │   ├── init.lua             # Carrega vim-options e autocmds
│   │   ├── keymaps.lua          # Keymaps gerais
│   │   └── autocmds.lua         # Autocomandos
│   ├── plugins/                 # Plugins modulares
│   │   ├── completions.lua      # nvim-cmp + LuaSnip
│   │   ├── dashboard.lua        # Alpha-nvim
│   │   ├── git.lua              # Git plugins
│   │   ├── lsp-configuration.lua# Mason + LSP
│   │   ├── modern-tools.lua     # TODO, Trouble, Mini, etc
│   │   ├── neotree.lua          # File explorer
│   │   ├── telescope.lua        # Fuzzy finder
│   │   ├── terminal.lua         # ToggleTerm
│   │   ├── themes.lua           # Temas
│   │   ├── treesitter.lua       # Syntax highlighting
│   │   └── utils.lua            # Utilidades
│   ├── plugins.lua              # Plugins principais
│   └── vim-options.lua          # Opções do Vim
├── README.md                    # Esta documentação
└── CHEATSHEET.md                # Referência rápida
```

---

## 🎯 Uso Básico

### **Primeiro Uso**

**Pressione `<Space>` e aguarde** → Abre o Which-key com todos os comandos em português!

### **Comandos Mais Usados**

| Atalho | Ação | Descrição |
|--------|------|-----------|
| `<Space>ff` | Buscar arquivos | Fuzzy finder |
| `<Space>fg` | Buscar texto | Live grep |
| `<Space>e` | Explorador | Neo-tree |
| `<Space>gg` | LazyGit | Git interface |
| `<Space>w` | Salvar + Formatar | Auto-format |
| `<Space>q` | Fechar buffer | Fecha sem afetar layout |
| `gd` | Go to definition | LSP navigation |
| `<Space>rn` | Rename | Renomear símbolo |
| `<Space>ca` | Code action | Ações rápidas |
| `<Space>li` | LSP Info | Status do LSP |

Para **lista completa**, consulte [CHEATSHEET.md](./CHEATSHEET.md).

### **Primeiros Passos**

1. **Abrir arquivos**: `<Space>ff` ou `<Ctrl-p>`
2. **Explorar projeto**: `<Space>e`
3. **Buscar texto**: `<Space>fg`
4. **Git**: `<Space>gg` (LazyGit)
5. **Terminal**: `<Ctrl-\>`

---

## 🔧 LSP e Formatação

### **LSP Servers Configurados**

| Linguagem | LSP Server | Formatador |
|-----------|------------|------------|
| Lua | lua_ls | stylua |
| JavaScript/TypeScript | vtsls | prettierd |
| Vue.js | vtsls + vue plugin | prettierd |
| Go | gopls | goimports |
| PHP | intelephense | php-cs-fixer |
| Python | pyright | black/ruff |
| C/C++ | clangd | clang-format |
| HTML/CSS | html, cssls | prettierd |
| Tailwind CSS | tailwindcss | - |

### **Formatação Automática**

```lua
<Space>w  → Salva + Formata automaticamente
<Space>gf → Formata sem salvar
```

A formatação acontece **automaticamente ao salvar** via Conform.nvim.

### **Verificar LSP**

```vim
:LspInfo          # Ver LSPs ativos
:Mason            # Gerenciar servers
:checkhealth lsp  # Diagnóstico completo
```

---

## 🐛 Solução de Problemas

### **1. Plugins Não Carregam**

```vim
:Lazy sync        # Sincronizar plugins
:Lazy clean       # Remover não usados
:Lazy restore     # Restaurar versões
:checkhealth lazy # Diagnóstico
```

### **2. LSP Não Funciona**

**Sintomas:** `gd` não funciona, sem autocomplete, sem diagnósticos

**Solução:**
```vim
:LspInfo          # Verificar se LSP está ativo
:LspRestart       # Reiniciar LSP
:Mason            # Instalar/verificar servers
```

**Verificar se o server está instalado:**
```bash
# Exemplo: TypeScript
which typescript-language-server
# Se não retornar caminho, instalar via :Mason
```

### **3. Ícones Não Aparecem**

**Causa:** Nerd Font não instalada ou não configurada no terminal

**Solução:**
1. Baixe FiraCode Nerd Font: https://www.nerdfonts.com/
2. Instale a fonte no sistema
3. Configure o terminal para usar a fonte
4. Reinicie o terminal e Neovim

### **4. Clipboard Não Funciona**

```bash
# Linux
sudo apt install xclip

# Testar
echo "teste" | xclip -selection clipboard
xclip -selection clipboard -o
```

### **5. Formatação Não Funciona**

**Verificar formatador:**
```vim
:ConformInfo      # Ver formatadores ativos

# Se prettierd não estiver instalado:
:Mason            # Instalar prettierd ou prettier
```

**Ou instalar manualmente:**
```bash
npm install -g @fsouza/prettierd
which prettierd   # Verificar se está no PATH
```

### **6. Telescope Lento**

```bash
# Instalar ripgrep e fd
sudo apt install ripgrep fd-find

# Verificar instalação
rg --version
fd --version
```

### **7. Treesitter Erros**

```vim
:TSUpdate         # Atualizar parsers
:TSInstall <lang> # Instalar parser específico
```

### **8. Neovim Lento**

1. **Verificar plugins:**
```vim
:Lazy profile     # Ver tempo de carregamento
```

2. **Desabilitar plugins não usados:**
   - Edite arquivos em `lua/plugins/`
   - Comente plugins desnecessários

3. **Verificar arquivos grandes:**
   - Desabilita automaticamente features em arquivos > 1MB

### **9. Which-key Não Aparece**

```vim
:checkhealth which-key
# Verificar se timeout está correto (300ms padrão)
```

### **10. Conflitos de Teclas**

```vim
:verbose map <tecla>   # Ver mapeamentos
:WhichKey              # Ver todos os keymaps
```

---

## 🎨 Personalização

### **Mudar Tema**

Edite `lua/plugins/themes.lua`:

```lua
-- Comentar Tokyo Night
-- { "folke/tokyonight.nvim", priority = 1000, opts = {...} }

-- Descomentar outro tema
{ "rebelot/kanagawa.nvim", 
  priority = 1000, 
  config = function()
    vim.cmd("colorscheme kanagawa")
  end
}
```

**Temas disponíveis:**
- Tokyo Night (padrão)
- Kanagawa
- Catppuccin
- Gruvbox
- Rose Pine
- Nord
- Dracula

### **Adicionar Keymaps Personalizados**

Edite `lua/core/keymaps.lua`:

```lua
-- Exemplo: Abrir terminal com Ctrl+T
keymap("n", "<C-t>", "<cmd>ToggleTerm<CR>", { desc = "Terminal" })

-- Exemplo: Salvar com Ctrl+S
keymap("n", "<C-s>", "<cmd>w<CR>", { desc = "Salvar rápido" })
```

### **Adicionar Novo LSP**

1. **Via Mason:**
```vim
:Mason
# Navegar com j/k, pressionar 'i' para instalar
```

2. **Adicionar à configuração:**

Edite `lua/plugins/lsp-configuration.lua`:

```lua
ensure_installed = {
  "lua_ls",
  "vtsls",
  -- Adicione aqui:
  "rust_analyzer",  -- Rust
  "zls",            -- Zig
}
```

### **Adicionar Formatador**

Edite `lua/plugins.lua` (seção Conform):

```lua
formatters_by_ft = {
  lua = { "stylua" },
  -- Adicione:
  rust = { "rustfmt" },
  zig = { "zigfmt" },
}
```

### **Ajustar Timeout do Which-key**

Edite `lua/vim-options.lua`:

```lua
vim.opt.timeoutlen = 500  -- Aumentar para 500ms (padrão: 300ms)
```

---

## 🚀 Recursos Avançados

### **Neo-tree - Operações Sincronizadas com LSP**

Ao renomear, mover ou deletar arquivos no Neo-tree, os **imports são atualizados automaticamente**:

- **Renomear** (`r`) → Atualiza imports em todos os arquivos
- **Mover** (`m`) → Atualiza paths
- **Deletar** (`d`) → Remove imports não utilizados

### **Telescope - Busca Avançada**

```vim
<Space>fw     # Buscar palavra sob cursor
<Space>ft     # Buscar TODOs no projeto
<Space>fd     # Buscar diagnósticos (erros)
<Space>fb     # Buscar buffers
<Space>fk     # Buscar keymaps
```

### **Terminal - REPLs Integrados**

```vim
<Space>tn     # Node REPL
<Space>tp     # Python REPL
<Space>tg     # LazyGit (TUI)
<Space>th     # Htop (monitor)
```

### **Debug (DAP)**

```vim
<F5>          # Iniciar/Continuar
<F10>         # Step over
<F11>         # Step into
<F12>         # Step out
<Space>db     # Toggle breakpoint
<Space>dB     # Breakpoint condicional
```

### **Testes (Neotest)**

```vim
<Space>tn     # Rodar teste próximo
<Space>tF     # Rodar testes do arquivo
<Space>ts     # Sumário de testes
<Space>to     # Output panel
```

### **Git Workflow Completo**

```vim
# 1. Ver mudanças
<Space>gg     # LazyGit (interface completa)
]c / [c       # Navegar entre hunks

# 2. Stage mudanças
<Space>hs     # Stage hunk
<Space>hS     # Stage buffer inteiro

# 3. Commit
<Space>gc     # Commit via Telescope
# Ou LazyGit: <Space>gg → c

# 4. Push
<Space>gp     # Push via Fugitive
# Ou LazyGit: <Space>gg → P
```

---

## 📚 Recursos de Aprendizado

### **Tutoriais Interativos**
```vim
:Tutor            # Tutorial interativo do Vim (30min)
:help <comando>   # Ajuda sobre qualquer comando
```

### **Documentação Online**
- [Neovim Docs](https://neovim.io/doc/)
- [Lazy.nvim Guide](https://lazy.folke.io/)
- [Telescope Usage](https://github.com/nvim-telescope/telescope.nvim#usage)
- [LSP Config](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

### **Comunidades**
- [r/neovim](https://www.reddit.com/r/neovim/)
- [Neovim Discourse](https://neovim.discourse.group/)
- [Discord Neovim](https://discord.gg/neovim)

---

## 🔄 Manutenção

### **Atualizar Plugins**
```vim
:Lazy update      # Atualizar todos
:Lazy sync        # Sincronizar (limpar + instalar + atualizar)
```

### **Atualizar LSP Servers**
```vim
:Mason
# Pressionar 'U' no server para atualizar
```

### **Atualizar Formatadores**
```bash
npm update -g @fsouza/prettierd
composer global update friendsofphp/php-cs-fixer
```

### **Limpar Cache**
```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
nvim  # Reinstala automaticamente
```

---

## 🎯 Checklist Pós-Instalação

- [ ] `:checkhealth` - Resolver WARNINGs críticos
- [ ] `:Mason` - Verificar LSP servers instalados
- [ ] Testar formatação: `<Space>w` em arquivo JS/TS
- [ ] Testar LSP: `gd` em uma função
- [ ] Testar Telescope: `<Space>ff`
- [ ] Testar Neo-tree: `<Space>e`
- [ ] Testar LazyGit: `<Space>gg`
- [ ] Ler [CHEATSHEET.md](./CHEATSHEET.md)
- [ ] Personalizar tema (opcional)
- [ ] Adicionar keymaps pessoais (opcional)

---

## 💡 Dicas de Produtividade

1. **Use `<Space>` frequentemente** → Which-key mostra tudo
2. **Use `<Space>ff`** → Navegação rápida de arquivos
3. **Use `gd`** → Go to definition (essencial)
4. **Use `<Space>gg`** → LazyGit para todas operações Git
5. **Use `.`** → Repetir última edição
6. **Use `gcc`** → Comentar/descomentar rapidamente
7. **Use `<Space>w`** → Salvar + formatar de uma vez
8. **Use `jk`** → Sair do insert mode (mais rápido que Esc)
9. **Use `]d` / `[d`** → Navegar entre erros
10. **Use `:checkhealth`** → Sempre que algo estranho acontecer

---

## 📝 Licença

MIT License - Sinta-se livre para usar, modificar e distribuir.

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Abra uma issue ou pull request.

---

**Desenvolvido com ❤️ para a comunidade Neovim brasileira**

**Versão:** 2.0  
**Última atualização:** Outubro 2025
