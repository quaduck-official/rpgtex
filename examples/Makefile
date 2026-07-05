DIR_SRC = src
DIR_BLD = bld
DIR_LIB = ..
DIR_PDF = pdf

SRC = $(wildcard $(DIR_SRC)/*.tex)
LIB = $(wildcard $(DIR_LIB)/*.tex) $(wildcard $(DIR_LIB)/*.sty)
PDF = $(SRC:$(DIR_SRC)/%.tex=$(DIR_PDF)/%.pdf)


.PHONY: all
all : $(PDF)


.PHONY: clean
clean :
	rm -rf $(DIR_PDF) $(DIR_BLD)


$(DIR_PDF)/%.pdf : $(DIR_SRC)/%.tex $(LIB) | $(DIR_PDF) $(DIR_BLD)/%
	TEXINPUTS=.:$(abspath $(DIR_LIB))//: \
		  pdflatex -output-directory=$(abspath $(DIR_BLD))/$* $< \
		  && mv $(DIR_BLD)/$*/$*.pdf $(DIR_PDF)/
	TEXINPUTS=.:$(abspath $(DIR_LIB))//: \
		  pdflatex -output-directory=$(abspath $(DIR_BLD))/$* $< \
		  && mv $(DIR_BLD)/$*/$*.pdf $(DIR_PDF)/

	
$(DIR_BLD)/% : ; mkdir -p $@
$(DIR_PDF) : ; mkdir -p $@
