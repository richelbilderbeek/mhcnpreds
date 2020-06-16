# Usage:
#
# * On local, creates figures:
#
#   make
#
# * On Peregrine, creates data:
# 
#   make data
#
#   (do this by 'sbatch make.sh)
#

all:
	Rscript create_luts.R

zip:
	zip luts.zip *.csv *.log *.R Makefile *.sh

clean:
	rm -f *.png *.pdf *.log *.png *.csv

