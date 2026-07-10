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
| `rpgtable`  | Tables with headers and alternating colors |
| `rpgskilltree` | Overlaid skill progression graphs |


### `rpgcolor`

```latex
\usepackage[<themename>]{rpgcolor}
```

Provides a large number of custom color names (`RPGColorCharcoal`, `RPGColorCrimson`, etc) as well as semantic wrappers for different styling concepts used by other RPG modules (`RPGColorTitle`, `RPGColorStatBlock`, etc). These can be set to different color values independently or in batches using named themes.

**RPG Dependencies**
 - None

**User API**:
 - `\RPGColorSet` takes a k/v list of semantic wrapper names as keys and xcolor definitions as values and updates the corresponding values.
 - `\RPGColorThemeCreate` takes a string theme name and a k/v list (semantic wrapper names as keys and xcolor values as values) and saves a new color theme with that name and color definitions to the internal theme store. It does not update any actual color values; use `\RPGColorThemeApply` to do this.
 - `\RPGColorThemeApply` takes a string theme name and updates the color definitions with the corresponding saved theme values.

**Semantic Wrapper Values**
| Key | `RPGColorName` |
|---|---|
| base      | `RPGColorBase` |
| comment   | `RPGColorComment` |
| sidebar   | `RPGColorSidebar` |
| tablerow  | `RPGColorTableRow` |
| narration | `RPGColorNarration` |
| title     | `RPGColorTitle` |
| hrule     | `RPGColorHRule` |
| statblock | `RPGColorStatBlock` |
| ribbon    | `RPGColorRibbon` |
| contour   | `RPGColorContour` |
| footer    | `RPGColorFooter` |

**Predefined Colors**
 - Please see `rpgcolor.sty` for a list of all defined colors.

**Predefined Themes**
 - *default*: Bone and parchment with umber titles, forest rules, and rust accents.
 - *PHB2014*: Light green PHB trim with tan backgrounds, red titles, and gold accents.
 - *DMG2014*: Lavender DMG trim with tan backgrounds, red titles, and gold accents.
 - *arcane*: Lavender and wisteria with aubergine titles and amethyst rules.
 - *feywild*: Olive and lavender with forest titles and moss accents.
 - *maritime*: Mist and seafoam with midnight titles and deep teal ribbons.
 - *gothic*: Bone and mushroom with nightshade titles and blood-red ribbons.
 - *infernal*: Mauve and coral with blood-red titles and copper highlights.
 - *underdark*: Moonstone and slate with ink titles and nightshade ribbons.
 - *druidic*: Olive and celadon with forest titles and verdigris rules.
 - *desert*: Vellum and parchment with umber titles and gold ribbons.

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

Modifies a large number of layout and sectioning lengths and behaviors for the document. `justification` is also accepted as an alias for `alignment`, and `column` as an alias for `columns`. Shortcut options are also available: `ragged`, `raggedright`, `justified`, `onecolumn`, and `twocolumn`.

**RPG Dependencies**
 - `rpgcolor`
 - `rpgfont`


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
\RPGSkillTreeStyle{vertex={draw=RPGColorTitle}, edge={draw=RPGColorTitle}}
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
