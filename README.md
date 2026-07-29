# rpgtex

A collection of modular LaTeX packages for RPG typesetting.

Inspired by [DND-5e-LaTeX-Template](https://github.com/rpgtex/DND-5e-LaTeX-Template)

## Usage

### `usepackage`

Modules can either be loaded as a bundle using the overarching `rpg` package, or individually with independent options.

```latex
\usepackage[
    colortheme=<themename>,
    alignment=<ragged|raggedright|justified>,
    columns=<one|two>
]{rpg}
```

The bundle accepts explicit key/value options only. Shortcut options such as `twocolumn` are available on individual modules where documented, but not on `rpg`.

`rpg` and all of its submodules define custom RPG variants of many standard LaTeX commands --- for example `\RPGChapter` for `\chapter` --- with identical basic usage, but extended package-specific options. When used as standalone packages, these usually do not interfere with the basic commands and they can be used independently in the same document.

### `documentclass`

Use `rpgbook` when the whole document should use RPG defaults and ordinary
sectioning commands should render as RPG-styled headings.

```latex
\documentclass[
    11pt,
    colortheme=<themename>,
    alignment=<ragged|raggedright|justified>,
    columns=<one|two>
]{rpgbook}
```

Unlike `\usepackage{rpg}`, the class loads `book` itself and forwards ordinary
class options such as `10pt`, `11pt`, `12pt`, `oneside`, `twoside`, `openany`,
and `openright` to `book`. It also maps standard sectioning commands such as
`\chapter`, `\section`, and `\paragraph` to the corresponding RPG commands.

```latex
\chapter[Short TOC Title]{Chapter Title}[Optional chapter subtitle]
\section{Section Title}
\section*{Unnumbered Section}
```

Use the explicit `\RPGChapter`, `\RPGSection`, etc. commands when you need
per-heading RPG options such as `style`, `numbering`, `contour`, or `toc`.

Use `rpgarticle` for RPG article-length documents. It is the article-class
counterpart of `rpgbook`: it loads `article`, forwards class options such as
`10pt`, `11pt`, `12pt`, `oneside`, and `twoside` to the underlying class, and
maps `\section`, `\subsection`, and `\paragraph` to RPG-styled headings.

```latex
\documentclass[
    11pt,
    colortheme=arcane,
    alignment=raggedright,
    columns=two
]{rpgarticle}
```

Because `article` has no `\chapter`, `rpgarticle` does not map it. Sectioning
levels that exist in the class (`\section` through `\subparagraph`) are
mapped to their `\RPG...` counterparts.


## Individual Packages

| Package | Description |
|------|-------------|
| `rpgcolor` | Color schemes and themes |
| `rpgfont`  | Font families, colors, and styles |
| `rpglayout`  | Page layout and geometry |
| `rpgpage`  | Page-level styling and background drawing |
| `rpgsection` | Explicit RPG-styled sectioning commands |
| `rpgtable`  | Tables with headers and alternating colors |
| `rpgskilltree` | Overlaid skill progression graphs |


### `rpgcolor`

```latex
\usepackage[<themename>]{rpgcolor}
```

Provides a large number of custom color names (`RPGColorCharcoal`, `RPGColorCrimson`, etc) as well as semantic wrappers for styling concepts used by other RPG modules (`RPGColorHeader`, `RPGColorPanelBackground`, etc). These can be set to different color values independently or in batches using named themes.

**RPG Dependencies**
 - None

**User API**:
 - `\RPGColorSet` takes a k/v list of semantic wrapper names as keys and xcolor definitions as values and updates the corresponding values.
 - `\RPGColorThemeCreate` takes a string theme name and a k/v list (semantic wrapper names as keys and xcolor values as values) and saves a new color theme with that name and color definitions to the internal theme store. It does not update any actual color values; use `\RPGColorThemeApply` to do this.
 - `\RPGColorThemeApply` takes a string theme name and updates the color definitions with the corresponding saved theme values.

**Semantic Wrapper Values**
| Key | `RPGColorName` |
|---|---|
| background | `RPGColorBackground` |
| accent | `RPGColorAccent` |
| body | `RPGColorBody` |
| muted | `RPGColorMuted` |
| header | `RPGColorHeader` |
| footer | `RPGColorFooter` |
| panel-background | `RPGColorPanelBackground` |
| panel-accent | `RPGColorPanelAccent` |
| table-row | `RPGColorTableRow` |
| contour | `RPGColorContour` |

**Predefined Colors**
 - Please see `rpgcolor.sty` for a list of all defined colors.

**Predefined Themes**
 - *default*: Bone panels with umber headers, forest footers, and rust accents.
 - *PHB2014*: Light green panels with red headers, bronze footers, and gold accents.
 - *DMG2014*: Lavender panels with red headers, bronze footers, and gold accents.
 - *arcane*: Wisteria panels with aubergine headers and brass accents.
 - *feywild*: Olive panels with forest headers and brass accents.
 - *maritime*: Mist panels with midnight headers and deep teal accents.
 - *gothic*: Bone panels with nightshade headers and blood-red accents.
 - *OSR*: Hand-inked greyscale on parchment with restrained red accents.
 - *infernal*: Mauve panels with blood-red headers and rust accents.
 - *underdark*: Moonstone panels with ink headers and nightshade accents.
 - *druidic*: Olive panels with forest headers and umber accents.
 - *desert*: Vellum panels with umber headers and gold accents.

### `rpgfont`

```latex
\usepackage{rpgfont}
```

Defines a few font families and styles (`RPGFontFamilySerif`, `RPGFontStyleEmphasis`, etc) as well as semantic wrappers for different combinations of color, face, and style used for different RPG typesetting purposes (`RPGFontHeader`, `RPGFontSubheading`, `RPGFontTableBody`, etc). *Does not change or set any existing document fonts to these new values*.

**RPG Dependencies**
 - `rpgcolor`

**User API**:
 - `\RPGFontSet` accepts a set of key/value pairs for altering any of the predefined font values.

**Predefined Values**
 - Please see `rpgfont.sty` for a list of all defined font families, styles, and typefaces.

### `rpglayout`

```latex
\usepackage[
    alignment=<ragged|raggedright|justified>,
    columns=<one|two>
]{rpglayout}

\RPGLayoutSet{
    section = { before = <length>, after = <length> },
    subsection = { before-skip = <length>, after-skip = <length> },
}
```

Sets page geometry, paragraph spacing, list spacing, default heading spacing, and optional column mode. `justification` is also accepted as an alias for `alignment`, and `column` as an alias for `columns`. Shortcut options are also available: `ragged`, `raggedright`, `justified`, `onecolumn`, and `twocolumn`.

**RPG Dependencies**
 - `rpgcolor`
 - `rpgfont`

**User API**:
 - `\RPGLayoutSet{<level>={<options>}, ...}` sets layout-owned defaults for heading spacing consumed by `rpgsection`.
 - Supported levels are `part`, `chapter`, `section`, `subsection`, `subsubsection`, `paragraph`, and `subparagraph`.
 - `before-skip=<length>` or `before=<length>` controls default vertical space before headings at that level.
 - `after-skip=<length>` or `after=<length>` controls default vertical space after headings at that level.


### `rpgpage`

```latex
\usepackage{rpgpage}
```

Applies page-level document styling. Currently this draws `RPGColorBackground` across every page by default, so the active `rpgcolor` theme controls the page background when `rpgpage` is loaded directly or through the `rpg` bundle.

**RPG Dependencies**
 - `rpgcolor`


### `rpgsection`

```latex
\usepackage{rpgsection}

\RPGSectionSet{
    chapter = { style = ruled, numbering = Arabic, contour = true },
    section = { style = banner },
    subsection = { style = ruled, numbering = arabic },
}
```

```latex
\RPGChapter{Chapter Title}[Optional chapter subtitle]
\RPGSection{Section Title}[Optional section subtitle]
\RPGSubsection[plain, numbering=none]{Subsection Title}
```

Provides explicit RPG-styled sectioning commands without redefining standard LaTeX commands such as `\chapter` or `\section`. This keeps package use opt-in: documents can mix ordinary LaTeX sectioning with RPG-styled headings, while future RPG document classes can decide whether to map the standard commands onto these variants.

RPG sectioning commands are defined only when the current document class provides the corresponding sectioning counter. For example, `\RPGChapter` is available in `book` and `report`, but not in `article`.

**RPG Dependencies**
 - `rpgcolor`
 - `rpgfont`
 - `rpglayout`

**User API**:
 - `\RPGPart[<options>]{<title>}[<subheading>]` creates an RPG-styled part heading.
 - `\RPGChapter[<options>]{<title>}[<subheading>]` creates an RPG-styled chapter heading.
 - `\RPGSection[<options>]{<title>}[<subheading>]` creates an RPG-styled section heading.
 - `\RPGSubsection[<options>]{<title>}[<subheading>]` creates an RPG-styled subsection heading.
 - `\RPGSubsubsection[<options>]{<title>}[<subheading>]` creates an RPG-styled subsubsection heading.
 - `\RPGParagraph[<options>]{<title>}[<subheading>]` creates an RPG-styled run-in paragraph heading.
 - `\RPGSubparagraph[<options>]{<title>}[<subheading>]` creates an RPG-styled run-in subparagraph heading.
 - `\RPGSectionSet{<level>={<options>}, ...}` sets document-wide defaults for one or more heading levels.

**Options**:
 - `style=<plain|ruled|banner>` chooses the heading treatment. `plain` prints the heading text only, `ruled` adds a horizontal rule below display headings, and `banner` centers the heading text in a full-width `RPGColorHeader` colorbox with `RPGColorBackground` text. Bare `plain`, `ruled`, and `banner` are accepted as shortcuts, so `\RPGSection[banner]{Title}` is equivalent to `\RPGSection[style=banner]{Title}`.
 - `numbering=<none|arabic|Arabic|roman|Roman|alph|Alph>` controls whether and how the heading counter is stepped and printed. The default is `none`.
 - `font=<commands>` overrides the font commands for a heading.
 - `label=<commands>` overrides the printed label used when numbering is enabled.
 - `contour=<true|false>` controls whether plain and ruled display headings are drawn with `\RPGFontContour`. The default is `false`.
 - `before-skip=<length>` or `before=<length>` overrides layout-owned vertical space before this heading or heading level.
 - `after-skip=<length>` or `after=<length>` overrides layout-owned vertical space after this heading or heading level.
 - `toc=<true|false>` controls whether the heading is added to the table of contents.

**Subheadings**:
 - The optional post-title subheading uses `\RPGFontSubheading`.
 - Configure it with `\RPGFontSet{subheading-family=<commands>, subheading-color=<commands>, subheading-style=<commands>}`.

**Default Styling**:
 - `\RPGSectionSet` uses nested per-level options: `part`, `chapter`, `section`, `subsection`, `subsubsection`, `paragraph`, and `subparagraph`.
 - Per-heading options override defaults for that heading only.
 - Flat per-level keys such as `section-font` and `chapter-after-skip` are not supported; use nested keys instead.


### `rpgtable`

```latex
\usepackage[
    header-row=<true|false>
    striped=<odd|even|none>
    title=<title>
    width=<width>
]{rpgtable}
```

```latex
\begin{RPGTable}
[%
    color=<colorname>
    header-row=<true|false>
    striped=<odd|even|none>
    title=<title>
    width=<width>
]{<columns...>}
    % ...
\end{RPGTable}
```

Provides a `tabularx` wrapper that alternates row color. The default row color always comes from the active `rpgcolor` semantic color `RPGColorTableRow`; use `\RPGColorSet{table-row=<color>}` or a named theme to change the default. Per-table `color=<colorname>` remains available for one-off overrides. Non-color options can be given document-wide defaults, but each option can also be supplied on a per-table basis.

**RPG Dependencies**
 - `rpgcolor`
 - `rpgfont`

**User API**:
 - `RPGTable` environment with associated options.

### `rpgpanel`

```latex
\usepackage[
    floating=<true|false>,
    style=<none|ribbon|bars>
]{rpgpanel}
```

```latex
\begin{RPGPanel}[
    title=<title>,
    background=<colorname>,
    accent=<colorname>,
    style=<none|ribbon|bars>
]
    % ...
\end{RPGPanel}
```

Provides styled `tcolorbox` panels. Default panel colors always come from the active `rpgcolor` semantic colors: `RPGColorPanelBackground` and `RPGColorPanelAccent`. Use `\RPGColorSet{panel-background=<color>, panel-accent=<color>}` or a named theme to change panel defaults. Per-panel `background`, `color`, and `accent` options remain available for one-off overrides only. Panel font settings in `rpgfont` control family and style, not panel colors.

**RPG Dependencies**
 - `rpgcolor`
 - `rpgfont`

**User API**:
 - `\RPGPanelSet{floating=<true|false>, style=<none|ribbon|bars>}` sets document-wide panel behavior defaults, not color defaults.
 - `RPGPanel` environment accepts panel options plus raw `tcolorbox` keys.

### `rpgskilltree`

```latex
\usepackage{rpgskilltree}
\RPGSkillTreeStyle{vertex={draw=RPGColorHeader}, edge={draw=RPGColorHeader}}
```

```latex
\begin{RPGSkillTree}
    \RPGSkillTreeStyle{edge={thick}}

    % Place vertices in ordinary content, including any other environment.
    \RPGSTVertex{start}
    \RPGSTVertex[$\star$]{mastery}

    % Draw links after the content has been typeset.
    \RPGSkillTreeEdges
    {%
        \RPGSTEdge{start}{mastery}
        \RPGSTEdge[bend left=15]{start}{mastery}
    }
\end{RPGSkillTree}
```

Provides a lightweight TikZ overlay for drawing directed graphs inside other content, such as `RPGTable` rows. Each `RPGSkillTree` environment automatically prefixes its node names, so multiple skill trees can appear in the same document without name collisions. `\RPGSkillTreeStyle` acts as `\tikzset` would to customise styles, but alters global values `rpgst/default vertex` and `rpgst/default edge` when called outside a tree environment, and local values `rpgst/vertex` and `rpgst/edge` when called within one (which are then reset to the global values upon leaving the current skill tree).

**RPG Dependencies**
 - None

**User API**:
 - `RPGSkillTree` environment scopes vertex names and draws stored edges at the end of the environment.
 - `\RPGSkillTreeStyle{vertex={<tikz options>}, edge={<tikz options>}}` appends TikZ options for vertices and edges. Outside `RPGSkillTree`, options are appended to the global defaults; inside `RPGSkillTree`, options are appended to the current local styles only.
 - `\RPGSTVertex[<content>]{<name>}` places a named vertex. The default content is `$\bullet$`.
 - `\RPGSkillTreeEdges{<edges>}` stores the edge drawing commands for the current tree.
 - `\RPGSTEdge[<tikz to options>]{<from>}{<to>}` draws a directed edge between two vertices. TikZ anchor suffixes such as `.east` are supported.
 - `\RPGSTRef{<name>}` expands to the current tree's prefixed TikZ node name for custom paths.
 - `\RPGSTDraw{<tikz code>}` runs custom TikZ drawing code inside the overlay picture.
