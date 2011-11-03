LaTeX+SVG to PDF makefile
=========================

A Makefile to create pdf files from LaTeX source with embedded SVG images.

Sources include: 

*   [http://www.acoustics.hut.fi/u/mairas/UltimateLatexMakefile](http://www.acoustics.hut.fi/u/mairas/UltimateLatexMakefile)
*   [http://www.takeonthecity.nl/roels-latex-makefile/](http://www.takeonthecity.nl/roels-latex-makefile/)

Requires [Inkscape](http://inkscape.org) for svg to pdf conversion.

How to use
----------
Download the makefile to your LaTeX project directory, or clone the repository:

	git clone git@github.com:DefProc/LaTeX-SVG-to-PDF.git

and add a symlink of the `makefile` in your project directory

then run:

	make
	make all
	make pdf
	make images

to create files

or, to remove files:

	make clean-all
	make clean
	make clean-pdf
	make tidy
	make clean-images
