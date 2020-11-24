test_that("use", {
  if (!mhcnuggetsr::is_mhcnuggets_installed()) return()

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
  if (!mhcnuggetsr::is_mhcnuggets_installed()) return()
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

test_that("simulated peptides must be in LUT", {

  if (!mhcnuggetsr::is_on_ci()) return()
  if (!mhcnuggetsr::is_mhcnuggets_installed()) return()

  set.seed(42)
  # Simulate n peptides, check if these are in range
  n <- 100
  peptide_length <- 9
  haplotype <- "HLA-A01:01"
  peptides <- replicate(n = 100, create_random_peptide(peptide_length))
  mhcnuggets_options <- mhcnuggetsr::create_mhcnuggets_options(mhc = haplotype)
  ic50s <- mhcnuggetsr::predict_ic50(mhcnuggets_options, peptides)

  min_ic50 <- mhcnpreds::get_ic50_threshold(
    peptide_length = peptide_length,
    mhc_haplotype = haplotype,
    percentile = 0.0
  )
  mean_ic50 <- mhcnpreds::get_ic50_threshold(
    peptide_length = peptide_length,
    mhc_haplotype = haplotype,
    percentile = 0.5
  )
  max_ic50 <- mhcnpreds::get_ic50_threshold(
    peptide_length = peptide_length,
    mhc_haplotype = haplotype,
    percentile = 1.0
  )
  # All IC50s, are within the range
  expect_equal(n, sum(min_ic50 < ic50s$ic50 & max_ic50 > ic50s$ic50))

  # Mean IC50s are similar
  expect_true(mean(ic50s$ic50) > 0.99 * mean_ic50)
  expect_true(mean(ic50s$ic50) < 1.01 * mean_ic50)
})
