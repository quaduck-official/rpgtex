# rpgtex

A collection of modular LaTeX packages for RPG typesetting.

Inspired by [DND-5e-LaTeX-Template](https://github.com/rpgtex/DND-5e-LaTeX-Template)

## Usage

### `documentclass`

### `usepackage`

Modules can either be loaded as a bundle using the overarching `rpg` package, or individually with independent options.

```latex
\usepackage{rpg}
```

## Individual Packages

| Package | Description |
|------|-------------|
| `rpgcolor` | Color schemes and themes |


### `rpgcolor`

```latex
\usepackage[<theme>]{rpgcolor}
```

Provides a large number of custom color names (`RPGColorCharcoal`, `RPGColorCrimson`, etc) as well as semantic wrappers for different styling concepts used by other RPG modules (`RPGColorTitle`, `RPGColorStatBlock`, etc). These can be set to different color values independently or in batches using named themes.

**Predefined Colors**
 - Please see `rpgcolor.sty` for a list of all defined colors.

**User API**:
 - `\RPGColorSet` takes a k/v list of semantic wrapper names as keys and xcolor definitions as values and updates the corresponding values.
 - `\RPGColorThemeCreate` takes a string theme name and a k/v list (semantic wrapper names as keys and xcolor values as values) and saves a new color theme with that name and color definitions to the internal theme database. It does not update any actual color values; use `\RPGColorThemeApply` to do this.
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
