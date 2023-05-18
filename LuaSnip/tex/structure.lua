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
        trig = "SEC",
        snippetType = "autosnippet" 
    }, fmta([[ 
        \section{<>}

        ]], { i(1, "section name") }
    ), {
        condition = line_begin 
    }),

    s({
        trig = "SUBSEC",
        snippetType = "autosnippet" 
    }, fmta([[ 
        \subsection{<>}

        ]], { i(1, "subsection name") }
    ), {
        condition = line_begin 
    }),

    s({
        trig = "SUBSUBSEC",
        snippetType = "autosnippet" 
    }, fmta([[ 
        \subsubsection{<>}

        ]], { i(1, "subsubsection name") }
    ), {
        condition = line_begin 
    }),

    s({
        trig = "PAR",
        snippetType = "autosnippet" 
    }, fmta([[ 
        \paragraph{<>} <>
        ]], { i(1, "subsection name"), i(0, "content...") }
    ), {
        condition = line_begin 
    }),
}
