# Neovim (Linux/WSL2) — Setup e Guia Completo

Config baseada em `lazy.nvim`, com LSP moderno (TS/JS via `vtsls`, Lua, CSS, Tailwind, ESLint, Go, PHP, Python), Treesitter, Telescope, formatação com `conform.nvim`, terminal integrado, DAP, Neotest, tema Gruvbox Material e integração com tmux.

## Índice

1. Comece aqui (TL;DR)
2. Fluxo diário (opiniado)
3. Conceitos‑chave (Vim em 5 minutos)
4. Instalação e requisitos
5. Estrutura do projeto
6. Cheatsheet (atalhos por tema)
7. Playbooks por feature (passo a passo)
   - 7.1 Telescope & File Browser
   - 7.2 Formatação & Lint (Conform)
   - 7.3 LSP, Completion & Tailwind
   - 7.4 Terminal (ToggleTerm)
   - 7.5 Testes (Neotest)
   - 7.6 Depuração (DAP)
   - 7.7 Tmux
8. Ferramentas externas por stack
9. Troubleshooting (erros comuns)
10. Manutenção (atualizar, medir performance)
11. FAQ curta

## 1) Comece aqui (TL;DR)

- Instale dependências:

```bash
sudo apt update && sudo apt install -y neovim git build-essential ripgrep fd-find tmux
mkdir -p ~/.local/bin && ln -s $(command -v fdfind) ~/.local/bin/fd || true
```

- Node via nvm (recomendado):

```bash
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# reabra o shell
nvm install --lts
```

- Clone a config e abra o Neovim:

```bash
git clone <seu-repo-ou-pasta> ~/.config/nvim
nvim
```

- Na primeira abertura, `lazy.nvim` instalará os plugins automaticamente.

## 2) Fluxo diário (opiniado)

1. Abrir projeto e definir cwd: `<leader>fo` (File Browser) → `y` (ou `Ctrl-y` no insert) na pasta → `:pwd` para confirmar
2. Abrir arquivos: `<C-p>` (find files) ou Neo-tree `<C-n>`
3. Editar com suporte do LSP: `K`, `gd`, `<leader>rn`, `<leader>ca`
4. Formatar: on‑save (ou `<leader>gf`)
5. Procurar no projeto: `<leader>fg`
6. Terminal rápido: `<C-\>` (testes/comandos), ou `<leader>tb/tr/tf`
7. Git: `:Git` (status/commit/diff), indicadores via Gitsigns

## 3) Conceitos‑chave (Vim em 5 minutos)
- Modos: Normal (comandos), Insert (edição), Visual (seleção), Cmdline (`:`)
- Salvar/Sair: `:w`, `:q`, `:wq`, `:q!`, `:wqa`
- Buffers/Jan/Abas: `:ls`, `:bn`/`:bp`, `:split`/`:vsplit`, `<C-h/j/k/l>`, `:tabnew`
- Movimentos: `h j k l`, `w`/`b`, `0`/`$`; Buscar: `/texto` (`n`/`N`)
- Edit: `x`, `dw`, `dd`, `yy`, `p`, `u`, `<C-r>`

## 4) Instalação e requisitos

- Neovim 0.9+ (0.11+ aproveita APIs novas)
- Git, compilador C
- Ferramentas de busca: `ripgrep`, `fd`
- Tmux (opcional, para navegação integrada)
- Nerd Font (ex.: FiraCode Nerd Font) no terminal
- Stacks (conforme uso): Node.js + npm/yarn/pnpm, Python, Go, PHP

## 3) Instalação da configuração

```bash
git clone <seu-repo-ou-pasta> ~/.config/nvim
nvim
```

Se necessário, rode `:Lazy sync`.

## 5) Estrutura do projeto

- `init.lua`: bootstrap do `lazy.nvim` e carga do módulo `core`
- `lua/core/`:
  - `init.lua`: carrega opções e módulos base (sem mudar comportamento)
  - `keymaps.lua`: espaço para atalhos globais do usuário (placeholder)
  - `autocmds.lua`: espaço para automações do usuário (placeholder)
- `lua/vim-options.lua`: opções básicas do Vim/Neovim (Leader = espaço)
- `lua/plugins.lua`: plugins gerais (Conform, UI, ToggleTerm, DAP, Neotest, Which-Key, etc.)
- `lua/plugins/`: módulos por plugin (ex.: `lsp-configuration.lua`, `telescope.lua`, `treesitter.lua`, `neotree.lua`, `completions.lua`, `utils.lua`, `theme.lua`)
- `lua/plugins/lsp-configuration.lua`: LSPs, on_attach, ESLint fixAll, Tailwind config

## 6) Cheatsheet (atalhos por tema)

- Busca/Navegação (Telescope/Neo-tree)
  - `<C-p>`: buscar arquivos (inclui ocultos)
  - `<leader>fg`: live grep (inclui ocultos)
  - `<leader>fo`: abrir navegador de pastas (Telescope File Browser)
  - `<C-n>` / `<C-c>`: abrir/fechar Neo-tree
  - which-key: mantenha `<leader>` pressionado para ver grupos; ajuste de responsividade em `timeoutlen`
