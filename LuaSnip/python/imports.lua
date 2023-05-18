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
        trig = "NP",
        snippetType = "autosnippet"
    }, {
        t("import numpy as np"),
    }, {
        condition = line_begin 
    }),

    s({
        trig = "PD",
        snippetType = "autosnippet"
    }, {
        t("import pandas as pd"),
    }, {
        condition = line_begin 
    }),

    s({
        trig = "PLT",
        snippetType = "autosnippet"
    }, {
        t("import matplotlib.pyplot as plt"),
    }, {
        condition = line_begin 
    }),
}
