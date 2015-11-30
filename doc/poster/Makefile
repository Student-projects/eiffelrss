all: 	poster pdf

full: 	clean all

clean:
	-rm -f *.aux
	-rm -f *.toc
	-rm -f *.log
	-rm -f *.dvi
	-rm -f *.bbl
	-rm -f *.blg
	-rm -f *.jpg
	-rm -f a0header.ps
	-rm -rf html/

poster:
	latex poster
	latex poster

pdf:
	dvips -o poster.ps poster.dvi
	ps2pdf -dAutoFilterColorImages=false -sColorImageFilter=FlateEncode poster.ps

jpg:
	convert -geometry 25% poster.pdf poster.jpg
