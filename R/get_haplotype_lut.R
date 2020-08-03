#' The mapping from an MHCnuggets name to an ID
#' @export
get_haplotype_lut <- function() {
  t <- tibble::tibble(
    haplotype = c(
      mhcnuggetsr::get_trained_mhc_1_haplotypes(),
      mhcnuggetsr::get_trained_mhc_2_haplotypes()
    ),
    id = NA
  )
  t$id <- paste0("h", seq(1, nrow(t)))
  t
}
