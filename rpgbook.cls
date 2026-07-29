\RequirePackage{expl3}
\ProvidesExplClass
    {rpgbook}
    {2026-07-29}
    {0.1}
    {Document class for RPG source books.}

\RequirePackage { l3keys2e }

\tl_new:N \l__rpgbook_options_color_tl
\tl_new:N \l__rpgbook_options_font_tl
\tl_new:N \l__rpgbook_options_layout_tl

\keys_define:nn { rpgbook / options }
{
    colortheme .code:n =
        { \tl_put_right:Nn \l__rpgbook_options_color_tl { theme = #1, } },
    colortheme .value_required:n = true,

    alignment .code:n =
        { \tl_put_right:Nn \l__rpgbook_options_layout_tl { alignment = #1, } },
    alignment .value_required:n = true,

    columns .code:n =
        { \tl_put_right:Nn \l__rpgbook_options_layout_tl { columns = #1, } },
    columns .value_required:n = true,

    unknown .code:n =
        { \exp_args:NV \PassOptionsToClass \l_keys_key_tl { book } },
}

\ProcessKeysOptions { rpgbook / options }

\LoadClass { book }

\cs_new_protected:Npn \__rpgbook_options_pass:Nn #1#2
{
    \tl_if_empty:NF #1
    {
        \exp_args:NV \PassOptionsToPackage #1 { #2 }
    }
}

\__rpgbook_options_pass:Nn \l__rpgbook_options_color_tl  { rpgcolor }
\__rpgbook_options_pass:Nn \l__rpgbook_options_font_tl   { rpgfont }
\__rpgbook_options_pass:Nn \l__rpgbook_options_layout_tl { rpglayout }

\RequirePackage { rpgcolor }
\RequirePackage { rpgfont }
\RequirePackage { rpglayout }
\RequirePackage { rpgpage }
\RequirePackage { rpgsection }
\RequirePackage { rpgtable }
\RequirePackage { rpgskilltree }
\RequirePackage { rpgpanel }

\RPGSectionSet
{
    chapter = { style = ruled, contour = true },
    section = { style = banner },
    subsection = { style = ruled, contour = true },
}

\cs_new_protected:Npn \__rpgbook_section_call:Nnnnn #1#2#3#4#5
{
    \IfBooleanTF { #2 }
    {
        \IfValueTF { #5 }
            { #1 [ numbering = none, toc = false ] { #4 } [ #5 ] }
            { #1 [ numbering = none, toc = false ] { #4 } }
    }
    {
        \IfValueTF { #3 }
        {
            \IfValueTF { #5 }
                { #1 [ toc-title = { #3 } ] { #4 } [ #5 ] }
                { #1 [ toc-title = { #3 } ] { #4 } }
        }
        {
            \IfValueTF { #5 }
                { #1 { #4 } [ #5 ] }
                { #1 { #4 } }
        }
    }
}

\RenewDocumentCommand { \part } { s o m o }
{
    \__rpgbook_section_call:Nnnnn \RPGPart { #1 } { #2 } { #3 } { #4 }
}

\RenewDocumentCommand { \chapter } { s o m o }
{
    \__rpgbook_section_call:Nnnnn \RPGChapter { #1 } { #2 } { #3 } { #4 }
}

\RenewDocumentCommand { \section } { s o m o }
{
    \__rpgbook_section_call:Nnnnn \RPGSection { #1 } { #2 } { #3 } { #4 }
}

\RenewDocumentCommand { \subsection } { s o m o }
{
    \__rpgbook_section_call:Nnnnn \RPGSubsection { #1 } { #2 } { #3 } { #4 }
}

\RenewDocumentCommand { \subsubsection } { s o m o }
{
    \__rpgbook_section_call:Nnnnn \RPGSubsubsection { #1 } { #2 } { #3 } { #4 }
}

\RenewDocumentCommand { \paragraph } { s o m o }
{
    \__rpgbook_section_call:Nnnnn \RPGParagraph { #1 } { #2 } { #3 } { #4 }
}

\RenewDocumentCommand { \subparagraph } { s o m o }
{
    \__rpgbook_section_call:Nnnnn \RPGSubparagraph { #1 } { #2 } { #3 } { #4 }
}
