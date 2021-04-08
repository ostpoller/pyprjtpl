# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?= -c . -E -a
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = source
CONFDIR       = .
BUILDDIR      = ../../package_name-docs

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@test -d $(BUILDDIR) || mkdir $(BUILDDIR)
	@echo 'License' > "$(SOURCEDIR)/license.rst"
	@echo '-------' >> "$(SOURCEDIR)/license.rst"
	@echo ''      >> "$(SOURCEDIR)/license.rst"
	@cat ../LICENSE >> "$(SOURCEDIR)/license.rst"
	@cp ../README.md "$(SOURCEDIR)/readme.md"
	$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)
	@rm -f "$(SOURCEDIR)/license.rst"
	@rm -f "$(SOURCEDIR)/readme.md"
