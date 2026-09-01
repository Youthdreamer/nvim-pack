# nvim-pack

基于 Neovim 原生能力构建的轻量配置：使用 **`vim.pack` 原生包管理** + **原生 LSP / 补全** + **实验性 UI v2**，
不依赖 lazy.nvim 等第三方插件管理器，插件通过自定义事件（`CookLazy` / `LazyFile`）实现懒加载。

## 特性

- 📦 原生 `vim.pack` 插件管理：`vim.pack.add/update/del/get`，锁文件固定版本，无第三方管理器
- 🎨 Dracula 主题 + `bufferline` 标签栏 + `nvim-web-devicons` 图标
- 🧠 原生 LSP：`nvim-lspconfig` + 原生补全（自动触发），预置 `lua_ls`、`rust_analyzer` 配置
- ✨ `conform.nvim` 保存时自动格式化（stylua / isort+black / rustfmt / prettierd）
- 🔍 `fzf-lua` 全量文件 / 内容 / LSP 符号搜索
- 🚀 `hop` 两键跳转（`s` / `S`）
- 📁 `oil.nvim` 文件管理器（`<leader>e`），已禁用 netrw
- ⏱️ `obsess` 专注任务面板（定时器 + 待办），作者自研插件
- ⌨️ `which-key`（helix 预设）快捷键提示
- 🧩 其他：`gitsigns`、`nvim-autopairs`、`nvim-surround`、内置 `undotree`
- 💾 自动保存（切换缓冲区 / 失焦时）、yank 复制高亮
- 🖥️ SSH 远程下自动启用 OSC52 剪贴板
- 🌲 Treesitter 表达式折叠、始终显示 signcolumn、圆角窗口边框

## 环境要求

| 依赖 | 说明 |
| --- | --- |
| Neovim ≥ 0.12 | 依赖 `vim.pack`、`vim.lsp.enable/config`、原生补全、`vim._core.ui2` 等 0.12 API |
| git | 安装 / 更新插件 |
| （可选）LSP server | 按需安装，如 `lua-language-server`、`rust-analyzer` |
| （可选）格式化器 | `stylua`、`isort`、`black`、`rustfmt`、`prettierd`（详见下文） |
| （可选）`rg` 等 | `fzf-lua` 全文搜索建议安装 ripgrep |

## 安装

```bash
git clone https://github.com/Youthdreamer/nvim-pack.git ~/.config/nvim
```

首次启动会自动安装全部插件（从 GitHub 下载，受网络影响可能需要等待），随后即可直接使用。

## 目录结构

```
~/.config/nvim
├── init.lua                  # 入口：启用 UI v2，加载 core 与 plugins
├── nvim-pack-lock.json       # 插件版本锁文件（vim.pack 自动维护，建议提交到 git）
└── lua
    ├── core
    │   ├── basic.lua         # 基础选项（缩进、搜索、折叠、剪贴板、SSH OSC52）
    │   ├── autocmd.lua       # 自定义事件 CookLazy / LazyFile 与常用自动命令
    │   ├── keymap.lua        # 核心快捷键
    │   └── command.lua       # 自定义命令（PackUpdate / PackDel / PackGet 等）
    └── plugins
        ├── init.lua          # 插件清单（vim.pack.add）与分类
        ├── config.lua        # LSP server 配置
        ├── editor.lua        # Oil 文件管理
        ├── lsp.lua           # LSP 启用、补全、诊断、格式化
        ├── ui.lua            # 主题图标、bufferline
        ├── utils.lua         # fzf-lua、project、which-key、obsess 等
        └── nvim.lua          # Neovim 内置插件（undotree）
```

## 插件列表

