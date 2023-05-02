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
        trig = "ENV",
        snippetType = "autosnippet" 
    }, fmta( [[ 
        \begin{<>}
            <>
        \end{<>}

        ]],
        {i(1, "*env-name*"), i(2, "*env-body*"), rep(1)}
    ), {
        condition = line_begin
    }),

    s({
        trig = "EQ",
        snippetType = "autosnippet" 
    }, fmta( [[ 
        \begin{equation} \label{eq:<>}
            <>
        \end{equation}

        ]],
        {i(1, "label"), i(2, "*equation*")}
    ), {
        condition = line_begin
    }),

    s({
        trig = "\\[",
        snippetType = "autosnippet" 
    }, fmta( [[ \[ <> \] ]],
        {i(1, "*equation*")}
    )),

    s({
        trig = "ITEM",
        snippetType = "autosnippet" 
    }, fmta( [[ 
        \begin{itemize}
            \item <>
        \end{itemize}

        ]],
        {i(0, "*content*")}
    ), {
        condition = line_begin
    }),

    s({
        trig = "ENUM",
        snippetType = "autosnippet" 
    }, fmta( [[ 
        \begin{enumerate}
            \item <>
        \end{enumerate}

        ]],
        {i(0, "*content*")}
    ), {
        condition = line_begin
    }),
}
