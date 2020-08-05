#' Convert haplotypes to haplotype IDs
#'
#' Convert one or more haplotypes (in MHCnuggets naming format)
#' to haplotype IDs
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @examples
#' convert_haplotype_to_haplotype_ids("HLA-A33:01")
#' @export
convert_haplotypes_to_haplotype_ids <- function(
  haplotypes
) {
  haplotype_ids <- rep(NA, length(haplotypes))
  for (i in seq_along(haplotype_ids)) {
    haplotype_ids[i] <- mhcnpreds::convert_haplotype_to_haplotype_id(
      haplotypes[i]
    )
  }
  haplotype_ids
}
