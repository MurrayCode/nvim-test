local Runner = require("nvim-test.runner")
local jest = require("nvim-test.runners.jest")
local utils = require("nvim-test.utils")

local vitest = Runner:init({
	command = { "./node_modules/.bin/vitest", "vitest" },
	file_pattern = "\\v(__tests__/.*|(spec|test))\\.(js|jsx|ts|tsx)$",
	find_files = { "{name}.test.{ext}", "{name}.spec.{ext}" },
}, {
	javascript = jest.queries.javascript,
	typescript = jest.queries.typescript,
})

function vitest:parse_testname(name)
	return jest:parse_testname(name)
end

function vitest:build_test_args(args, tests)
	table.insert(args, "-f")
	table.insert(args, table.concat(tests, " "))
end

function vitest:find_working_directory(filename)
	local root = self.config.working_directory
	if not root then
		root = utils.find_relative_root(filename, "package.json")
	end
	return root
end

return vitest
