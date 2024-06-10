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

    ---- Simple expansions
    s({
        trig = "NS",
        wordTrig = false,
        snippetType = "autosnippet"
    }, fmta([[
        namespace <> {
            <>

        } // namespace <>
        ]],
        {i(1, "name"), i(0), rep(1)}
    ), {
        condition = line_begin
    }),


    s({
        trig = "CLASS",
        wordTrig = false,
        snippetType = "autosnippet"
    }, fmta([[
        class <> {
            private:
                <>

            public:

        }; // class <>
        ]],
        {i(1, "name"), i(0), rep(1)}
    ), {
        condition = line_begin
    }),


    s({
        trig = "FUN",
        wordTrig = false,
        snippetType = "autosnippet"
    }, fmta([[
        <> <>(<>) {
            <>

        } // function <>
        ]],
        {i(1, "return_type"), i(2, "function_name"), i(3, "arguments"), i(0, "body"), rep(2)}
    ), {
        condition = line_begin
    }),

    s({
        trig = "GUARDS",
        wordTrig = false,
        snippetType = "autosnippet"
    }, fmta([[
        #ifndef <>_<>_HPP
        #define <>_<>_HPP

        <>


        #endif  // <>_<>_HPP
        ]],
        {i(1, "project"), i(2, "file"), rep(1), rep(2), i(0, "body"), rep(1), rep(2)}
    ), {
        condition = line_begin
    }),
}

