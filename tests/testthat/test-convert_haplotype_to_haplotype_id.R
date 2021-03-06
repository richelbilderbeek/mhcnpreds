test_that("use", {
  if (!mhcnuggetsr::is_mhcnuggets_installed()) return()
  lut <- get_haplotype_lut()
  index <- 42
  haplotype <- lut$haplotype[index]
  haplotype_id <- convert_haplotype_to_haplotype_id(haplotype)
  expect_equal(haplotype_id, lut$id[index])
})
