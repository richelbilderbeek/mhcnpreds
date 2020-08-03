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
haplotype <- t$haplotype[t_haplotype$id == haplotype_id]

target_filename <- paste0(peptide_source, "_", haplotype_id, "_", peptide_length, ".csv")
message("target_filename: '", target_filename, "'")









library(mhcnuggetsr)



haplotypes <- c(
  mhcnuggetsr::get_trained_mhc_1_haplotypes(),
  mhcnuggetsr::get_trained_mhc_2_haplotypes()
)

# 2 lengths, 2 peptides, all haplotypes: 51 minutes
# 2 lengths, 10 peptides, all haplotypes: ?510 minutes

peptide_lengths <- c(9, 10, 13) # peptide length in amino acids
n_peptides <- 20 # per peptide length and per haplotype


if (mhcnuggetsr::is_on_ci()) {
  n_aases <- c(9, 10)
  n_peptides <- 2
}

for (peptide_length in peptide_lengths) {

  peptides <- replicate(
    n = n_peptides,
    bbbq::create_random_peptide(n_aas = peptide_length)
  )

  for (haplotype in haplotypes) {
    filename <- paste0(haplotype, "_", peptide_length, ".csv")
    filename <- stringr::str_replace_all(filename, ":", "_")
    t <- tibble::tibble(
      peptide = peptides,
      ic50 = NA
    )
    for (i in seq_len(nrow(t))) {
      peptide <- t$peptide[i]
      mhcnuggets_options <- mhcnuggetsr::create_mhcnuggets_options(
        mhc = haplotype
      )
      ic50 <- mhcnuggetsr::predict_ic50(
        mhcnuggets_options = mhcnuggets_options,
        peptides = peptide
      )$ic50
      testthat::expect_equal(1, length(ic50))
      t$ic50[i] <- ic50
    }
    readr::write_csv(t, filename)


  }
}

