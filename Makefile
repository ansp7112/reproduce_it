###############################
## MAKE VARIABLES AND RECIPE ##
###############################

md = source/the_ms.md
tx = output/the_ms.tex
pdf = output/the_ms.pdf
docx = output/the_ms.docx
format = source/format.yaml
meta = source/metadata.yaml
bib = source/simple.bib

figs = figures/flight.pdf figures/flight.png 

R_outs = output/r_vars.tex
py_outs = output/py_vars.tex

#GNU make looks for updates the files that each of these depend on
all: $(docx) $(tx) $(pdf) $(bib) $(meta) $(md) $(format) $(figs)


##############
## ANALYSES ##
##############

#produce figure and R variable
$(figs): source/flight.R
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

#output to tex from md
$(tx): $(md) $(meta) $(format) $(bib) $(figs)
	pandoc -s $(md) \
		$(meta) \
		$(format) \
		-o $(tx) \
		--filter pandoc-fignos \
		--filter pandoc-tablenos \
		--bibliography $(bib) \
		--csl $(my_csl)

#output pdf from md
$(pdf): $(md) $(meta) $(format) $(bib) $(figs)
	pandoc -s $(md) \
		$(meta) \
		$(format) \
		-o $(pdf) \
		--filter pandoc-fignos \
		--filter pandoc-tablenos \
		--bibliography $(bib) \
		--csl $(my_csl)

#output docx from md
$(docx): $(md) $(metadata) $(format) $(bib) $(figs)
	pandoc -s $(md) \
		$(metadata) \
		$(format) \
		-o $(docx) \
		--filter pandoc-fignos \
		--filter pandoc-tablenos \
		--bibliography $(bib) \
		--csl $(my_csl)

