###############################
## MAKE VARIABLES AND RECIPE ##
###############################

R_outs = figures/flight.pdf figures/flight.png output/r_vars.tex
py_outs = output/py_vars.tex

md = source/the_ms.md
tx = source/the_ms.tex
pdf = output/the_ms.pdf
docx = output/the_ms.docx
format = source/format.yaml
meta = source/metadata.yaml
bib = source/simple.bib


#GNU make looks for updates the files that each of these depend on
all: $(tx) $(pdf) $(docx) $(R_outs) $(py_outs)

##############
## ANALYSES ##
##############

#produce figure and R variable
$(R_outs): source/flight.R
	Rscript source/flight.R

$(py_outs): source/python_too.py
	python source/python_too.py


#####################
## CITATION STYLES ##
#####################

#snag two example citations styles from github
source/cell.csl:  
	wget https://raw.githubusercontent.com/citation-style-language/styles/master/cell.csl

source/apa.csl:
	wget https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl

#cell for funsies, but easy to change
my_csl=source/cell.csl


###############
## DOCUMENTS ##
###############

#output to tex
$(tx): $(md) $(meta) $(format) $(bib) $(R_outs) $(py_outs)
	pandoc -s $(md) \
		$(meta) \
		$(format) \
		-o $(tx) \
		--filter pandoc-fignos \
		--filter pandoc-tablenos \
		--bibliography $(bib) \
		--csl $(my_csl)

$(pdf): $(tx)
	xelatex $(tx)

#output docx
$(docx): $(md) $(metadata) $(format) $(bib) $(R_outs) $(py_outs)
	pandoc -s $(md) \
		$(metadata) \
		$(format) \
		-o $(docx) \
		--filter pandoc-fignos \
		--filter pandoc-tablenos \
		--bibliography $(bib) \
		--csl $(my_csl)