- Terminal (ToggleTerm)
  - `<C-\>`: alternar terminal (default: embaixo, horizontal)
  - `<leader>tb`: terminal embaixo (horizontal)
  - `<leader>tr`: terminal à direita (vertical)
  - `<leader>tF`: terminal flutuante
  - `<leader>tt`: alternar terminal (atalho extra)
- LSP
  - `K`: hover
  - `gd`: definição
  - `<leader>gr`: referências
  - `<leader>ca`: code action
  - `<leader>rn`: rename
- Formatação (Conform)
  - `<leader>gf`: formatar buffer/seleção
  - on-save ativo (exceto C/C++)
- Testes (Neotest)
  - `<leader>tn`: teste mais próximo
  - `<leader>tf`: testes do arquivo
  - `<leader>to`: painel de saída
- Depuração (DAP)
  - `<F5>/<F10>/<F11>/<F12>`: continuar/passar/entrar/sair
  - `<leader>db`: toggle breakpoint
  - `<leader>dB`: breakpoint com condição
  
- Git
  - `:Git` (vim-fugitive) para status/commits/diffs (ex.: `:Git status`, `:Git add -p`)
- Tmux
  - `<C-h>/<C-j>/<C-k>/<C-l>`: navegar entre splits/panes (vim-tmux-navigator)

## 7) Playbooks por feature (passo a passo)

### 7.1 Telescope & File Browser

- Abrir: `<C-p>` (arquivos), `<leader>fg` (conteúdo), `<leader>fo` (file browser)
- Navegar no File Browser:
  - Mover: `j/k`; entrar na pasta: `l` ou `Enter`; voltar: `h`
  - Abrir arquivo: `Enter`
  - Horizontal: `Ctrl-x`
  - Vertical: `Ctrl-v`
  - Aba: `Ctrl-t`
  - Ocultos: `Ctrl-h`
  - Seleção múltipla: `Tab` (confirme com `Enter`)
  - Criar: `Alt-c`
  - Renomear: `Alt-r`
  - Deletar: `Alt-d`
- “Entrar na pasta de verdade” (mudar a cwd):
  - Abre em modo Normal por padrão
  - Normal: `y`
  - Insert: `Ctrl-y` — muda a cwd para a pasta selecionada
  - Verifique com `:pwd`. Depois disso, Telescope usa essa pasta como base.
- Dashboard: botão “Open folder”.

### 7.2 Formatação & Lint (Conform)

- Cadeias por filetype com `stop_after_first`:
  - JS/TS/Vue → `prettierd` ou `prettier` (para no primeiro que funcionar)
  - Lua → `stylua`; Go → `goimports`; PHP → `php-cs-fixer`
- Fallback para LSP se não houver binário externo.
- On-save habilitado (exceto C/C++). Temporário por buffer:

```vim
:lua vim.b.disable_autoformat = true
```

- E447 (gf): `gf` abre “arquivo sob o cursor”. `<leader>gf` agora chama Conform, evitando o erro.
- E5108 (nested `{}` no Conform): já ajustado para `stop_after_first`.

### 7.3 LSP, Completion & Tailwind

- LSPs: `lua_ls`, `vtsls` (TS/JS, arquivos `.vue` suportados), `cssls`, `pyright`, `gopls`, `intelephense`, `eslint`, `tailwindcss`.
- Tailwind: `classRegex` para `tw\`...\``,`class="..."`,`className="..."` e cores nas sugestões via `tailwindcss-colorizer-cmp`.

Completação e snippets (nvim-cmp + LuaSnip):

- Abrir/completar manualmente: `<C-Space>`
- Confirmar sugestão: `<CR>` (Enter)
- Fechar: `<C-e>`
- Scroll na doc: `<C-f>` / `<C-b>`
- Snippets pré-carregados (friendly-snippets). Expansão automática ao confirmar.

### 7.4 Terminal (ToggleTerm)

- Toggle: `<C-\>` (horizontal embaixo por padrão). Alternativas: `<leader>tb`/`tr`/`tF`.
- Caso `<C-\>` não funcione no seu terminal/layout, teste com `<C-v>`+tecla para ver o que o Neovim recebe, ou substitua por outro mapping.

### 7.5 Testes (Neotest)

- Rodar: `<leader>tn` (mais próximo)
- `<leader>tf` (arquivo)
- Painel de saída: `<leader>to`

### 7.6 Depuração (DAP)

- Fluxo: `<F5>/<F10>/<F11>/<F12>`; breakpoints: `<leader>db` / `<leader>dB`.
- Adaptadores via `mason-nvim-dap` (ex.: `debugpy` para Python). Para Node/JS/TS, instale o adaptador (ex.: `vscode-js-debug`) e configure no projeto.

### 7.7 Tmux

- Instalação (Ubuntu/WSL2): `sudo apt install -y tmux`
- `~/.tmux.conf` mínimo:

