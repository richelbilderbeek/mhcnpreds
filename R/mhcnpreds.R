#' mhcnpreds: Lookup tables for MHCnuggets IC50 predictions
#'
#' We can predict how well a peptide binds to the presentation molecules
#' used by the immune system. This package allows to see how well a
#' molecule binds relatively.
#'
#' The \code{mhcnuggetsr} R package can predict the IC50 (50% inhibitory
#' concentration) of a peptide for an MHC (I or II) haplotype.
#' A peptide that is strongly bound to the MHC molecules is in the
#' lower percentile, for example in the lowest 2% of all IC50s.
#' This package determines the threshold IC50 for all percentiles.
#'
#' To be able to do so,
#' the IC50 predictions of 10k random peptides is measured
#' and the distribution at the percentile level is stored as a lookup table.
#' @examples
#'
#' if (mhcnuggetsr::is_mhcnuggets_installed()) {
#'   # mhcnuggetsr has a list of MHC haplotypes
#'   mhc_haplotype <- mhcnuggetsr::get_trained_mhc_1_haplotypes()[100]
#' } else {
#'   # or use a hard-coded haplotype, in MHCnuggets naming format
#'   mhc_haplotype <- "HLA-B83:01"
#'
#' }
#'
#' # Get the IC50 value of which 2% of IC50 predictions are below,
#' # that is, bind better to the MHC complexes
#' ic50_threshold <- get_ic50_threshold(
#'   peptide_length = 9,
#'   mhc_haplotype = mhc_haplotype,
#'   percentile = 0.02
#' )
#'
#' # A IC50 value predicted by MHCnuggets
#' my_ic50 <- 100.0
#'
#' if (my_ic50 < ic50_threshold) {
#'   message("This is a binder, as it is in the lowest 2% of all IC50s")
#' }
#' @author Richèl J.C. Bilderbeek
#' @docType package
#' @name mhcnpreds
NULL
