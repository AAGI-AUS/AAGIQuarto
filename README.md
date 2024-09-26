
<img src="docs/demos/assets/aagi-logo.svg" align="right" style="margin:10px;" />

# AAGI Extension For Quarto

A [quarto extension](https://quarto.org/docs/extensions/) currently featuring an AAGI theme LaTeX PDF documents and MS Word .docx files as well as a [reveal.js format](https://quarto.org/docs/presentations/revealjs/).

See the included template and demo file for each format here:
- **RevealJS:** [AAGI RevealJS Slide Demo](demos/template-revealjs.qmd) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-revealjs.qmd))
- **AAGI PDF Short Report:** [AAGI PDF Short Report Demo](demos/template-pdf-short-report+short+report.pdf) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-pdf-report.qmd))
- **AAGI PDF Report:** [AAGI PDF Report Demo](demos/template-pdf-report+report.pdf) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-pdf-report.qmd))
- **AAGI Word Document Report:** [AAGI Word Document Demo](demos/template-docx-report.docx) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-docx-report.qmd))

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
- **aggi-docx+report** for MS Word output
- **aagi-revealjs** for a revealjs presentation
- **aagi-pdf+report** for a full length PDF report
- **aagi-pdf+short+report** for a short PDF report

## Updating

As we continue to improve this extension through bug fixes or adding new functionality, you can update it easily like so:.

```bash
cd your_quarto_project_folder
quarto update AAGI-AUS/AAGIQuarto
```

![](docs/demos/assets/Partners.svg)