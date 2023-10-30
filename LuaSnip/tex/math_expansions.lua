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

local in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end


return {

    ---- Simple expansions
    -- s({
    --     trig = "^",
    --     wordTrig = false,
    --     snippetType = "autosnippet"
    -- }, fmta(
    --     "^{<>}",
    --     {i(1, "superscript")}
    -- ), {
    --     condition = in_mathzone
    -- }),

    -- s({
    --     trig = "_",
    --     wordTrig = false,
    --     snippetType = "autosnippet"
    -- }, fmta(
    --     "_{<>}",
    --     {i(1, "subscript")}
    -- ), {
    --     condition = in_mathzone
    -- }),

    ---- Command triggers
    s({
        trig = "ff",
        snippetType = "autosnippet"
    }, fmta(
        "\\frac{<>}{<>} ",
        {i(1, "numerator"), i(2, "denominator")}
    ), {
        condition = in_mathzone
    }),


    s({
        trig = "Sum",
        snippetType = "autosnippet"
    }, fmta(
        "\\sum_{<>}^{<>} ",
        {i(1, "from"), i(2, "to")}
    ), {
        condition = in_mathzone
    }),



    ---- Matrix/Vector expansions
    s({
        trig = "MAT",
        snippetType = "autosnippet"
    }, fmta(
        "\\begin{bmatrix} \n\t<> \n\\end{bmatrix} ",
        {i(1, "*matrix*")}
    ), {
        condition = in_mathzone
    }),

    s({
        trig = "VEC",
        snippetType = "autosnippet"
    }, fmta(
        "\\begin{pmatrix} \n\t<> \n\\end{pmatrix} ",
        {i(1, "*vector*")}
    ), {
        condition = in_mathzone
    }),


    ---- Variable indexing
    s({
        trig = "ii ",
        wordTrig = false,
        snippetType = "autosnippet"
    }, {
        t("_{i} ")
    }, {
        condition = in_mathzone
    }),

    s({
        trig = "jj ",
        wordTrig = false,
        snippetType = "autosnippet"
    }, {
        t("_{j} ")
    }, {
        condition = in_mathzone
    }),

    s({
        trig = "kk ",
        wordTrig = false,
        snippetType = "autosnippet"
    }, {
        t("_{k} ")
    }, {
        condition = in_mathzone
    }),
}

