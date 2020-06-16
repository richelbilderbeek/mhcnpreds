#' Get the filename for a lookup-table for a specific peptide size
#' and haplotype
#' @inheritParams default_params_doc
#' @export
get_lut_filename <- function(
  n_aas,
  mhc_haplotype
) {
  # Non-portable filename
  filename <- paste0(mhc_haplotype, "_", n_aas, ".csv")
  # Portable filename
  filename <- stringr::str_replace(filename, ":", "_")
  full <- system.file("extdata", filename, package = "mhcnpreds")
  if (!file.exists(full)) {
    stop(
      glue::glue(
        "No lookup table exists for haplotype '{mhc_haplotype}' ",
        "for peptides of {n_aas} amino acids long. \n",
        "Filename: '{filename}'"
      )
    )
  }
  full
}
