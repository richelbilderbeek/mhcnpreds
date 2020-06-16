test_that("use", {
  n_aas <- 9
  mhc_haplotype <- "HLA-A01:01"

  filename <- get_lut_filename(
    n_aas = n_aas,
    mhc_haplotype = mhc_haplotype
  )
  expect_true(stringr::str_detect(filename, pattern = as.character(n_aas)))
})
