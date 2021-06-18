# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

livehtml:
	sphinx-autobuild -a "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O) --watch _static

spell:
	vale $(SOURCEDIR)/index.rst
	vale $(SOURCEDIR)/docs

# Index pages to Elasticsearch:
# "make index-pages ES_URL=url
index-pages: html
	python "$(SOURCEDIR)/scripts/index_pages.py" \
		--html-build-dir="$(BUILDDIR)/html" \
		--es-url="$(ES_URL)"
