test_that("use", {
  if (!mhcnuggetsr::is_mhcnuggets_installed()) return()
  peptide_length <- 9
  mhc_haplotype <- "HLA-A01:01"

  lut <- get_lut(
    peptide_length = peptide_length,
    mhc_haplotype = mhc_haplotype
  )
  lut
})
