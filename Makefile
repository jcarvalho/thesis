PROJ=tese
.PHONY: clean open spell

all: $(PROJ).pdf

open: $(PROJ).pdf
	acroread $^ &

$(PROJ).pdf: $(PROJ).bbl *.tex
	pdflatex $(PROJ)
	makeindex $(PROJ).nlo -s nomencl.ist -o $(PROJ).nls
	pdflatex $(PROJ)
	pdflatex $(PROJ)

$(PROJ).bbl: biblio.bib $(PROJ).tex
	pdflatex $(PROJ)
	bibtex $(PROJ)

spell:
	find -maxdepth 1 -name '*.tex' -exec aspell -t -c -p $(shell pwd)/dict.txt {} \;

clean:
	rm -f $(PROJ).pdf *.aux *.toc *.bbl *.blg *.log *.out *.bak *.lot *.lof *.ilg *.nlo *.nls
