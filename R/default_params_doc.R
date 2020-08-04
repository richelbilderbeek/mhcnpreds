#' This function does nothing. It is intended to inherit is parameters'
#' documentation.
#' @param binding_strength_threshold threshold of the MHC2 allele's
#'   binding strength. A low threshold, e.g. \code{5.0}, selects for the top
#'   5 percent best binders
#' @param fasta_filename name of a FASTA file
#' @param haplotypes a list of MHC-I or MHC-II haplotypes
#' @param ic50_threshold peptides with a predicted IC50 value (in nM)
#'   lower than this will be considered binders.
#'   A threshold of 500 (nM) is common.
#' @param max_hydrophobicity the maximal hydrophobicity
#' @param mhc_haplotype haplotype of either HMC-I or MHC-II.
#'   Use \link{get_mhc1_haplotypes} to get a list of all MHC-I haplotypes.
#'   Use \link{get_mhc2_haplotypes} to get a list of all MHC-II haplotypes.
#' @param mhc_1_haplotype HMC-I haplotope.
#'   Use \link{get_mhc1_haplotypes} to get a list of all haplotypes
#' @param mhc_2_haplotype HMC-II haplotope.
#'   Use \link{get_mhc2_haplotypes} to get a list of all haplotypes
#' @param min_hydrophobicity the minimal hydrophobicity
#' @param n_aas number of amino acids
#' @param n_peptides number of peptides
#' @param peptide_length length of the peptide in amino acids
#' @param protein_sequence a protein sequence
#' @param protein_sequences one or more protein sequences
#' @param source source of IC50s:\cr
#' \enumerate{
#'   \item \code{random} base quantiles on randomly simulated peptides
#'   \item \code{NA} use old interface, to become obsoleted
#' }
#' @param verbose set to TRUE for more output
#' @author Richèl J.C. Bilderbeek
#' @note This is an internal function, so it should be marked with
#'   \code{@noRd}. This is not done, as this will disallow all
#'   functions to find the documentation parameters
default_params_doc <- function(
  binding_strength_threshold,
  fasta_filename,
  haplotypes,
  ic50_threshold,
  max_hydrophobicity,
  mhc_haplotype,
  mhc_1_haplotype,
  mhc_2_haplotype,
  min_hydrophobicity,
  n_aas,
  n_peptides,
  peptide_length,
  protein_sequence,
  protein_sequences,
  source,
  verbose
) {
  # Nothing
}
