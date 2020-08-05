test_that("use", {
  peptide_length <- 9
  mhc_haplotype <- "HLA-A01:01"

  filename <- get_lut_filename(
    peptide_length = peptide_length,
    mhc_haplotype = mhc_haplotype
  )
  expect_equal(basename(filename), "random_h11_9.csv")
})
