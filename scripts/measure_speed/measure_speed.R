library(mhcnpreds, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)

haplotypes <- c(
  mhcnuggetsr::get_trained_mhc_1_haplotypes(),
  mhcnuggetsr::get_trained_mhc_2_haplotypes()
)
peptide_lengths <- c(9, 10)

# Run 5 minutes
run_interval <- lubridate::interval(
  start = lubridate::now(),
  end = lubridate::now() + lubridate::minutes(5)
)

i <- 1
for (haplotype in haplotypes) {
  for (peptide_length in peptide_lengths) {
    message(
      "#", i, ": ",
      mhcnpreds::get_ic50_threshold(
        peptide_length = peptide_length,
        mhc_haplotype = haplotype
      )
    )
    if (!lubridate::now() %within% run_interval) {
      message("Processed ", i, " lookups")
      q()
    }
    i <- i + 1
  }
}
