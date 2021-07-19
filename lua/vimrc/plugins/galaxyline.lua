local gl = require 'galaxyline'
local condition = require 'galaxyline.condition'
local get_lsp_status = require('lsp-status').status
local trim = require('vimrc.utils').trim

local gls = gl.section

local colors = {
	-- bg = '#2E2E2E',
	bg = '#292D38',
	yellow = '#DCDCAA',
	dark_yellow = '#D7BA7D',
	cyan = '#4EC9B0',
	green = '#608B4E',
	light_green = '#B5CEA8',
	string_orange = '#CE9178',
	orange = '#FF8800',
	purple = '#C586C0',
	magenta = '#D16D9E',
	grey = '#858585',
	blue = '#569CD6',
	vivid_blue = '#4FC1FF',
	light_blue = '#9CDCFE',
	red = '#D16969',
	error_red = '#F44747',
	info_yellow = '#FFCC66',
}
local mode_color = {
	n = colors.blue,
	i = colors.green,
	v = colors.purple,
	V = colors.purple,
	c = colors.magenta,
	no = colors.blue,
	s = colors.orange,
	S = colors.orange,
	[''] = colors.orange,
	ic = colors.yellow,
	R = colors.red,
	Rv = colors.red,
	cv = colors.blue,
	ce = colors.blue,
	r = colors.cyan,
	rm = colors.cyan,
	['r?'] = colors.cyan,
	['!'] = colors.blue,
	t = colors.blue,
}
gl.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }

gls.left[1] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local color = mode_color[vim.fn.mode()]

			if color then
				vim.api.nvim_command('hi GalaxyViMode guifg=' .. color)
			end
			return '▊ '
		end,
		highlight = { colors.red, colors.bg },
	},
}
gls.left[2] = {
	GitIcon = {
		provider = function()
			return ' '
		end,
		condition = condition.check_git_workspace,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.orange, colors.bg },
	},
}
gls.left[3] = {
	GitBranch = {
		provider = 'GitBranch',
		condition = condition.check_git_workspace,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
gls.left[4] = {
	DiffAdd = {
		provider = 'DiffAdd',
		condition = condition.hide_in_width,
		icon = '  ',
		highlight = { colors.green, colors.bg },
	},
}
gls.left[5] = {
	DiffModified = {
		provider = 'DiffModified',
		condition = condition.hide_in_width,
		icon = ' 柳',
		highlight = { colors.blue, colors.bg },
	},
}
gls.left[6] = {
	DiffRemove = {
		provider = 'DiffRemove',
		condition = condition.hide_in_width,
		icon = '  ',
		highlight = { colors.red, colors.bg },
	},
}

gls.right[1] = {
	ShowLspClient = {
		provider = function()
			local status_display = get_lsp_status()
			return trim(status_display)
		end,
		condition = function()
			return not ({ ['dashboard'] = true, ['toggleterm'] = true, [' '] = true })[vim.bo.filetype]
		end,
		separator = '  ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.vivid_blue, colors.bg },
	},
}
gls.right[2] = {
	LineInfo = {
		provider = 'LineColumn',
		separator = '  ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
gls.right[3] = {
	PerCent = {
		provider = 'LinePercent',
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
gls.right[4] = {
	Tabstop = {
		provider = function()
			return 'Spaces: ' .. tostring(vim.bo.shiftwidth) .. ' '
		end,
		condition = condition.hide_in_width,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
gls.right[5] = {
	BufferType = {
		provider = 'FileTypeName',
		condition = condition.hide_in_width,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
gls.right[6] = {
	FileEncode = {
		provider = 'FileEncode',
		condition = condition.hide_in_width,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
gls.right[7] = {
	Space = {
		provider = function()
			return ' '
		end,
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.orange, colors.bg },
	},
}

gls.short_line_left[1] = {
	BufferType = {
		provider = 'FileTypeName',
		separator = ' ',
		separator_highlight = { 'NONE', colors.bg },
		highlight = { colors.grey, colors.bg },
	},
}
gls.short_line_left[2] = {
	SFileName = {
		provider = 'SFileName',
		condition = condition.buffer_not_empty,
		highlight = { colors.grey, colors.bg },
	},
}
gls.short_line_right[1] = {
	BufferIcon = { provider = 'BufferIcon', highlight = { colors.grey, colors.bg } },
}
