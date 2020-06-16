test_that("use", {

  expect_silent(
    get_lut_filename(
      n_aas = 9,
      mhc_haplotype = "HLA-A01:01"
    )
  )
  expect_silent(
    get_ic50_threshold(
      n_aas = 9,
      mhc_haplotype = "HLA-A01:01",
      percentile = 0.02
    )
  )
})
