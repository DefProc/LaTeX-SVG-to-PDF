# LaTeX+SVG to PDF 
# ================
# A Makefile to create pdf files from LaTeX source with embedded SVG images.

# Patrick Fenner, <contact@def-proc.co.uk>,
# Def-Proc Engineering. http://def-proc.co.uk

# Sources include: 
# 	http://www.acoustics.hut.fi/u/mairas/UltimateLatexMakefile
# 	http://www.takeonthecity.nl/roels-latex-makefile/

# Requires:
# 	Inkscape http://inkscape.org for svg to pdf conversion

# run:
# 	make
# 	make all
# 	make pdf
# 	make images
# or:
# 	make clean-all
# 	make clean
# 	make clean-pdf
# 	make tidy
# 	make clean-images

# Choose your compiler:
LATEX	= xelatex -interaction=batchmode
BIBTEX	= bibtex

# Set sub-folder location of svg image sources
GRAPHIC_DIR = images

# TeX input and pdf output files
SRC	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
PDF	= $(SRC:%.tex=%.pdf)
# Finding the required images
FIGSRC	:= $(wildcard $(GRAPHIC_DIR)/*.svg)
FIG	:= $(FIGSRC:%.svg=%.pdf)
FIGTEX	:= $(FIGSRC:%.svg=%.pdf_tex)

RERUN = "There were undefined references."
RERUNBIB = "No file.*\.bib|Citation.*undefined"

COPY = if test -r $(<:%.tex=%.toc); then cp $(<:%.tex=%.toc) $(<:%.tex=%.toc.bak); fi 
RM = rm -f

.PHONY : all pdf images clean clean-all clean-images

all : images pdf 


# Generate pdf output file
pdf: $(PDF)

$(PDF) : $(SRC) $(wildcard *.tex) $(wildcard *.bib) $(FIG) $(FIGTEX)
	# Run LaTeX
	$(COPY); $(LATEX) $< && true
	# Run BibTeX if needed
	egrep -c $(RERUNBIB) $(<:%.tex=%.log) && $(BIBTEX) $(<:%.tex=%) && $(COPY) && $(LATEX) $<; true
	# Rerun LaTeX if necessary
	egrep -c $(RERUN) $(<:%.tex=%.log) && $(COPY) && $(LATEX) $<; true
	# Rerun LaTeX if necessary (a second time)
	egrep -c $(RERUN) $(<:%.tex=%.log) && $(COPY) && $(LATEX) $<; true
	# Check the TOC is consistent, else run again
	if cmp -s $(<:%.tex=%.toc) $(<:%.tex=%.toc.bak); then true; else $(LATEX) $< ; fi; true
	$(RM) $(<:%.tex=%.toc.bak)
	# Display relevant warnings
	egrep -i "(Reference|Citation|Label).*(undefined|multiply defined)" $(<:%.tex=%.log)


# Export pdf (and pdf_TeX) file from each svg image
images : $(FIG) $(FIGTEX)

$(GRAPHIC_DIR)/%.pdf $(GRAPHIC_DIR)/%.pdf_tex : $(GRAPHIC_DIR)/%.svg

	inkscape --export-pdf=$(<:.svg=.pdf) --export-latex --export-area-page $<


clean-all : tidy clean-images

# Clean pdf output only. e.g. for: make clean && make
clean : clean-pdf

clean-pdf :
	rm -f $(PDF)

# Tidy up output files
tidy : 
	rm -f $(PDF) $(PDF:%.pdf=%.aux) $(PDF:%.pdf=%.bbl) $(PDF:%.pdf=%.blg) $(PDF:%.pdf=%.lof) $(PDF:%.pdf=%.log) $(PDF:%.pdf=%.lot) $(PDF:%.pdf=%.out) $(PDF:%.pdf=%.toc)

# Clean up image outputs
clean-images : 
	rm -f $(FIG) $(FIGTEX) 
