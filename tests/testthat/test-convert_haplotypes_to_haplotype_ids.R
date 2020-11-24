test_that("use", {
  if (!mhcnuggetsr::is_mhcnuggets_installed()) return()
  lut <- get_haplotype_lut()
  index <- 42
  haplotype <- lut$haplotype[index]
  haplotype_id <- convert_haplotypes_to_haplotype_ids(haplotypes = haplotype)
  expect_equal(haplotype_id, lut$id[index])
})
