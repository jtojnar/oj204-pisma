PANDOC ?= pandoc

pandoc_media_dir = media
pandoc_flags = \
	--pdf-engine=lualatex \
	--bibliography=pisma.bib \
	--bibliography=thai.bib \
	--citeproc \
	--csl=$(CITATION_STYLES)/iso690-full-note-cs.csl \
	--standalone

%.svg: %.dot
	dot \
		-Nfontname="Gentium Plus" \
		-Gfontname="Gentium Plus" \
		-Efontname="Gentium Plus" \
		-Tsvg \
		$^ \
		-o $@

%.svg: %.easytimeline
	easytimeline -i $^ -f '"Gentium Plus"' -m -T $(shell mktemp -d)
	python3 move-link-out-of-text.py $@

final_deps = \
	pisma.md \
	pisma.bib \
	timeline-aramaic.svg \
	hebrew-consonants.json \
	hebrew-nikud.json \
	thai.bib \
	timeline-thai.svg \
	lineage-thai.svg \
	thai-consonants.json \
	$(NULL)

pisma.pdf pisma.tex: $(final_deps)
	$(PANDOC) pisma.md \
		$(pandoc_flags) \
		-o $@
