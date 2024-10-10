<img src="docs/demos/assets/aagi-logo.svg" align="right" style="margin:10px" />

# AAGI Extension For Quarto

The `AAGIQuarto` Quarto theme extension provides official Analytics for the Australian Grains Industry (AAGI) project theming for Quarto documents.

See the included template and demo file for each format here:

### Report Formats

- **AAGI PDF Short Report:** [AAGI PDF Short Report Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-pdf-short-report+short+report.pdf) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-pdf-report.qmd))
- **AAGI PDF Report:** [AAGI PDF Report Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-pdf-report+report.pdf) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-pdf-report.qmd))
- **AAGI Word Document Report:** [AAGI Word Document Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-docx-report.docx) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-docx-report.qmd))
- **AAGI Word Document Short Report:** [AAGI Word Document Short Demo](demos/template-docx-short-report.docx) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-docx-short-report.qmd))

### Presentation Formats

- **AAGI RevealJS Presentation:** [AAGI RevealJS Slide Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-revealjs.qmd) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-revealjs.qmd))
- **AAGI PowerPoint Presentation:** [AAGI PPT Slide Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-pptx.pptx) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-pptx.qmd))

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

To use the formatted output, save your qmd file into the extension folder that you created using the command above.
Then, in the output format use:

- `aagi-docx+report`, for a full length MS Word report
- `aagi-docx+short+report`, for a short MS Word report
- `aagi-pptx`, for MS PPT output
- `aagi-revealjs`, for a revealjs presentation
- `aagi-pdf+report`, for a full length PDF report
- `aagi-pdf+short+report`, for a short PDF report

## Updating

As we continue to improve this extension through bug fixes or adding new functionality, you can update it easily like so:

```bash
cd your_quarto_project_folder
quarto update AAGI-AUS/AAGIQuarto
```

![](docs/demos/assets/Partners.svg)