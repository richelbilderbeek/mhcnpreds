#' Get the filename for a lookup-table
#'
#' Get the filename for a lookup-table for a specific source,
#' peptide size and haplotype.
#' @inheritParams default_params_doc
#' @export
get_lut_filename <- function(
  source = NA,
  peptide_length,
  mhc_haplotype
) {
  # Use obsoleted interface
  if (is.na(source)) {
    # Non-portable filename
    filename <- paste0(mhc_haplotype, "_", peptide_length, ".csv")
    # Portable filename
    filename <- stringr::str_replace_all(filename, ":", "_")
    full <- system.file("extdata", filename, package = "mhcnpreds")
    if (!file.exists(full)) {
      stop(
        glue::glue(
          "No lookup table exists for haplotype '{mhc_haplotype}' ",
          "for peptides of {peptide_length} amino acids long for source 'NA'. \n",
          "Filename: '{filename}'"
        )
      )
    }
    return(full)
  }
  haplotype_lut <- get_haplotype_lut()

  if (!mhc_haplotype %in% haplotype_lut$haplotype) {
    stop(
      "'mhc_haplotype' not in look-up table. ",
      "'mhc_haplotype': ", mhc_haplotype
    )
  }
  haplotype_id <- haplotype_lut$id[mhc_haplotype == haplotype_lut$haplotype]
  filename <- paste0(source, "_", haplotype_id, "_", peptide_length, ".csv")
  full <- system.file("extdata", filename, package = "mhcnpreds")
  if (!file.exists(full)) {
    stop(
      glue::glue(
        "No lookup table found. \n",
        "'source':  '{source}' \n",
        "'peptide_length': {peptide_length} \n",
        "'mhc_haplotype':  '{mhc_haplotype}' \n",
        "'filename': '{filename}'"
      )
    )
  }
  return(full)

}
