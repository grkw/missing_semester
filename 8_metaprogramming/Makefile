paper.pdf: paper.tex plot-data.png
	pdflatex paper.tex

plot-%.png: %.dat plot.py
	./plot.py -i $*.dat -o $@

.PHONY: clean
clean:
    rm paper.pdf
    rm paper.log
    rm paper.aux
    rm plot-data.png
