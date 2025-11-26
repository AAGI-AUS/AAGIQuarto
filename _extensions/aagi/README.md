# AAGILaTeXTemplates

<!-- Badges -->
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
![Template: LaTeX/Beamer](https://img.shields.io/badge/Template%3A%20LaTeX/Beamer-30685f)

This repository contains LaTeX (and Beamer) templates that AAGI staff can use to
create AAGI-themed documents and presentations.

|<img src="assets/README_graphics/preview_aagireport.jpg" alt="AAGI report jpg" width="200px"/><br>[AAGI Report](/AAGI%20Report)|<img src="assets/README_graphics/preview_aagiinterimreport.jpg" alt="AAGI interim report jpg" width="200px"/><br>[AAGI Interim Report](/AAGI%20Interim%20Report/)|<img src="assets/README_graphics/preview_aagidocument.jpg" alt="AAGI document jpg" width="200px"/><br>[AAGI Document](/AAGI%20Document/)|<img src="assets/README_graphics/preview_aagipresentation.png" alt="AAGI presentation png" width="248px"/><br>[AAGI Presentation](/AAGI%20Presentation)|
|:-:|:-:|:-:|:-:|

Use these templates, together with a suitable TeX environment and compiler, to 
prepare your AAGI reports, presentations, and other documents.

- **[AAGI Report](/AAGI%20Report)**: An AAGI-themed template for project 
  reports. Use this template for the 'large' (i.e., project conclusion) reports, such 
  as major milestone reports for Research & Development investments, or analytics
  reports to clients for Service & Support investments.
- **[AAGI Interim Report](/AAGI%20Interim%20Report)**: An AAGI-themed 'small'
  report template, designed for shorter (i.e., 3-4 page) reports. Use this template
  for summary or interim reporting to clients or for investment milestones.
- **[AAGI Document](/AAGI%20Document)**: A general AAGI-themed document template.
  Use this template for miscellaneous documents such as guides, overviews, 
  checklists, media releases, memos, and others.
- **[AAGI Presentation](/AAGI%20Presentation)**: AAGI-theming for
  presentation slides (made using Beamer). Use this template for 
  presentations showcasing your AAGI project work, or when representing the AAGI 
  brand at events.

## Installation & Usage Instructions

### Install a TeX distribution (TeXLive recommended)

The AAGI report and presentation templates can be used with any TeX distribution and
editor environment. For best results, it is recommended that you install a 
complete TeXLive distribution which will include all of the packages that you may
ever need when compiling (La)TeX documents. The full TeXLive suite comes out to
about 7GB or so.

- **Windows 11 or newer**: You can install a full TeXLive installation on Windows 11 
  (or Windows 10, or newer) by following the _Easy Install_ directions
  listed on the TeX Users Group website, https://www.tug.org/texlive/windows.html.
- **Mac OSX**: On Mac OSX (v10.14 or higher), the recommended way to get a full
  TeXLive distribution is to install the MacTeX package, which can be 
  installed by following the instructions on the TeX Users Group
  website at https://www.tug.org/mactex/.
- **Ubuntu**: Ubuntu 24.04 LTS (or essentially any version of Ubuntu, past and
  future) lets you easily install the full TeXLive distribution with 
  the `texlive-full` package:
  ```{bash}
  sudo apt install texlive-full
  ```
- **Fedora Linux**: In Fedora Linux 43 (as well as many other past/future versions),
  the easy way to install a full TeXLive distribution is by installing the
  `texlive-scheme-full` scheme:
  ```{bash}
  sudo dnf install texlive-scheme-full
  ```
- **Linux**: On other flavours of Linux, you may be able to find a similar
  'full TeXLive' package in your package manager. However if not, the _Quick Install_
  instructions provided by the TeX Users Group will work on any Linux 
  (or UNIX) flavour, and can be found at https://www.tug.org/texlive/quickinstall.html.

### Download the template directories

Download this template repository to your local computer. You can do this by 
downloading and unzipping the repository using the _Code_ button in the top right 
as shown:<br><img src="assets/README_graphics/install_download.png" alt="Download the zipped repository file by clicking the Code button png" width="426px"/>

Alternatively, you can `git clone` this repository:
```{bash}
git clone https://github.com/AAGI-AUS/AAGILaTeXTemplates.git
```

In either case, this will download all of the template directories, which you can
start using straight away with your preferred TeX editor.

## Acknowledgements & Notices

These LaTeX/Beamer templates for AAGI documents and presentations were developed
under the AAGI Research & Development investment **AAGI-AU-RD-WOP**, with guidance
provided by the AAGI Strategic Partner leads and feedback from the wider
community of AAGI researchers and professionals.

### MIT Licence (for .tex code only), Logo Rights

These document templates have been made public for the strict purposes of transparency
and ease of access for AAGI staff. 

Please note that the code in the .tex files is released under the open source **[MIT Licence](/LICENSE)**, but this licence _does not_ grant unauthorised use of the 
AAGI logo or the Strategic Partner logos. The use of the logo graphics together with
these templates is restricted to official AAGI work conducted by AAGI personnel.

The AAGI project and the AAGI Strategic Partners retain full ownership and rights to
the AAGI logo. GRDC, Curtin University, the University of Queensland, and Adelaide
University retain full rights to their respective institutional logos.

The use of the AAGI logo together with the Strategic Partner logo block abides by the
standards set for AAGI project documents and outputs. The size and positioning for
the logos must not be modified without authorisation.

### Feedback & Contributing

Feedback on the use of the AAGI document and presentation templates is always
welcome. If you wish to provide feedback on the templates or any related 
materials, please use the [GitHub Issue Tracker](https://github.com/AAGI-AUS/AAGILaTeXTemplates/issues) for this repository. 
Alternatively, get in touch with one of the AAGI-AU-RD-WOP project leads:

- Curtin University: Prof. Adam Sparks ([@adamhsparks](https://github.com/adamhsparks))
- University of Queensland: Dr Robert Armstrong ([@rnarmstrong71](https://github.com/rnarmstrong71))
- Adelaide University: Mr Sam Rogers ([@rogerssam](https://github.com/rogerssam))