| 分类 | 插件 | 用途 |
| --- | --- | --- |
| editor | [oil.nvim](https://github.com/stevearc/oil.nvim) | 文件管理 |
| lsp | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 配置 |
| lsp | [conform.nvim](https://github.com/stevearc/conform.nvim) | 代码格式化 |
| ui | [dracula.nvim](https://github.com/mofiqul/dracula.nvim) | Dracula 主题 |
| ui | [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | 文件图标 |
| ui | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | 缓冲区标签栏 |
| utils | [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | 括号自动成对 |
| utils | [fzf-lua](https://github.com/ibhagwan/fzf-lua) | 模糊搜索 |
| utils | [hop.nvim](https://github.com/smoka7/hop.nvim) | 快速跳转 |
| utils | [project.nvim](https://github.com/DrKJeff16/project.nvim) | 项目管理 |
| utils | [nvim-surround](https://github.com/kylechui/nvim-surround) | 快捷增删改括号引号 |
| utils | [which-key.nvim](https://github.com/folke/which-key.nvim) | 快捷键提示 |
| utils | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 变更集成 |
| utils | [obsess](https://github.com/Youthdreamer/obsess) | 专注任务面板 |
| 内置 | undotree（`nvim.undotree`） | 撤销树 |

> 注：插件清单维护在 `lua/plugins/init.lua` 的 `plugins_list` 中。

## 插件管理

插件基于 Neovim 原生 `vim.pack`：

- **安装**：修改 `lua/plugins/init.lua` 的 `plugins_list` 添加条目（`{ src = "仓库地址" }`），
  下次启动或执行 `:PackUpdate` 即可安装
- **更新**：`:PackUpdate`（可按名称精确更新，如 `:PackUpdate fzf-lua`，支持 Tab 补全）
- **删除**：`:PackDel <name>`（可从清单与磁盘移除）
- **查看**：`:PackGet [name]` 打印插件信息
- **版本锁定**：`nvim-pack-lock.json` 记录每个插件的精确提交，保证可复现

### 懒加载机制

`vim.pack.add(..., { load = false })` 只注册、不加载插件，实际加载由两个自定义事件驱动：

- **`CookLazy`**：`VimEnter` 时触发，加载 UI / 搜索等高频插件（devicons、fzf-lua、project、which-key、obsess）
- **`LazyFile`**：打开第一个文件后触发，加载文件级插件（bufferline、gitsigns、conform）
- 其余按需加载：autopairs / surround 在首次进入插入模式时加载，hop 在使用时加载

## LSP 与格式化

LSP server 配置集中在 `lua/plugins/config.lua`，`lsp.lua` 会遍历该表自动启用，当前预置：

- **lua_ls**：LuaJIT 运行时、`vim` 全局变量诊断、启用 inlay hint
- **rust_analyzer**：clippy 检查（保存时）、inlay hints

添加新语言：在 `lua/plugins/config.lua` 的 `servers` 表中增加一个条目即可，例如：

```lua
["pyright"] = {
  settings = {
    python = { analysis = { typeCheckingMode = "basic" } },
  },
},
```

**补全**：原生补全，`LspAttach` 后自动触发（`autotrigger`）；补全菜单最多显示 5 条、圆角边框；
支持 `completeopt` 的 `fuzzy` 模糊匹配；`<C-Space>` 手动触发。

**诊断**：行内 virtual_text 始终显示、插入模式实时更新；`<leader>d` 打开诊断浮窗。

**格式化**（conform，保存时自动执行，超时 500ms，无格式化器时回退 LSP）：

| 文件类型 | 格式化器 |
| --- | --- |
| lua | stylua |
| python | isort, black |
| rust | rustfmt（LSP 回退） |
| javascript / typescript | prettierd, prettier |

`<leader>lf` 手动格式化当前缓冲区。

## 快捷键

> `<leader>` 为空格键；`<tab>` 为 Tab 键。

### 基础编辑

| 模式 | 按键 | 功能 |
| --- | --- | --- |
| n | `j` / `k` | 折行感知移动（无计数时按可视行移动） |
| i/n/v/s | `<C-s>` | 保存文件 |
| i/n | `<C-a>` | 全选 |
| n | `<leader>qq` | 退出编辑器（`:wqa`） |

### 窗口与标签页

| 按键 | 功能 |
| --- | --- |
| `<C-Up>` / `<C-Down>` | 增加 / 减少窗口高度 |
| `<C-Left>` / `<C-Right>` | 增加 / 减少窗口宽度 |
| `<leader>wH` / `<leader>wJ` | 窗口移到左边 / 底部 |
| `<leader>wK` / `<leader>wL` | 窗口移到顶部 / 右边 |
| `<leader><tab><tab>` | 新建标签页 |
| `<leader><tab>d` / `<tab>o` | 关闭当前 / 其他标签页 |
| `<leader><tab>l` / `<tab>h` | 下一个 / 上一个标签页 |

### 行移动

| 模式 | 按键 | 功能 |
| --- | --- | --- |
| n | `<A-j>` / `<A-k>` | 下移 / 上移当前行 |
| v | `<A-j>` / `<A-k>` | 下移 / 上移选中区域 |

### 文件管理（Oil）

| 按键 | 功能 |
| --- | --- |
| `<leader>e` | 切换 Oil 文件管理器 |

### 缓冲区（bufferline）

| 按键 | 功能 |
| --- | --- |
| `]b` / `[b` | 下一个 / 上一个缓冲区 |
| `<leader>bb` | 快速切换缓冲区（上一个编辑的文件） |
| `<leader>bd` | 删除缓冲区 |
| `<leader>bf` | 搜索并跳转缓冲区 |
| `<leader>bo` | 关闭其他缓冲区 |
| `<leader>bp` | 切换缓冲区固定状态 |
| `<leader>bP` | 关闭未固定的缓冲区 |

### 查找（fzf-lua）

| 按键 | 功能 |
| --- | --- |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局内容搜索（live_grep） |
| `<leader>fb` | 缓冲区搜索 |
| `<leader>fo` | 最近使用的文件 |
| `<leader>fs` | 搜索当前单词 |
| `<leader>fk` | 搜索快捷键 |
| `<leader>fh` | 搜索帮助标签 |

### LSP 操作

| 按键 | 功能 |
| --- | --- |
| `<C-Space>`（插入模式） | 手动触发补全 |
| `<leader>d` | 打开诊断浮窗 |
| `<leader>lf` | 格式化当前缓冲区 |
| `<leader>cR` | 重命名符号 |
| `<leader>cd` / `<leader>cr` | 跳转定义 / 查找引用 |
| `<leader>ci` / `<leader>ct` | 实现 / 类型定义 |
| `<leader>ca` | 代码操作 |
| `<leader>cs` | 当前文件符号 |
| `<leader>cw` / `<leader>lw` | 工作区符号 |
| `<leader>cW` | 工作区诊断 |

### 跳转与项目

| 按键 | 功能 |
| --- | --- |
| `s` | hop 两字符跳转 |
| `S` | hop 单词跳转 |
| `<leader>fp` | 项目切换（project.nvim + fzf） |
| `<leader>uu` | 打开撤销树（Neovim 内置） |

### Obsess 专注面板

| 按键 | 功能 |
| --- | --- |
| `<leader>ot` | 设置倒计时（分钟） |
| `<leader>os` | 设置倒计时（秒） |
| `<leader>ow` | 显示 / 隐藏窗口 |
| `<leader>oc` | 关闭窗口并停止计时 |
| `<leader>oa` | 添加任务 |
| `<leader>ox` | 切换任务完成状态 |
| `<leader>od` | 删除任务 |
| `<leader>oe` | 清空任务列表 |
| `<leader>ol` | 加载任务面板 |

### which-key 前缀分组

| 前缀 | 分组 |
| --- | --- |
| `<leader>e` | 文件管理（Oil） |
| `<leader>b` | 缓冲区操作 |
| `<leader>f` | 文件查找 |
| `<leader>c` | LSP 操作 |
| `<leader>q` | 退出编辑器 |
| `<leader>w` | 窗口操作 |
| `<leader><tab>` | 标签栏 |
| `<leader>o` | 专注面板 |
| `<leader>u` | Undotree |
| `<leader>l` | 项目相关 |

## 自定义命令

| 命令 | 说明 |
| --- | --- |
| `:PackUpdate [name...]` | 更新全部（或指定）插件 |
| `:PackDel [name...]` | 删除插件 |
| `:PackGet [name...]` | 查看插件信息 |
| `:LspInfo` | LSP 健康检查（`:checkhealth vim.lsp`） |
| `:LspLog` | 在新标签页打开 LSP 日志 |

## SSH 远程环境

检测到 SSH 连接（`SSH_CONNECTION` / `SSH_CLIENT` / `SSH_TTY`）时自动启用 **OSC52** 剪贴板，
`y` 复制的文本可直接粘贴到本地终端。注意：OSC52 接管复制后，插件（如 flash）的远程复制
无法通过 `p` 粘贴，远程场景更推荐使用终端自带的粘贴快捷键（如 `Ctrl+Shift+V`）。

## FAQ

**Q：首次启动很慢 / 报网络错误？**
插件首次需要从 GitHub 下载，可重试 `:PackUpdate`；网络受限时可配置 git 代理或镜像。

**Q：如何添加 / 删除插件？**
编辑 `lua/plugins/init.lua` 的 `plugins_list`，添加 `{ src = "仓库地址" }` 条目后执行
`:PackUpdate <name>`；删除用 `:PackDel <name>`。

**Q：如何更换主题？**
修改 `lua/plugins/init.lua` 中的 `vim.cmd([[colorscheme dracula]])`，并在插件清单中添加对应主题插件。

**Q：为什么要求 Neovim 0.12+？**
配置使用了 `vim.pack`、`vim.lsp.enable/config`、原生补全（`vim.lsp.completion`）、
`vim._core.ui2`（实验性 UI）等 0.12 引入的 API。

**Q：不需要第三方包管理器吗？**
不需要。插件管理、懒加载均由原生 `vim.pack` + 自定义事件（`CookLazy` / `LazyFile`）实现。
