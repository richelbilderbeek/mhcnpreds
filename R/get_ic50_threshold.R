#' Get the IC50 value to serve as a threshold,
#' for example, get the IC50 value from below which the
#' peptides bind strongest
#' @inheritParams mhcnuggetsr::default_params_doc
#' @param percentile the IC50 percentile. The IC50 that separates the top
#' \code{percentile} from the worse binders
#' @export
get_ic50_threshold <- function(
  n_aas = 9,
  mhc_haplotype,
  percentile = 0.02
) {
  3.14
}
