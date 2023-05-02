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

return {

    s({
        trig = "hi",
        snippetType = "autosnippet" 
    }, {
        t("Hello world")
    }),

    s({
        trig = "expr"
    },
    fmta( [[Hi <>, how are you? I'm <>, greets]], 
        {i(1, "your_name"), i(2, "my_name")}
        )
    ),
}
