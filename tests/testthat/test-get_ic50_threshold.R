test_that("use", {

  expect_silent(
    get_ic50_threshold(
      n_aas = 9,
      mhc_haplotype,
      percentile = 0.02
    )
  )
})
