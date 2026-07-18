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


## Individual Packages

| Package | Description |
|------|-------------|
| `rpgcolor` | Color schemes and themes |
| `rpgfont`  | Font families, colors, and styles |
| `rpglayout`  | Page layout and geometry |
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
 - *infernal*: Mauve panels with blood-red headers and rust accents.
 - *underdark*: Moonstone panels with ink headers and nightshade accents.
 - *druidic*: Olive panels with forest headers and umber accents.
 - *desert*: Vellum panels with umber headers and gold accents.

### `rpgfont`

```latex
\usepackage{rpgfont}
```

Defines a few font families and styles (`RPGFontFamilySerif`, `RPGFontStyleEmphasis`, etc) as well as semantic wrappers for different combinations of color, face, and style used for different RPG typesetting purposes (`RPGFontHeader`, `RPGFontTableBody`, etc). *Does not change or set any existing document fonts to these new values*.

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
```

Sets page geometry, paragraph spacing, list spacing, and optional column mode. `justification` is also accepted as an alias for `alignment`, and `column` as an alias for `columns`. Shortcut options are also available: `ragged`, `raggedright`, `justified`, `onecolumn`, and `twocolumn`.

**RPG Dependencies**
 - `rpgcolor`
 - `rpgfont`


### `rpgsection`

```latex
\usepackage{rpgsection}

\RPGSectionSet{
    chapter = { style = ruled, numbering = Arabic },
    section = { style = ruled },
    subsection = { style = ruled, numbering = arabic },
}
```

```latex
\RPGChapter{Chapter Title}
\RPGSection{Section Title}
\RPGSubsection[plain, numbering=none]{Subsection Title}
```

Provides explicit RPG-styled sectioning commands without redefining standard LaTeX commands such as `\chapter` or `\section`. This keeps package use opt-in: documents can mix ordinary LaTeX sectioning with RPG-styled headings, while future RPG document classes can decide whether to map the standard commands onto these variants.

**RPG Dependencies**
 - `rpgcolor`
 - `rpgfont`

**User API**:
 - `\RPGPart[<options>]{<title>}` creates an RPG-styled part heading.
 - `\RPGChapter[<options>]{<title>}` creates an RPG-styled chapter heading.
 - `\RPGSection[<options>]{<title>}` creates an RPG-styled section heading.
 - `\RPGSubsection[<options>]{<title>}` creates an RPG-styled subsection heading.
 - `\RPGSubsubsection[<options>]{<title>}` creates an RPG-styled subsubsection heading.
 - `\RPGParagraph[<options>]{<title>}` creates an RPG-styled run-in paragraph heading.
 - `\RPGSubparagraph[<options>]{<title>}` creates an RPG-styled run-in subparagraph heading.
 - `\RPGSectionSet{<level>={<options>}, ...}` sets document-wide defaults for one or more heading levels.

**Options**:
 - `style=<plain|ruled>` chooses whether display headings receive a horizontal rule below the title. Bare `plain` and `ruled` are accepted as shortcuts, so `\RPGSection[ruled]{Title}` is equivalent to `\RPGSection[style=ruled]{Title}`.
 - `numbering=<none|arabic|Arabic|roman|Roman|alph|Alph>` controls whether and how the heading counter is stepped and printed. The default is `none`.
 - `font=<commands>` overrides the font commands for a heading.
 - `label=<commands>` overrides the printed label used when numbering is enabled.
 - `before-skip=<length>` or `before=<length>` controls vertical space before a heading.
 - `after-skip=<length>` or `after=<length>` controls vertical space after a heading.
 - `toc=<true|false>` controls whether the heading is added to the table of contents.

**Default Styling**:
 - `\RPGSectionSet` uses nested per-level options: `part`, `chapter`, `section`, `subsection`, `subsubsection`, `paragraph`, and `subparagraph`.
 - Per-heading options override defaults for that heading only.
 - Flat legacy keys such as `section-font` and `chapter-after-skip` are still accepted, but the nested form is preferred.


### `rpgtable`

```latex
\usepackage[
    color=<colorname>
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

Provides a `tabularx` wrapper that alternates row color. Inherits default row color from the theme set by `rpgcolor`; other options can be given document-wide defaults, but each option can (and probably should, in the case of e.g. `title`) be supplied on a per-table basis. When loaded as part of the `rpg` package, no `rpgtable` options are exposed at the package level, meaning only the `rpgcolor` color theme API and per-table options are available.

**RPG Dependencies**
 - `rpgcolor`
 - `rpgfont`

**User API**:
 - `RPGTable` environment with associated options.

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
