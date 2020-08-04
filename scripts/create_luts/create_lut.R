# Creates lookup tables
#
# Usage:
#
#   Rscript create_luts.R [peptide_source] [peptide_length] [haplotype_index]
#
# * [peptide_source]: peptide source, must be 'random', 'covid', 'human'
# * [peptide_length]: a number from 1 to and including 15
# * [haplotype_index]: the haplotype index, from 1 to and including 284
#
# For example:
#
#   Rscript create_luts.R 1
#
library(testthat)
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 1) {
  args <- c("random", "9", "h1")
}
testthat::expect_equal(length(args), 3)
message(
  "Running with arguments '", args[1], "', '", args[2], "' and '", args[3], "'"
)

peptide_source <- args[1]
message("peptide_source: '", peptide_source, "'")
peptide_length <- args[2]
message("peptide_length: '", peptide_length, "'")
haplotype_id <- args[3]
message("haplotype_id: '", haplotype_id, "'")

t_haplotype <- get_haplotype_lut()
haplotype <- t_haplotype$haplotype[t_haplotype$id == haplotype_id]
message("haplotype: ", haplotype)

target_filename <- paste0(peptide_source, "_", haplotype_id, "_", peptide_length, ".csv")
message("target_filename: '", target_filename, "'")

n_peptides <- 10
message("n_peptides: ", n_peptides)

n_quantiles <- 10
message("n_quantiles: ", n_quantiles)

library(mhcnuggetsr)

peptides <- replicate(
  n = n_peptides,
  mhcnpreds::create_random_peptide(length = peptide_length)
)

mhcnuggets_options <- mhcnuggetsr::create_mhcnuggets_options(
  mhc = haplotype
)
ic50s <- mhcnuggetsr::predict_ic50(
  mhcnuggets_options = mhcnuggets_options,
  peptides = peptides
)$ic50

q <- mhcnpreds::convert_ic50s_to_quantiles(ic50s, n = 10)

readr::write_csv(q, target_filename)