```tmux
set -g mouse on
set -g history-limit 10000
# Redimensionar com Alt+setas
bind -n M-Left  resize-pane -L 5
bind -n M-Right resize-pane -R 5
bind -n M-Up    resize-pane -U 2
bind -n M-Down  resize-pane -D 2
```

- Navegação: `%` (vertical)
- `"` (horizontal)
- `o` (trocar pane)
- `c` (novo window)
- `,` (renomear)
- `n/p` (próx/ant)
- Integração: `vim-tmux-navigator` permite `<C-h/j/k/l>` atravessar splits/panes.

## 8) Ferramentas externas por stack

- JS/TS/Vue: `npm i -g prettier prettierd` (prettierd opcional)
- Lua: `cargo install stylua` (ou binário das releases)
- Go: `go install golang.org/x/tools/cmd/goimports@latest`
- PHP: `composer global require friendsofphp/php-cs-fixer`
- Dica: `:ConformInfo` mostra o que está disponível por filetype

## 9) Troubleshooting (erros comuns)

- ESLint não dispara: verifique presença de `eslint` e `.eslintrc.*`; veja `:LspInfo`.
- Tailwind sem sugestões: confirme `tailwind.config.*`/`postcss.config.*` na raiz; veja `:LspInfo`.
- `live_grep` sem resultados: instale `ripgrep` (`rg`).
- Formatação não ocorre: `:ConformInfo` e PATH dos binários (prettier, stylua, etc.).
- DAP não inicia: instale o adaptador (ex.: `debugpy`) e revise `:Mason`.
- WSL2: configure Nerd Font no terminal (Windows Terminal/WezTerm/Alacritty).

## 10) Manutenção

- Atualizar plugins: `:Lazy update` (ou `:Lazy sync`)
- Medir startup: `:StartupTime`
- Perfil do gerenciador: `:Lazy profile`

## 11) FAQ curta

- “Como entrar numa pasta ‘de verdade’ pelo Telescope?”
  - No File Browser, use `y` (normal) ou `Ctrl-y` (insert) para mudar a cwd; confirme com `:pwd`.
- “Quero mudar o toggle do terminal.”
  - Editar mapping em `lua/plugins.lua` (plugin `toggleterm.nvim`), chave `open_mapping` e keymaps logo abaixo.
- “Onde adiciono meus atalhos globais?”
  - `lua/core/keymaps.lua` (arquivo já existe como placeholder).

---

## 11) Guia para iniciantes (passo a passo)

### 11.1 Modos do Vim

- Normal: navega, executa comandos, usa atalhos
- Insert: edita texto (entrar com `i`, `a`, `o`, etc.)
- Visual: seleciona (`v` caractere, `V` linha)
- Command-line: `:` abre a linha de comando (ex.: `:w`, `:q`)

Trocas úteis:

- Para inserir: `i` (antes do cursor), `a` (depois), `o` (nova linha abaixo), `O` (acima)
- Para voltar ao Normal: `Esc`

### 11.2 Abrir/Salvar/Sair

- Abrir arquivo: `:e caminho/arquivo`
- Salvar: `:w`
- Sair: `:q`
- Salvar e sair: `:wq`
- Sair sem salvar (descartar mudanças): `:q!`
- Salvar todos e sair: `:wqa`

### 11.3 Buffers, Janelas e Abas

- Buffers: arquivos abertos em memória
  - Listar: `:ls`
  - Ir para n: `:b n`
  - Próx/Ant: `:bn`/`:bp`
- Janelas (splits):
  - Horizontal: `:split`
  - Vertical: `:vsplit`
  - Navegar: `<C-h/j/k/l>` (tmux-navigator integrado)
- Abas (tabs): `:tabnew`, `:tabnext`, `:tabprev`

### 11.4 Navegação básica

- Movimentos: `h j k l`
- palavras: `w`/`b`
- início/fim linha: `0`/`$`
- Procurar: `/texto` (n próximo, N anterior)
- Substituir atual: `:%s/antigo/novo/g`

### 11.5 Edição básica

- Apagar caractere: `x`
- palavra: `dw`
- linha: `dd`
- Copiar (yank): `yy` (linha)
- colar: `p`
- Desfazer/Refazer: `u`/`<C-r>`

### 11.6 Fluxo diário sugerido

1) Abrir projeto/pasta: `<leader>fo` e mude a cwd (`y`)
2) Abrir arquivos: `<C-p>` ou Neo-tree (`<C-n>`)
3) Editar com LSP: hover (`K`), go to def (`gd`), rename (`<leader>rn`)
4) Formatar: on-save ou `<leader>gf`
5) Buscar no projeto: `<leader>fg`
6) Terminal: `<C-\\>` (testes/commands rápidos)
7) Git: `:Git` para status/commit/diff

### 11.7 Git básico com Fugitive

- `:Git` abre status; use `-` para stage/unstage
- Commit: `:Git commit` (abre buffer para mensagem)
- `:Git push`
- Diff atual: `:Git diff`
- Blame: `:G blame`

### 11.8 Dicas rápidas

- which-key: segure `<leader>` para ver grupos/atalhos
- `:ConformInfo` mostra formatadores ativos
- `:LspInfo` mostra servidores LSP anexados
