local ls    = require("luasnip")
local s     = ls.snippet
local t     = ls.text_node

local in_mathzone = function()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

return {
    
    s({trig = ";a", snippetType = "autosnippet"}, t("\\alpha "), {condition = in_mathzone}),
    s({trig = ";b", snippetType = "autosnippet"}, t("\\beta "), {condition = in_mathzone}),
    s({trig = ";g", snippetType = "autosnippet"}, t("\\gamma "), {condition = in_mathzone}),
    s({trig = ";p", snippetType = "autosnippet"}, t("\\phi "), {condition = in_mathzone}),
    s({trig = ";r", snippetType = "autosnippet"}, t("\\rho "), {condition = in_mathzone}),
    s({trig = ";th", snippetType = "autosnippet"}, t("\\theta "), {condition = in_mathzone}),
    s({trig = ";ta", snippetType = "autosnippet"}, t("\\tau "), {condition = in_mathzone}),

}
