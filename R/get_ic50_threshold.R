#' Look up the IC50 value of a certain quantile
#'
#' Look up the IC50 value of a certain quantile.
#' Such a value can serve as a threshold:
#' for example, to get the IC50 value from below which the
#' peptides bind strongest.
#' @inheritParams default_params_doc
#' @param percentile the IC50 percentile. The IC50 that separates the top
#' \code{percentile} from the worse binders
#' @export
get_ic50_threshold <- function(
  source = NA,
  peptide_length = 9,
  mhc_haplotype,
  percentile = 0.02
) {
  filename <- mhcnpreds::get_lut_filename(
    source = source,
    peptide_length = peptide_length,
    mhc_haplotype = mhc_haplotype
  )
  if (is.na(source)) {
    # Oldskool method stores peptides and IC50s, instead of quantiles
    ic50 <- as.numeric(
      stats::quantile(
        readr::read_csv(
          filename,
          col_types = readr::cols(
            peptide = readr::col_character(),
            ic50 = readr::col_double()
          )
        )$ic50,
        probs = percentile
      )
    )
    return(ic50)
  }
  lut <- readr::read_csv(
    filename,
    col_types = readr::cols(
      q = readr::col_double(),
      ic50 = readr::col_double()
    )

  )
  mhcnpreds::convert_quantile_to_ic50(lut = lut, q = percentile)
}
