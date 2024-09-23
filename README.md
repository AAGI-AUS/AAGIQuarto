# AAGI Extension For Quarto

A [quarto extension](https://quarto.org/docs/extensions/) currently featuring an AAGI theme LaTeX PDF documents and MS Word .docx files as well as a [reveal.js format](https://quarto.org/docs/presentations/revealjs/).

See the included template and demo file for each format here:
- **RevealJS:** [RevealJS Slide Demo](aagi-aus.github.io/AAGIQuarto/demos/template-revealjs.html) ([Source](docs/demos/template-revealjs.qmd))
- **PDF:** [PDF Report Demo](aagi-aus.github.io/AAGIQuarto/demos/template-pdf-report.pdf) ([Source](docs/demos/template-pdf-report.qmd))
- **Short PDF:** [Short PDF Report Demo](aagi-aus.github.io/AAGIQuarto/demos/template-short-report.pdf) ([Source](docs/demos/template-short-report.qmd))
- **MS Word .docx:** [MS Word Report Demo](aagi-aus.github.io/AAGIQuarto/demos/template-docx-report.docx) ([Source](docs/demos/tempate-docx-report.qmd))

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

To use the formatted output, save your qmd file into the extension folder that you created using the command above. Then, in the output format use:
- **aggi-docx+report** for word output
- **aagi-revealjs** for revealjs presentation
- **aagi-pdf+report** for the full length pdf report
- **aagi-pdf+short+report** for the short length pdf report

## Updating

As we continue to improve this extension through bug fixes or adding new functionality, you can update it easily like so:.

```bash
cd your_quarto_project_folder
quarto update AAGI-AUS/AAGIQuarto
```
