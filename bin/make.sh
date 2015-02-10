name=sigproc-sp

# Clean
rm -f *.pdf $name.out $name.aux $name.bbl $name.blg $name.dvi $name.log

# Convert any ps images
ps2pdf

pdflatex $name.tex
bibtex $name
pdflatex $name.tex
pdflatex $name.tex
