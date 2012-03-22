LaTeX+SVG to PDF makefile
=========================

A Makefile to create pdf files from LaTeX source with embedded SVG images.

Sources include: 

*   [http://www.acoustics.hut.fi/u/mairas/UltimateLatexMakefile](http://www.acoustics.hut.fi/u/mairas/UltimateLatexMakefile)
*   [http://www.takeonthecity.nl/roels-latex-makefile/](http://www.takeonthecity.nl/roels-latex-makefile/)

Requires [Inkscape](http://inkscape.org) for svg to pdf conversion.

How to use
----------
To use this file singly, download the makefile to your LaTeX project directory.

If you'd like to keep your makefile synchronised with any updates to this repo,
clone the repository:

	git clone git://github.com/DefProc/LaTeX-SVG-to-PDF.git

and add a symlink of the `makefile` in your project directory

Or, if you're using git as the version tracking for your LaTeX project,
add this repository as a submodule and symlink the makefile:

	git submodule add git://github.com/DefProc/LaTeX-SVG-to-PDF.git
	ln -s LaTeX-SVG-to-PDF/makefile makefile
	git add LaTeX-SVG-to-PDF/
	git commit -m "added LaTeX-SVG-to-PDF as submodule and linked to makefile"	


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
