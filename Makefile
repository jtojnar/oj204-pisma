PANDOC ?= pandoc

pandoc_media_dir = media
pandoc_flags = \
	--pdf-engine=xelatex \
	--bibliography=pisma.bib \
	--citeproc \
	--csl=$(CITATION_STYLES)/iso690-full-note-cs.csl \
	--standalone

%.svg: %.easytimeline
	easytimeline -i $^ -f '"Gentium Plus"' -m -T $(shell mktemp -d)

pisma.pdf pisma.tex: pisma.md pisma.bib timeline-aramaic.svg
	$(PANDOC) pisma.md \
		$(pandoc_flags) \
		-o $@
