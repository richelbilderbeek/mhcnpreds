library(mhcnpreds, warn.conflicts = FALSE)
library(lubridate, warn.conflicts = FALSE)

haplotypes <- c(
  mhcnuggetsr::get_trained_mhc_1_haplotypes(),
  mhcnuggetsr::get_trained_mhc_2_haplotypes()
)
peptide_lengths <- c(9, 10)


duration <- lubridate::minutes(5)

verbose <- FALSE

# Run 5 minutes
run_interval <- lubridate::interval(
  start = lubridate::now(),
  end = lubridate::now() + duration
)

i <- 1
for (haplotype in haplotypes) {
  for (peptide_length in peptide_lengths) {
    ic50_threshold <- mhcnpreds::get_ic50_threshold(
      peptide_length = peptide_length,
      mhc_haplotype = haplotype
    )
    if (isTRUE(verbose)) {
      message("#", i, ": ", ic50_threshold)
    }
    if (!lubridate::now() %within% run_interval) {
      message("Processed ", i, " lookups in ", duration)
      message("Average time per lookup: ", lubridate::seconds(duration) / i)
      q()
    }
    i <- i + 1
  }
}

message("Done!")
message("Processed ", i, " lookups in ", duration)
message("Average time per lookup: ", lubridate::seconds(duration) / i)
