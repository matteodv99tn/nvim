local ls    = require("luasnip")
local s     = ls.snippet
local sn    = ls.snippet_node
local t     = ls.text_node
local i     = ls.insert_node
local f     = ls.function_node
local d     = ls.dynamic_node
local fmt   = require("luasnip.extras.fmt").fmt
local fmta  = require("luasnip.extras.fmt").fmta
local rep   = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s({
        trig = "FUN",
        snippetType = "autosnippet"
    }, fmta(
        [[
        function <> <>(<>) 
            <>
        end % <> function
        ]],
        {i(3, "out"), i(1, "func_name"), i(2, "inputs"), i(0, "function body"), r(1)}
    ),{
        condition = line_begin 
    }),
}
