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
	sbatch ../../peregrine/scripts/run_r_script.sh create_luts.R random 9 h1
	sbatch ../../peregrine/scripts/run_r_script.sh create_luts.R random 9 h2
	sbatch ../../peregrine/scripts/run_r_script.sh create_luts.R random 10 h1
	sbatch ../../peregrine/scripts/run_r_script.sh create_luts.R random 10 h2
	sbatch ../../peregrine/scripts/run_r_script.sh create_luts.R random 13 h1
	sbatch ../../peregrine/scripts/run_r_script.sh create_luts.R random 13 h2

zip:
	zip luts.zip *.csv *.log *.R Makefile *.sh

clean:
	rm -f *.png *.pdf *.log *.png *.csv

