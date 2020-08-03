test_that("use", {
  haplotypes <- c(
    mhcnuggetsr::get_trained_mhc_1_haplotypes(),
    mhcnuggetsr::get_trained_mhc_2_haplotypes()
  )
  t <- get_haplotype_lut()
  expect_true("haplotype" %in% names(t))
  expect_true("id" %in% names(t))
  expect_equal(nrow(t), length(haplotypes))
  expect_equal(t$haplotype, haplotypes)
  expect_equal(paste0("h", seq(1, nrow(t))), t$id)
})
