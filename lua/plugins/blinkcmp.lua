return {
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        build = {'cargo build --release'},
        opts = {
            keymap = {
                -- set to 'none' to disable the 'default' preset
                preset = 'default',

                ['<Up>'] = { 'select_prev', 'fallback' },
                ['<Down>'] = { 'select_next', 'fallback' },

                -- show with a list of providers
                ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },

            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = true },
                trigger = {
                    -- When true, will prefetch the completion items when entering insert mode
                    prefetch_on_insert = true,

                    -- When false, will not show the completion window automatically when in a snippet
                    show_in_snippet = true,

                    -- When true, will show completion window after backspacing
                    show_on_backspace = false,

                    -- When true, will show completion window after backspacing into a keyword
                    show_on_backspace_in_keyword = false,

                    -- When true, will show the completion window after accepting a completion and then backspacing into a keyword
                    show_on_backspace_after_accept = true,

                    -- When true, will show the completion window after entering insert mode and backspacing into keyword
                    show_on_backspace_after_insert_enter = true,

                    -- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
                    show_on_keyword = true,

                    -- When true, will show the completion window after typing a trigger character
                    show_on_trigger_character = true,

                    -- When true, will show the completion window after entering insert mode
                    show_on_insert = true,

                    -- LSPs can indicate when to show the completion window via trigger characters
                    -- however, some LSPs (i.e. tsserver) return characters that would essentially
                    -- always show the window. We block these by default.
                    show_on_blocked_trigger_characters = { ' ', '\n', '\t' },
                    -- You can also block per filetype with a function:
                    -- show_on_blocked_trigger_characters = function(ctx)
                        --   if vim.bo.filetype == 'markdown' then return { ' ', '\n', '\t', '.', '/', '(', '[' } end
                        --   return { ' ', '\n', '\t' }
                        -- end,

                        -- When both this and show_on_trigger_character are true, will show the completion window
                        -- when the cursor comes after a trigger character after accepting an item
                        show_on_accept_on_trigger_character = true,

                        -- When both this and show_on_trigger_character are true, will show the completion window
                        -- when the cursor comes after a trigger character when entering insert mode
                        show_on_insert_on_trigger_character = true,

                        -- List of trigger characters (on top of `show_on_blocked_trigger_characters`) that won't trigger
                        -- the completion window when the cursor comes after a trigger character when
                        -- entering insert mode/accepting an item
                        show_on_x_blocked_trigger_characters = { "'", '"', '(' },
                        -- or a function, similar to show_on_blocked_trigger_character
                    }
                },


                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },

                -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
                -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
                -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
                --
                -- See the fuzzy documentation for more information
                fuzzy = {
                    implementation = "prefer_rust",
                    prebuilt_binaries = {
                       download = true,
                       force_version = "1.6"
                    }
                }
            },
            opts_extend = { "sources.default" },
        },

    }

