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
        trig = "MAIN",
        snippetType = "autosnippet"
    }, fmta(
        [[
        if __name__ == "__main__":
            <>
        ]],
        {i(0, "pass")}
    ),{
        condition = line_begin
    }),

    s({
        trig = "DEFMAIN",
        snippetType = "autosnippet"
    }, fmta(
        [[
        def main():
            <>


        if __name__ == "__main__":
            main()
        ]],
        {i(0, "pass")}
    ),{
        condition = line_begin
    }),


    s({
        trig = "CLASS",
        snippetType = "autosnippet"
    }, fmta(
        [[
        class <>(<>):
            """ <> class """


            def __init__(self):
                """ <> constructor """<>
                pass
        ]],
        {i(1, "classname"), i(2, "parentclass"), rep(1), rep(1), i(0)}
    ),{
        condition = line_begin
    }),
}
