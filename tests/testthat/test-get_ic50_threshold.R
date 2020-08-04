test_that("use", {

  expect_silent(
    get_lut_filename(
      source = "random",
      peptide_length = 9,
      mhc_haplotype = "HLA-A01:01"
    )
  )
  expect_silent(
    get_ic50_threshold(
      source = "random",
      peptide_length = 9,
      mhc_haplotype = "HLA-A01:01",
      percentile = 0.02
    )
  )
})

test_that("use, deprecated", {

  expect_silent(
    get_lut_filename(
      peptide_length = 9,
      mhc_haplotype = "HLA-A01:01"
    )
  )
  expect_silent(
    get_ic50_threshold(
      peptide_length = 9,
      mhc_haplotype = "HLA-A01:01",
      percentile = 0.02
    )
  )
})

test_that("detailed use", {

  t <- readr::read_csv(
    get_lut_filename(
      peptide_length = 9,
      mhc_haplotype = "HLA-A01:01"
    )
  )
  lowest_ic50 <- min(t$ic50)
  median_ic50 <- median(t$ic50)
  heighest_ic50 <- max(t$ic50)

  # 2%: closest to low
  ic50 <- get_ic50_threshold(
    peptide_length = 9,
    mhc_haplotype = "HLA-A01:01",
    percentile = 0.02
  )
  expect_true(ic50 < median_ic50)

  # 98%: closest to high
  ic50 <- get_ic50_threshold(
    peptide_length = 9,
    mhc_haplotype = "HLA-A01:01",
    percentile = 0.98
  )
  expect_true(ic50 > median_ic50)
})
