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

local not_in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 0
end

return {

    s({
        trig = "IT",
        snippetType = "autosnippet"
    }, fmta([[
        \textit{<>}<>
        ]], {
        i(1, "italic text"),
        i(0)
    })),

    s({
        trig = "BF",
        snippetType = "autosnippet"
    }, fmta([[
        \textbf{<>}<>
        ]], {
        i(1, "bold text"),
        i(0)
    })),

    s({
        trig = "TT",
        snippetType = "autosnippet"
    }, fmta([[
        \texttt{<>}<>
        ]], {
        i(1, "text"),
        i(0)
    })),

    -- s({
    --     trig = "_",
    --     wordTrig = false,
    --     snippetType = "autosnippet"
    -- }, fmta([[
    --     \_
    --     ]], {}),
    -- {
    --     condition = not_in_mathzone
    -- }),


    s({
        trig = "\ref",
        snippetType = "autosnippet"
    }, fmta([[
        \ref{<>}<>
        ]], {
        i(1, "label"),
        i(0)
    })),


    s({
        trig = "wrt",
        snippetType = "autosnippet"
    }, {
        t("w.r.t.")
    }),

    s({
        trig = "ie ",
        snippetType = "autosnippet"
    }, {
        t("i.e. ")
    }),
}
