library(mhcnpreds)

haplotypes <- c(
  mhcnuggetsr::get_mhc_1_haplotypes(),
  mhcnuggetsr::get_mhc_2_haplotypes()
)
length(haplotypes)

t <- tibble::tibble(
  haplotype = haplotypes,
  p0 = NA,
  p1 = NA,
  p5 = NA,
  p50 = NA,
  p95 = NA,
  p99 = NA,
  p100 = NA
)

for (i in seq_len(nrow(t))) {
  message(i)
  haplotype <- t$haplotype[i]
  t$p0[i] <- mhcnpreds::get_ic50_threshold(mhc_haplotype = haplotype, percentile = 0.00)
  t$p1[i] <- mhcnpreds::get_ic50_threshold(mhc_haplotype = haplotype, percentile = 0.01)
  t$p5[i] <- mhcnpreds::get_ic50_threshold(mhc_haplotype = haplotype, percentile = 0.05)
  t$p50[i] <- mhcnpreds::get_ic50_threshold(mhc_haplotype = haplotype, percentile = 0.50)
  t$p95[i] <- mhcnpreds::get_ic50_threshold(mhc_haplotype = haplotype, percentile = 0.95)
  t$p99[i] <- mhcnpreds::get_ic50_threshold(mhc_haplotype = haplotype, percentile = 0.99)
  t$p100[i] <- mhcnpreds::get_ic50_threshold(mhc_haplotype = haplotype, percentile = 1.0)
}

readr::write_csv(t, "ic50s.csv")
