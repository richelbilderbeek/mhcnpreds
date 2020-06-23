# Creates lookup tables

library(mhcnuggetsr)

haplotypes <- c(
  mhcnuggetsr::get_trained_mhc_1_haplotypes(),
  mhcnuggetsr::get_trained_mhc_2_haplotypes()
)

# 2 lengths, 2 peptides, all haplotypes: 51 minutes
# 2 lengths, 10 peptides, all haplotypes: ?510 minutes

peptide_lengths <- c(9, 10, 13) # peptide length in amino acids
n_peptides <- 100 # per peptide length and per haplotype


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

