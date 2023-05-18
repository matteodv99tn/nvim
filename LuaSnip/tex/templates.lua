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
        trig = "snippet::quickbook",
    }, fmta([[ 
        \documentclass[11pt, a4paper, twoside, openright]{book}
        \usepackage[utf8]{inputenc}
        \usepackage[T1]{fontenc}
        \usepackage[width=14.0cm, height=22.0cm]{geometry}
        \usepackage{biblatex}
        \usepackage{mathdefs}
        \usepackage{graphicx}
        \usepackage{hyperref}
        \usepackage[margin=1cm]{caption}
        \usepackage{subcaption}
        %
        % Rember to copy the file mathdefs.tex in the same folder of this file!
        %

        % Bibliography
        % \addbibresource{filename.bib}


        \title{<>}
        \author{Matteo Dalle Vedove}
        \date{\today}


        \begin{document}

            \maketitle
            \tableofcontents 
            \clearpage

            %% --- Documents starts here
            % \input{yourfile}

            <>


        \end{document}
        ]], 
        {i(1, "Title"), i(0, "Document body")}
    ), {
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
