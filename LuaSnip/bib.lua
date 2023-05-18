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
        trig = "article",
        snippetType = "autosnippet"
    }, fmta([[ 
        @article{<>,
            author  = {<>},
            title   = {<>},
            journal = {<>},
            year    = {<>},
            volume  = {<>},
            number  = {<>},
            pages   = {<>}
        }
        ]],{
            i(1, "bibentry key"),
            i(2, "author"),
            i(3, "title"),
            i(4, "journal"),
            i(5, "year"),
            i(6, "volume"),
            i(7, "number"),
            i(8, "pages")
    }), {
        condition = line_begin 
    }),


    s({
        trig = "book",
        snippetType = "autosnippet"
    }, fmta([[ 
        @article{<>,
            author    = {<>},
            title     = {<>},
            publisher = {<>},
            address   = {<>},
            year      = {<>},
        }
        ]],{
            i(1, "bibentry key"),
            i(2, "author"),
            i(3, "title"),
            i(4, "publisher"),
            i(5, "address"),
            i(6, "year")
    }), {
        condition = line_begin 
    }),


}
