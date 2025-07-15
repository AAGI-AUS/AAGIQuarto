<img src="docs/demos/assets/aagi-logo.svg" align="right" style="margin:10px" />

# AAGI Extension For Quarto

The `AAGIQuarto` Quarto extension provides official Analytics for the Australian Grains Industry (AAGI) project theming for Quarto documents.
If you prefer to use R Markdown, please see the excellent [{AAGIThemes}](https://github.com/AAGI-AUS/AAGITemplates) package, which AAGIQuarto has feature parity with and shares the same underlying AAGI templates for the individual AAGI documents so that the outputs should be similar if not identical between these two tools.
AAGIQuarto was developed to provide next-generation literate programming tools for AAGI's reporting and presentation needs that support R, Python and Julia languages.

## Template Formats

See the included template and demo file for each format here:

### Report Formats

- **AAGI PDF Short Report:** [AAGI PDF Short Report Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-pdf-short-report+short+report.pdf) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-pdf-report.qmd))
- **AAGI PDF Report:** [AAGI PDF Report Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-pdf-report+report.pdf) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-pdf-report.qmd))
- **AAGI Word Document Report:** [AAGI Word Document Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-docx-report.docx) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-docx-report.qmd))
- **AAGI Word Document Short Report:** [AAGI Word Document Short Demo](demos/template-docx-short-report.docx) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-docx-short-report.qmd))

### Presentation Formats

- **AAGI revealjs Presentation:** [AAGI revealjs Slide Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-revealjs.html#/title-slide) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-revealjs.qmd)) (this is an AAGIQuarto exclusive)
- **AAGI PowerPoint Presentation:** [AAGI PPT Slide Demo](https://aagi-aus.github.io/AAGIQuarto/demos/template-pptx.pptx) ([Source](https://github.com/AAGI-AUS/AAGIQuarto/blob/main/docs/demos/template-pptx.qmd))

## Installing

### Getting Quarto

If you do not have Quarto installed on your device (and are not already using RStudio, which includes it by default), you will need to do that first.
[Go here](https://quarto.org/docs/get-started/) for instructions on how to install Quarto.

### Getting the Template

Use your terminal or command prompt to run the install commands.
Alternatively, if you use RStudio or VS Code(ium)/Positron you can use the terminal emulator, but not the R/Python/Julia REPL (read-eval-print-loop console), in those integrated development environments (IDE) to run the commands.
Or, if you prefer and you are using Windows, you may need to install the Windows Subsystem for Linux (WSL) to use the `bash` command.
For more information, see [Microsoft's documentation](https://docs.microsoft.com/en-us/windows/wsl/install).

You can obtain a copy of the extension by using the following commands in your Bash terminal (CLI):

```bash
cd your_quarto_project_folder
quarto use template AAGI-AUS/AAGIQuarto
```

This will install the extension and create an example qmd file that you can use as a starting place for your LaTeX PDF, MS Word .docx or reveal.js presentation slides.

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

### Template

If you use the `Bash` command above to install the extension and create a sub directory following the command prompt, there
will be a .qmd file created using the name that you input for the sub directory.

By default, these templates use [{AAGIThemes}](https://aagi-aus.github.io/AAGIThemes/) and [{AAGIPalettes}](https://aagi-aus.github.io/AAGIPalettes/) for R graphical and tabular outputs.

## Updating

As we continue to improve this extension through bug fixes or adding new functionality, you can update it easily like so:

```bash
cd your_quarto_project_folder
quarto update AAGI-AUS/AAGIQuarto
```

## Logo Rights

The logo of this project and the AAGI strategic partners do not come under MIT License.
The Analytics for the Australian Grains Industry (AAGI) project retains full rights to the AAGI logo and the Grains Research and Development Corporation (GRDC) and strategic partners, Curtin University, the University of Queensland and Adelaide University, retain full rights to their own logos, respectively.

![](docs/demos/assets/Partners.svg)
