# AAGI Extension For Quarto

A [quarto extension](https://quarto.org/docs/extensions/) currently featuring an AAGI theme LaTeX PDF documents and MS Word .docx files as well as a [reveal.js format](https://quarto.org/docs/presentations/revealjs/).

See the included [template.qmd](template.qmd) file for an example of the theme and integration into Quarto or explore the rendered version [here](http://AAGI-AUS.github.io/AAGIQuarto).

## Installing

You can obtain a copy of the extension by using:

```bash
cd your_quarto_project_folder
quarto use template AAGI-AUS/AAGIQuarto
```

This will install the extension and create an example qmd file that
you can use as a starting place for your LaTeX PDF, MS Word .docx or reveal.js presentation slides.

## Using

For documentation on using reveal.js slides in Quarto, please see,
<https://quarto.org/docs/presentations/revealjs/>.

## Updating

As we continue to improve this extension through bug fixes or adding new functionality, you can update it easily like so:.

```bash
cd your_quarto_project_folder
quarto update AAGI-AUS/AAGIQuarto
```