#' BKKCrypt Encryption
#' @param x string
#' @return "encrypted" string
#' @export
#' @useDynLib BKKCrypt
#' @exportPattern ^[[:alpha:]]+
#' @importFrom Rcpp evalCpp
BKKCrypt <- function(x) {
    rcpp_BKKCrypt(x)
}
