# 🎯 Cheatsheet - Neovim

Referência rápida de todos os atalhos e comandos configurados.

> **Leader Key**: `<Space>` (Espaço)

---

## 📑 Índice

- [Básicos do Vim](#-básicos-do-vim)
- [Arquivos e Navegação](#-arquivos-e-navegação)
- [Edição e Texto](#-edição-e-texto)
- [Buffers, Janelas e Tabs](#-buffers-janelas-e-tabs)
- [LSP e Autocompletion](#-lsp-e-autocompletion)
- [Git](#-git)
- [Terminal](#-terminal)
- [Debugging](#-debugging)
- [Testing](#-testing)
- [Diagnósticos e Erros](#-diagnósticos-e-erros)
- [Snippets](#-snippets)
- [Comandos Úteis](#-comandos-úteis)

---

## 🎮 Básicos do Vim

### **Modos**
| Tecla | Modo |
|-------|------|
| `i` | Insert mode (antes do cursor) |
| `a` | Insert mode (depois do cursor) |
| `I` | Insert no início da linha |
| `A` | Insert no final da linha |
| `o` | Nova linha abaixo + insert |
| `O` | Nova linha acima + insert |
| `v` | Visual mode (seleção) |
| `V` | Visual Line mode |
| `<C-v>` | Visual Block mode |
| `Esc` ou `jk` ou `kj` | Sair para Normal mode |

### **Navegação Básica**
| Tecla | Ação |
|-------|------|
| `h` `j` `k` `l` | ← ↓ ↑ → |
| `w` | Próxima palavra |
| `b` | Palavra anterior |
| `e` | Final da palavra |
| `0` | Início da linha |
| `^` | Primeiro caractere não-branco |
| `$` | Final da linha |
| `gg` | Início do arquivo |
| `G` | Final do arquivo |
| `<número>G` | Ir para linha |
| `%` | Ir para parêntese/colchete correspondente |
| `{` / `}` | Parágrafo anterior/próximo |
| `<C-d>` | Scroll down (meio página) |
| `<C-u>` | Scroll up (meio página) |

### **Edição Básica**
| Tecla | Ação |
|-------|------|
| `x` | Deletar caractere |
| `dd` | Deletar linha |
| `dw` | Deletar palavra |
| `d$` | Deletar até fim da linha |
| `yy` | Copiar linha |
| `yw` | Copiar palavra |
| `p` | Colar depois |
| `P` | Colar antes |
| `u` | Desfazer |
| `<C-r>` | Refazer |
| `.` | Repetir último comando |
| `r<char>` | Substituir caractere |
| `cw` | Trocar palavra |
| `cc` | Trocar linha |

### **Busca**
| Tecla | Ação |
|-------|------|
| `/texto` | Buscar "texto" |
| `n` | Próximo resultado |
| `N` | Resultado anterior |
| `*` | Buscar palavra sob cursor |
| `#` | Buscar palavra sob cursor (reverso) |
| `<Esc>` | Limpar destaque de busca |

---

## 📁 Arquivos e Navegação

### **Telescope (Fuzzy Finder)**
| Atalho | Descrição |
|--------|-----------|
| `<C-p>` | Procurar arquivos |
| `<leader>ff` | Procurar arquivos (Find Files) |
| `<leader>fg` | Buscar texto em arquivos (Live Grep) |
| `<leader>fb` | Procurar buffers abertos |
| `<leader>fh` | Histórico de arquivos |
| `<leader>fr` | Arquivos recentes (Oldfiles) |
| `<leader>fc` | Procurar comandos |
| `<leader>fk` | Procurar keymaps |
| `<leader>fm` | Procurar marks |
| `<leader>fo` | File Browser |
| `<leader>fd` | Diagnósticos (erros/warnings) |

**Dentro do Telescope:**
| Tecla | Ação |
|-------|------|
| `<C-j>` / `<C-k>` | Navegar resultados |
| `<C-n>` / `<C-p>` | Histórico de buscas |
| `<CR>` | Abrir arquivo |
| `<C-x>` | Abrir em split horizontal |
| `<C-v>` | Abrir em split vertical |
| `<C-t>` | Abrir em nova tab |
| `<C-u>` / `<C-d>` | Scroll preview |
| `<Esc>` | Fechar |

### **Neo-tree (File Explorer)**
| Atalho | Descrição |
|--------|-----------|
| `<leader>e` | Abrir/Fechar Neo-tree |
| `<leader>ec` | Fechar Neo-tree |
| `<leader>eb` | Neo-tree: Buffers |
| `<leader>eg` | Neo-tree: Git Status |

**Dentro do Neo-tree:**
| Tecla | Ação |
|-------|------|
| `<CR>` ou `l` | Abrir arquivo/expandir pasta |
| `h` | Fechar pasta |
| `.` | **Entrar na pasta** (mudar raiz) |
| `<Backspace>` | **Voltar para pasta pai** |
| `a` | Criar arquivo/pasta |
| `d` | Deletar (sincroniza com LSP) |
| `r` | Renomear (sincroniza com LSP - atualiza imports) |
| `y` | Copiar para clipboard |
| `x` | Recortar |
| `p` | Colar |
| `c` | Copiar arquivo |
| `m` | Mover arquivo (sincroniza com LSP - atualiza paths) |
| `R` | Refresh |
| `H` | Toggle arquivos ocultos |
| `/` | Busca fuzzy |
| `?` | Ajuda (ver todos os comandos) |
| `q` | Fechar |
| `oc` | Ordenar por data de criação |
| `om` | Ordenar por data de modificação |
| `on` | Ordenar por nome |
| `os` | Ordenar por tamanho |
| `od` | Ordenar por diagnósticos |

**Recursos Avançados:**
- 🖼️ **Preview de Imagens**: Arquivos PNG/JPG/SVG são exibidos automaticamente
- 🔧 **LSP File Operations**: Renomear/mover/deletar atualiza imports automaticamente
- 🎯 **Window Picker**: Comandos `_with_window_picker` mostram seletor de janelas

---

## ✏️ Edição e Texto

### **Salvar e Sair**
| Atalho | Descrição |
|--------|-----------|
| `<leader>w` | **Salvar e formatar** (automaticamente) |
| `<leader>W` | Salvar todos os buffers |
| `<leader>q` | **Fechar buffer atual** |
| `<leader>Q` | Sair de tudo (Neovim completo) |
| `<leader>x` | Salvar e sair da janela |
| `<leader>bd` | Deletar buffer (forçado, mesmo com mudanças) |

### **Formatação**
| Atalho | Descrição |
|--------|-----------|
| `<leader>gf` | Formatar buffer/seleção (manual, sem salvar) |
| `<leader>w` | Formatar + salvar (automático) |

### **Navegação Melhorada**
| Atalho | Descrição |
|--------|-----------|
| `j` / `k` | Navegar linhas wrapped |
| `<C-d>` | Scroll down (centralizado) |
| `<C-u>` | Scroll up (centralizado) |
| `n` | Próximo resultado de busca (centralizado) |
| `N` | Resultado anterior (centralizado) |

### **Edição Avançada**
| Atalho | Descrição |
|--------|-----------|
| `J` (normal) | Juntar linhas (cursor mantém posição) |
| `J` (visual) | Mover seleção para baixo |
| `K` (visual) | Mover seleção para cima |
| `<` (visual) | Indentar esquerda (manter seleção) |
| `>` (visual) | Indentar direita (manter seleção) |

### **Clipboard do Sistema**
| Atalho | Descrição |
|--------|-----------|
| `<leader>y` | Copiar para clipboard do sistema |
| `<leader>Y` | Copiar linha para clipboard |
| `<leader>p` | Colar do clipboard |
| `<leader>P` | Colar antes do cursor |
| `<leader>d` | Deletar sem copiar (void register) |

### **Mini.Surround**
| Atalho | Descrição |
|--------|-----------|
| `sa<motion><char>` | Adicionar surround (ex: `saiw"` → "word") |
| `sd<char>` | Deletar surround (ex: `sd"` → remove aspas) |
| `sr<old><new>` | Substituir surround (ex: `sr"'` → " para ') |
| `sh<char>` | Highlight surround |
| `sn` | Próximo surround |
| `sl` | Último surround |

**Exemplos:**
- `saiw"` → Adiciona aspas na palavra: `word` → `"word"`
- `sd(` → Remove parênteses: `(hello)` → `hello`
- `sr"'` → Troca aspas duplas por simples

### **Comentários**
| Atalho | Descrição |
|--------|-----------|
| `gcc` | Comentar/descomentar linha |
| `gc<motion>` | Comentar motion (ex: `gcap` → comentar parágrafo) |
| `gc` (visual) | Comentar seleção |
| `gbc` | Comentar bloco |
| `gco` | Inserir comentário linha abaixo |
| `gcO` | Inserir comentário linha acima |
| `gcA` | Inserir comentário fim da linha |

### **Busca e Substituição**
| Atalho | Descrição |
|--------|-----------|
| `<leader>s` | Substituir palavra sob cursor (interativo) |
| `<leader>ch` | Limpar destaque de busca |
| `<Esc>` | Limpar destaque |

---

## 🗂️ Buffers, Janelas e Tabs

### **Conceitos**
- **Buffer** = Arquivo carregado na memória
- **Window** = "Viewport" que mostra um buffer (split)
- **Tab** = Layout de janelas (workspace)

### **Buffers**
| Atalho | Descrição |
|--------|-----------|
| `<Tab>` | Próximo buffer |
| `<S-Tab>` | Buffer anterior |
| `<leader>q` | **Fechar buffer atual** (mini.bufremove) |
| `<leader>bd` | Deletar buffer (forçado) |
| `<leader>fb` | Telescope: procurar buffer |
| `:buffers` | Listar todos os buffers |

### **Janelas (Splits)**
| Atalho | Descrição |
|--------|-----------|
| `<leader>sv` | Split vertical |
| `<leader>sh` | Split horizontal |
| `<leader>se` | Igualar tamanho dos splits |
| `<leader>sc` | Fechar split atual |
| `<leader>so` | Manter apenas split atual (fechar outros) |
| `<leader>bw` | Fechar janela (não o buffer) |

**Navegação entre Janelas:**
| Atalho | Ação |
|--------|------|
| `<C-h>` | Janela esquerda |
| `<C-j>` | Janela abaixo |
| `<C-k>` | Janela acima |
| `<C-l>` | Janela direita |

**Redimensionar Janelas:**
| Atalho | Ação |
|--------|------|
| `<C-Up>` | Aumentar altura |
| `<C-Down>` | Diminuir altura |
| `<C-Left>` | Diminuir largura |
| `<C-Right>` | Aumentar largura |

### **Tabs**
| Atalho | Descrição |
|--------|-----------|
| `<leader><tab>n` | Nova tab |
| `<leader><tab>c` | Fechar tab |
| `<leader><tab>]` | Próxima tab |
| `<leader><tab>[` | Tab anterior |
| `<leader><tab>o` | Fechar outras tabs |

---

## 🔧 LSP e Autocompletion

### **Navegação de Código**
| Atalho | Descrição |
|--------|-----------|
| `gd` | Ir para definição |
| `gD` | Ir para declaração |
| `gr` | Ver referências |
| `gi` | Ir para implementação |
| `gt` | Ir para type definition |
| `K` | Mostrar hover documentation |
| `<C-k>` | Mostrar signature help |
| `gO` | Document symbols (Telescope) |

### **Code Actions**
| Atalho | Descrição |
|--------|-----------|
| `<leader>ca` | Code action |
| `<leader>rn` | Renomear símbolo |
| `<leader>gf` | Formatar código |

### **Diagnósticos**
| Atalho | Descrição |
|--------|-----------|
| `]d` | Próximo diagnóstico |
| `[d` | Diagnóstico anterior |
| `]e` | Próximo erro |
| `[e` | Erro anterior |
| `<leader>dl` | Location list com diagnósticos |
| `<leader>dq` | Quickfix com diagnósticos |

### **Autocompletion (Insert Mode)**
| Atalho | Ação |
|--------|------|
| `<C-Space>` | Trigger completion |
| `<C-n>` | Próximo item |
| `<C-p>` | Item anterior |
| `<CR>` | Confirmar seleção |
| `<C-e>` | Cancelar |
| `<C-b>` | Scroll docs para cima |
| `<C-f>` | Scroll docs para baixo |
| `<Tab>` | Próximo item / expandir snippet |
| `<S-Tab>` | Item anterior / voltar snippet |

### **Text Objects (mini.ai)**
| Atalho | Descrição |
|--------|-----------|
| `vaf` | Selecionar função (around) |
| `vif` | Selecionar dentro da função (inside) |
| `vac` | Selecionar classe (around) |
| `vic` | Selecionar dentro da classe |
| `va[` / `vi[` | Around/Inside colchetes |
| `va(` / `vi(` | Around/Inside parênteses |
| `va{` / `vi{` | Around/Inside chaves |
| `vat` / `vit` | Around/Inside tags HTML |
| `vaq` / `viq` | Around/Inside quotes |

---

## 🌿 Git

### **Principais**
| Atalho | Descrição |
|--------|-----------|
| `<leader>gg` | **Abrir LazyGit** (interface TUI completa) |
| `<leader>gd` | **Diffview** (ver mudanças) |
| `<leader>gD` | **Diffview fechar** |
| `<leader>gh` | **Diffview histórico** do arquivo |
| `<leader>gH` | **Diffview histórico** completo |

### **Telescope Git**
| Atalho | Descrição |
|--------|-----------|
| `<leader>gs` | Git status |
| `<leader>gc` | Git commits |
| `<leader>gC` | Git commits do buffer |
| `<leader>gb` | Git branches |

### **Gitsigns (Hunks)**
| Atalho | Descrição |
|--------|-----------|
| `]c` | Próximo hunk (mudança) |
| `[c` | Hunk anterior |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame linha |
| `<leader>hd` | Diff do arquivo |

### **Fugitive**
| Atalho | Descrição |
|--------|-----------|
| `<leader>ga` | Git add (arquivo atual) |
| `<leader>gA` | Git add --all |
| `<leader>gm` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gP` | Git pull |
| `<leader>gl` | Git log |

### **Git Conflicts**
| Atalho | Descrição |
|--------|-----------|
| `co` | Escolher "ours" (nosso) |
| `ct` | Escolher "theirs" (deles) |
| `cb` | Escolher "both" (ambos) |
| `c0` | Escolher "none" (nenhum) |
| `]x` | Próximo conflito |
| `[x` | Conflito anterior |

---

## 💻 Terminal

### **Toggle Terminal**
| Atalho | Descrição |
|--------|-----------|
| `<C-\>` | Toggle terminal **flutuante** |
| `<leader>th` | Terminal **horizontal** |
| `<leader>tv` | Terminal **vertical** |
| `<leader>tf` | Terminal **flutuante** |

### **Ferramentas**
| Atalho | Descrição |
|--------|-----------|
| `<leader>gg` | **LazyGit** (Git TUI) |
| `<leader>tp` | **Htop** (monitor de processos) |
| `<leader>tn` | **Node REPL** |
| `<leader>tP` | **Python REPL** |

**Dentro do Terminal:**
| Atalho | Ação |
|--------|------|
| `<C-\>` | Toggle (fechar/abrir) |
| `<Esc><Esc>` | Modo normal |
| `i` | Voltar para terminal mode |

---

## 🐛 Debugging

### **Controles de Debug**
| Atalho | Descrição |
|--------|-----------|
| `<F5>` | **Continuar / Iniciar debug** |
| `<F10>` | **Step over** (próxima linha) |
| `<F11>` | **Step into** (entrar na função) |
| `<F12>` | **Step out** (sair da função) |
| `<leader>db` | **Toggle breakpoint** |
| `<leader>dB` | **Breakpoint condicional** |
| `<leader>dr` | **Abrir REPL** |
| `<leader>dl` | **Executar último** |

### **DAP UI**
A UI de debug abre automaticamente ao iniciar debug (`<F5>`).

**Comandos úteis:**
```vim
:DapContinue        # Iniciar/continuar
:DapToggleBreakpoint # Breakpoint
:DapTerminate       # Parar debug
```

---

## 🧪 Testing

### **Neotest**
| Atalho | Descrição |
|--------|-----------|
| `<leader>tn` | **Rodar teste mais próximo** |
| `<leader>tF` | **Rodar todos os testes do arquivo** |
| `<leader>to` | **Toggle output panel** |
| `<leader>ts` | **Toggle summary** (visão geral) |

**Comandos úteis:**
```vim
:Neotest run         # Rodar teste
:Neotest summary     # Abrir summary
:Neotest output      # Ver output
```

---

## 🚨 Diagnósticos e Erros

### **Trouble**
| Atalho | Descrição |
|--------|-----------|
| `<leader>xx` | **Trouble: Todos os diagnósticos** (workspace) |
| `<leader>xX` | **Trouble: Diagnósticos do buffer** atual |
| `<leader>cs` | Trouble: Símbolos do documento |
| `<leader>cl` | Trouble: LSP definitions/references |
| `<leader>xL` | Trouble: Location list |
| `<leader>xQ` | Trouble: Quickfix list |

**Dentro do Trouble:**
| Tecla | Ação |
|-------|------|
| `<CR>` | Ir para erro |
| `o` | Ir e manter foco no Trouble |
| `<Tab>` | Toggle preview |
| `q` | Fechar |
| `]q` | Próximo item |
| `[q` | Item anterior |

### **Quickfix e Location List**
| Atalho | Descrição |
|--------|-----------|
| `<leader>qo` | Abrir quickfix |
| `<leader>qc` | Fechar quickfix |
| `]q` | Próximo item |
| `[q` | Item anterior |
| `<leader>lo` | Abrir location list |
| `<leader>lc` | Fechar location list |
| `]l` | Próximo location |
| `[l` | Location anterior |

### **TODO Comments**
| Atalho | Descrição |
|--------|-----------|
| `]t` | Próximo TODO comment |
| `[t` | TODO comment anterior |
| `<leader>ft` | Telescope: procurar TODOs |

**Tags reconhecidos:**
- `TODO:` - Tarefa a fazer
- `FIXME:` - Correção necessária
- `HACK:` - Solução temporária
- `WARNING:` - Aviso importante
- `PERF:` - Otimização de performance
- `NOTE:` - Nota/observação

---

## 📝 Snippets

### **Navegação**
| Atalho (Insert) | Ação |
|-----------------|------|
| `<Tab>` | Próximo campo do snippet |
| `<S-Tab>` | Campo anterior |
| `<C-e>` | Cancelar snippet |
| `<C-Space>` | Trigger completion/snippets |

### **Recursos**
- ✅ **jsregexp**: Suporte completo para transformações LSP
- ✅ **friendly-snippets**: Biblioteca com 100+ snippets
- ✅ **Transformações**: Snippets podem transformar texto (uppercase, lowercase, etc)

### **Snippets Disponíveis**

Comece a digitar e use `<C-Space>` para ver snippets disponíveis.

**Lua:**
- `fn` → function
- `req` → require
- `lf` → local function
- `if` → if statement

**JavaScript/TypeScript:**
- `cl` → console.log
- `fn` → function
- `af` → arrow function
- `if` → if statement
- `for` → for loop
- `imp` → import
- `exp` → export

**React:**
- `rfc` → React Function Component
- `us` → useState
- `ue` → useEffect
- `uref` → useRef
- `umemo` → useMemo

**Vue:**
- `v3` → Vue 3 composition
- `vref` → ref
- `vcomp` → computed
- `vwatch` → watch

**Go:**
- `fn` → func
- `if` → if err != nil
- `for` → for loop
- `struct` → struct definition

---

## 🔨 Comandos Úteis

### **Configuração**
| Comando | Descrição |
|---------|-----------|
| `:checkhealth` | Verificar saúde da configuração |
| `:Lazy` | Gerenciar plugins |
| `:Mason` | Gerenciar LSP/DAP/formatters |
| `:LspInfo` | Ver LSP servers ativos |
| `:LspRestart` | Reiniciar LSP |
| `<leader>R` | Recarregar configuração |

### **Visualização**
| Comando | Descrição |
|---------|-----------|
| `:TSUpdate` | Atualizar Treesitter parsers |
| `:TSInstall <lang>` | Instalar parser Treesitter |
| `:Telescope` | Abrir Telescope |
| `:messages` | Ver mensagens do Vim |
| `:notifications` | Ver histórico de notificações |

### **Úteis**
| Atalho | Descrição |
|--------|-----------|
| `<C-a>` | Selecionar tudo |
| `<leader>X` | Tornar arquivo executável |
| `gx` | Abrir URL sob cursor |
| `:!<comando>` | Executar comando shell |
| `:%s/old/new/g` | Substituir no arquivo todo |

### **Help**
| Comando | Descrição |
|---------|-----------|
| `:help <termo>` | Buscar ajuda |
| `:Tutor` | Tutorial interativo |
| `:WhichKey` | Ver mapeamentos |
| `<leader>fk` | Telescope: procurar keymaps |

### **Formatação e LSP**
| Comando | Descrição |
|---------|-----------|
| `:ConformInfo` | Ver formatadores disponíveis e ativos |
| `:LspInfo` | Ver LSP servers ativos |
| `:Mason` | Gerenciar LSP servers/formatadores |
| `:MasonUpdate` | Atualizar tudo no Mason |
| `:checkhealth` | Verificar saúde completa da configuração |
| `:checkhealth conform` | Verificar formatadores especificamente |
| `:checkhealth lsp` | Verificar LSP especificamente |

**Formatadores Instalados:**
- **Lua**: stylua
- **JS/TS/Vue/React**: prettierd → prettier
- **HTML/CSS/JSON/YAML**: prettierd → prettier
- **Go**: goimports
- **PHP**: php-cs-fixer

---

## 📱 Which-Key

Pressione `<leader>` e aguarde **~300ms** para ver uma janela com todos os keymaps disponíveis!

**Grupos organizados:**
- `<leader>f` → **Find** (Telescope)
- `<leader>g` → **Git**
- `<leader>h` → **Git Hunks**
- `<leader>s` → **Split** (Janelas)
- `<leader>t` → **Terminal / Testing**
- `<leader>x` → **Trouble / Quickfix**
- `<leader>d` → **Debug / Diagnósticos**
- `<leader>c` → **Code / LSP**
- `<leader>e` → **Explorer**
- `<leader>q` → **Quit / Quickfix**
- `<leader><tab>` → **Tabs**

---

## 💡 Dicas Pro

### **Produtividade**
1. Use `<C-p>` para abrir arquivos rapidamente
2. Use `<leader>gg` para todas as operações Git (LazyGit)
3. Use `.` (ponto) para repetir última edição
4. Use `gcc` para comentar/descomentar rapidamente
5. Use `<leader>w` para salvar + formatar de uma vez

### **Navegação**
1. Use `gd` para ir à definição, `<C-o>` para voltar
2. Use `]d` / `[d` para navegar entre erros
3. Use `<C-d>` / `<C-u>` para scroll rápido
4. Use `{` / `}` para pular parágrafos
5. Use `/` para buscar e `n` para próximo

### **Edição**
1. Use `ciw` para trocar palavra inteira
2. Use `vi"` para selecionar dentro de aspas
3. Use `dap` para deletar parágrafo
4. Use `<leader>y` para copiar para clipboard do sistema
5. Use `*` para buscar palavra sob cursor

### **Multi-cursor**
```vim
# Não há multi-cursor nativo, mas você pode:
# 1. Usar :%s/old/new/g para substituir
# 2. Usar . (ponto) para repetir
# 3. Usar macros: qa<comandos>q depois @a
```

### **Macros**
```vim
qa           # Começar gravar macro no registro 'a'
<comandos>   # Executar comandos
q            # Parar gravação
@a           # Executar macro 'a'
@@           # Repetir última macro
```

---

## 🎓 Recursos de Aprendizado

### **Tutoriais**
- `:Tutor` - Tutorial interativo do Vim (30 min)
- [Vim Adventures](https://vim-adventures.com/) - Jogo para aprender Vim
- [OpenVim](https://www.openvim.com/) - Tutorial interativo

### **Documentação**
- `:help <comando>` - Ajuda sobre qualquer comando
- [Neovim Docs](https://neovim.io/doc/) - Documentação oficial
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim) - Lista de plugins

### **Comunidades**
- [r/neovim](https://www.reddit.com/r/neovim/) - Reddit
- [Neovim Discourse](https://neovim.discourse.group/) - Fórum
- [Discord Neovim](https://discord.gg/neovim) - Chat

---

## 📌 Personalizações Comuns

### **Mudar Tema**
Edite `lua/plugins/themes.lua`:
```lua
-- Comente Tokyo Night
-- { "folke/tokyonight.nvim", ... }

-- Descomente outro tema
{ "rebelot/kanagawa.nvim", ... }
```

### **Adicionar Keymaps**
Edite `lua/core/keymaps.lua`:
```lua
keymap("n", "<leader>x", "<cmd>comando<CR>", { desc = "Descrição" })
```

### **Instalar Novo LSP**
```vim
:Mason
# Navegar e pressionar 'i' no server desejado
```

---

**Última atualização**: Configuração v2.0 - Outubro 2025

**Dica**: Imprima este cheatsheet ou mantenha-o aberto enquanto usa o Neovim! 🚀
