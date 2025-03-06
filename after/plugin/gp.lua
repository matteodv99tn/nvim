require("gp").setup({
    providers = {
		ollama = {
		    endpoint = "http://localhost:11434/v1/chat/completions",
		},
	},
    agents = {
        {
          name = "Qwen2.5",
          provider = "ollama",
          model = { model = "qwen2.5-coder" },
          chat = true,
          command = true,
          system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
            .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
            .. "and expect precise, technical responses tailored to your development needs.\n",
        },
    },
    default_command_agent = "Qwen2.5", 
 	default_chat_agent = "Qwen2.5",
    chat_user_prefix = "󰍡 :",
    chat_confirm_delete = false,
    chat_assistant_prefix = { "󱚣 :", "[{{agent}}]" },
    chat_shortcut_respond = { modes = { "n", "v", "x" }, shortcut = "<leader>r" }, 
 	chat_shortcut_delete = { modes = { "n", "v", "x" }, shortcut = "<leader>d" }, 
 	chat_shortcut_stop = { modes = { "n", "v", "x" }, shortcut = "<leader>s" }, 
 	chat_shortcut_new = { modes = { "n", "v", "x" }, shortcut = "<leader>n" }, 
    -- default search term when using :GpChatFinder
	chat_finder_pattern = "topic ",
	chat_finder_mappings = {
		delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-d>" },
	},
	-- if true, finished ChatResponder won't move the cursor to the end of the buffer
	chat_free_cursor = false,
	-- use prompt buftype for chats (:h prompt-buffer)
	chat_prompt_buf_type = false,

	-- how to display GpChatToggle or GpContext
	---@type "popup" | "split" | "vsplit" | "tabnew"
	toggle_target = "popup",

	-- styling for chatfinder
	---@type "single" | "double" | "rounded" | "solid" | "shadow" | "none"
	style_chat_finder_border = "single",
	-- margins are number of characters or lines
	style_chat_finder_margin_bottom = 8,
	style_chat_finder_margin_left = 1,
	style_chat_finder_margin_right = 2,
	style_chat_finder_margin_top = 2,
	-- how wide should the preview be, number between 0.0 and 1.0
	style_chat_finder_preview_ratio = 0.5,

	-- styling for popup
	---@type "single" | "double" | "rounded" | "solid" | "shadow" | "none"
	style_popup_border = "single",
	-- margins are number of characters or lines
	style_popup_margin_bottom = 8,
	style_popup_margin_left = 1,
	style_popup_margin_right = 2,
	style_popup_margin_top = 2,
	style_popup_max_width = 160,

	-- in case of visibility colisions with other plugins, you can increase/decrease zindex
	zindex = 49,

	-- command config and templates below are used by commands like GpRewrite, GpEnew, etc.
	-- command prompt prefix for asking user for input (supports {{agent}} template variable)
	command_prompt_prefix_template = "🤖 {{agent}} ~ ",
	-- auto select command response (easier chaining of commands)
	-- if false it also frees up the buffer cursor for further editing elsewhere
	command_auto_select_response = true,

	-- templates
	template_selection = "I have the following from {{filename}}:"
		.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
	template_rewrite = "I have the following from {{filename}}:"
		.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		.. "\n\nRespond exclusively with the snippet that should replace the selection above.",
	template_append = "I have the following from {{filename}}:"
		.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		.. "\n\nRespond exclusively with the snippet that should be appended after the selection above.",
	template_prepend = "I have the following from {{filename}}:"
		.. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
		.. "\n\nRespond exclusively with the snippet that should be prepended before the selection above.",
	template_command = "{{command}}",

	-- example hook functions (see Extend functionality section in the README)
	hooks = {
		-- GpInspectPlugin provides a detailed inspection of the plugin state
		InspectPlugin = function(plugin, params)
			local bufnr = vim.api.nvim_create_buf(false, true)
			local copy = vim.deepcopy(plugin)
			local key = copy.config.openai_api_key or ""
			copy.config.openai_api_key = key:sub(1, 3) .. string.rep("*", #key - 6) .. key:sub(-3)
			local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(copy))
			local params_info = string.format("Command params:\n%s", vim.inspect(params))
			local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
			vim.api.nvim_win_set_buf(0, bufnr)
		end,

		-- GpInspectLog for checking the log file
		InspectLog = function(plugin, params)
			local log_file = plugin.config.log_file
			local buffer = plugin.helpers.get_buffer(log_file)
			if not buffer then
				vim.cmd("e " .. log_file)
			else
				vim.cmd("buffer " .. buffer)
			end
		end,

		-- GpImplement rewrites the provided selection/range based on comments in it
		Implement = function(gp, params)
			local template = "Having following from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please rewrite this according to the contained instructions."
				.. "\n\nRespond exclusively with the snippet that should replace the selection above."

			local agent = gp.get_command_agent()
			gp.logger.info("Implementing selection with agent: " .. agent.name)

			gp.Prompt(
				params,
				gp.Target.rewrite,
				agent,
				template,
				nil, -- command will run directly without any prompting for user input
				nil -- no predefined instructions (e.g. speech-to-text from Whisper)
			)
		end,

		CppDocument = function(gp, params)
			local template = "Having following from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Document the highlighed snippet using doxygen in Javadoc style"
				.. "\n\nRespond exclusively with the snippet of the documentation."

			local agent = gp.get_command_agent()
			gp.logger.info("Implementing selection with agent: " .. agent.name)

			gp.Prompt(
				params,
				gp.Target.prepend,
				agent,
				template,
				nil, -- command will run directly without any prompting for user input
				nil -- no predefined instructions (e.g. speech-to-text from Whisper)
			)
		end,

		CppUnitTest = function(gp, params)
			local template = "Having following from {{filename}}:\n\n"
				.. "```{{filetype}}\n{{selection}}\n```\n\n"
				.. "Please provide just the code to perform unit test of such snippet based on google Gtest suite."
				.. "\n\nRespond exclusively with the code snippet to be used in unit testing without includes"

			local agent = gp.get_command_agent()
			gp.logger.info("Implementing selection with agent: " .. agent.name)

			gp.Prompt(
				params,
				gp.Target.new,
				agent,
				template,
				nil, -- command will run directly without any prompting for user input
				nil -- no predefined instructions (e.g. speech-to-text from Whisper)
			)
		end,

		-- your own functions can go here, see README for more examples like
		-- :GpExplain, :GpUnitTests.., :GpTranslator etc.

		-- -- example of making :%GpChatNew a dedicated command which
		-- -- opens new chat with the entire current buffer as a context
		-- BufferChatNew = function(gp, _)
		-- 	-- call GpChatNew command in range mode on whole buffer
		-- 	vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
		-- end,

		-- -- example of adding command which opens new chat dedicated for translation
		-- Translator = function(gp, params)
		-- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
		-- 	gp.cmd.ChatNew(params, chat_system_prompt)
		--
		-- 	-- -- you can also create a chat with a specific fixed agent like this:
		-- 	-- local agent = gp.get_chat_agent("ChatGPT4o")
		-- 	-- gp.cmd.ChatNew(params, chat_system_prompt, agent)
		-- end,

		-- -- example of adding command which writes unit tests for the selected code
		-- UnitTests = function(gp, params)
		-- 	local template = "I have the following code from {{filename}}:\n\n"
		-- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
		-- 		.. "Please respond by writing table driven unit tests for the code above."
		-- 	local agent = gp.get_command_agent()
		-- 	gp.Prompt(params, gp.Target.enew, agent, template)
		-- end,

		-- -- example of adding command which explains the selected code
		-- Explain = function(gp, params)
		-- 	local template = "I have the following code from {{filename}}:\n\n"
		-- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
		-- 		.. "Please respond by explaining the code above."
		-- 	local agent = gp.get_chat_agent()
		-- 	gp.Prompt(params, gp.Target.popup, agent, template)
		-- end,
	},
    -- keys = function()
    --   require("which-key").add({
    --     -- VISUAL mode mappings
    --     -- s, x, v modes are handled the same way by which_key
    --     {
    --       mode = { "v" },
    --       nowait = true,
    --       remap = false,
    --       { "<A-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = "ChatNew tabnew", icon = "󰗋" },
    --       { "<A-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "ChatNew vsplit", icon = "󰗋" },
    --       { "<A-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", desc = "ChatNew split", icon = "󰗋" },
    --       { "<A-g>a", ":<C-u>'<,'>GpAppend<cr>", desc = "Visual Append (after)", icon = "󰗋" },
    --       { "<A-g>b", ":<C-u>'<,'>GpPrepend<cr>", desc = "Visual Prepend (before)", icon = "󰗋" },
    --       { "<A-g>c", ":<C-u>'<,'>GpChatNew<cr>", desc = "Visual Chat New", icon = "󰗋" },
    --       { "<A-g>g", group = "generate into new ..", icon = "󰗋" },
    --       { "<A-g>ge", ":<C-u>'<,'>GpEnew<cr>", desc = "Visual GpEnew", icon = "󰗋" },
    --       { "<A-g>gn", ":<C-u>'<,'>GpNew<cr>", desc = "Visual GpNew", icon = "󰗋" },
    --       { "<A-g>gp", ":<C-u>'<,'>GpPopup<cr>", desc = "Visual Popup", icon = "󰗋" },
    --       { "<A-g>gt", ":<C-u>'<,'>GpTabnew<cr>", desc = "Visual GpTabnew", icon = "󰗋" },
    --       { "<A-g>gv", ":<C-u>'<,'>GpVnew<cr>", desc = "Visual GpVnew", icon = "󰗋" },
    --       { "<A-g>i", ":<C-u>'<,'>GpImplement<cr>", desc = "Implement selection", icon = "󰗋" },
    --       { "<A-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent", icon = "󰗋" },
    --       { "<A-g>p", ":<C-u>'<,'>GpChatPaste<cr>", desc = "Visual Chat Paste", icon = "󰗋" },
    --       { "<A-g>r", ":<C-u>'<,'>GpRewrite<cr>", desc = "Visual Rewrite", icon = "󰗋" },
    --       { "<A-g>s", "<cmd>GpStop<cr>", desc = "GpStop", icon = "󰗋" },
    --       { "<A-g>t", ":<C-u>'<,'>GpChatToggle<cr>", desc = "Visual Toggle Chat", icon = "󰗋" },
    --       { "<A-g>w", group = "Whisper", icon = "󰗋" },
    --       { "<A-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", desc = "Whisper Append", icon = "󰗋" },
    --       { "<A-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = "Whisper Prepend", icon = "󰗋" },
    --       { "<A-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", desc = "Whisper Enew", icon = "󰗋" },
    --       { "<A-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", desc = "Whisper New", icon = "󰗋" },
    --       { "<A-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", desc = "Whisper Popup", icon = "󰗋" },
    --       { "<A-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = "Whisper Rewrite", icon = "󰗋" },
    --       { "<A-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = "Whisper Tabnew", icon = "󰗋" },
    --       { "<A-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", desc = "Whisper Vnew", icon = "󰗋" },
    --       { "<A-g>ww", ":<C-u>'<,'>GpWhisper<cr>", desc = "Whisper", icon = "󰗋" },
    --       { "<A-g>x", ":<C-u>'<,'>GpContext<cr>", desc = "Visual GpContext", icon = "󰗋" },
    --     },

    --     -- NORMAL mode mappings
    --     {
    --       mode = { "n" },
    --       nowait = true,
    --       remap = false,
    --       { "<A-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
    --       { "<A-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
    --       { "<A-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
    --       { "<A-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
    --       { "<A-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
    --       { "<A-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
    --       { "<A-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
    --       { "<A-g>g", group = "generate into new .." },
    --       { "<A-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
    --       { "<A-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
    --       { "<A-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
    --       { "<A-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
    --       { "<A-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
    --       { "<A-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
    --       { "<A-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
    --       { "<A-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
    --       { "<A-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
    --       { "<A-g>w", group = "Whisper", icon = "󰗋" },
    --       { "<A-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "[W]hisper [A]ppend" },
    --       { "<A-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "[W]hisper [P]repend" },
    --       { "<A-g>we", "<cmd>GpWhisperEnew<cr>", desc = "[W]hisper Enew" },
    --       { "<A-g>wn", "<cmd>GpWhisperNew<cr>", desc = "[W]hisper New" },
    --       { "<A-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "[W]hisper Popup" },
    --       { "<A-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "[W]hisper Inline Rewrite" },
    --       { "<A-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "[W]hisper Tabnew" },
    --       { "<A-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "[W]hisper Vnew" },
    --       { "<A-g>ww", "<cmd>GpWhisper<cr>", desc = "[W]hisper" },
    --       { "<A-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
    --     },

    --     -- INSERT mode mappings
    --     {
    --       mode = { "i" },
    --       nowait = true,
    --       remap = false,
    --       { "<A-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
    --       { "<A-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
    --       { "<A-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
    --       { "<A-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
    --       { "<A-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
    --       { "<A-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
    --       { "<A-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
    --       { "<A-g>g", group = "generate into new .." },
    --       { "<A-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
    --       { "<A-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
    --       { "<A-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
    --       { "<A-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
    --       { "<A-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
    --       { "<A-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
    --       { "<A-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
    --       { "<A-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
    --       { "<A-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
    --       { "<A-g>w", group = "Whisper" },
    --       { "<A-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
    --       { "<A-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
    --       { "<A-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
    --       { "<A-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
    --       { "<A-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
    --       { "<A-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
    --       { "<A-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
    --       { "<A-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
    --       { "<A-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
    --       { "<A-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
    --     },
    --   })
    -- end,
 	
})

require("which-key").add({
    {
        --- NORMAL mode
        mode = { "n" },
        nowait = true,
        remap = false,
        {"<C-Space>g", "<cmd>GpChatToggle popup<cr>", desc = "Toggle chat"},
    },
    {
        --- VISUAL mode
        mode = { "v" },
        nowait = true,
        remap = false,
        {"<C-Space>g", ":<C-u>'<,'>GpChatPaste popup<cr>", desc = "Paste content in chat"},
        {"<C-Space>r", ":<C-u>'<,'>GpRewrite<cr>", desc = "Rewrite based on prompt"},
        {"<C-Space>d", ":<C-u>'<,'>GpPrepend Write the docstring of the highlighed function<cr>", desc = "Prepend docstrings"},
    }
})
