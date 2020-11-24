test_that("use", {
  if (!mhcnuggetsr::is_mhcnuggets_installed()) return()
  peptide_length <- 9
  mhc_haplotype <- "HLA-A01:01"

  filename <- get_lut_filename(
    peptide_length = peptide_length,
    mhc_haplotype = mhc_haplotype
  )
  expect_equal(basename(filename), "random_h11_9.csv")
})

test_that("abuse", {
  if (!mhcnuggetsr::is_mhcnuggets_installed()) return()

  peptide_length <- 9
  mhc_haplotype <- "HLA-A01:01"

  expect_silent(
    get_lut_filename(
      peptide_length = peptide_length,
      mhc_haplotype = mhc_haplotype
    )
  )
  expect_error(
    get_lut_filename(
      peptide_length = 123,
      mhc_haplotype = mhc_haplotype
    ),
    "No lookup table found for the desired peptide length"
  )
  expect_error(
    get_lut_filename(
      peptide_length = peptide_length,
      mhc_haplotype = "nonsense"
    ),
    "'mhc_haplotype' not in lookup table"
  )
})
