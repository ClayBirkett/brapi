#' ba_germplasm_breedingmethods_details
#'
#' Lists breeding methods available on a brapi server.
#'
#' @param con list, brapi connection object
#' @param breedingMethodDbId character
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing breedingmethods.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/BreedingMethods_BreedingMethodDbId_GET.md}{github}
#' @example inst/examples/ex-ba_germplasm_breedingmethods_details.R
#' @import tibble
#' @export
ba_germplasm_breedingmethods_details <- function(con = NULL,
                         breedingMethodDbId = "",
                         rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "breedingmethods/breedingMethodDbId")
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate the brapi call specific url
  callname <- paste0(brp, "breedingmethods/", breedingMethodDbId)

  callname <- sub("[/?&]$",
                        "",
                        paste0(callname))
  try({
    res <- brapiGET(url = callname, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- dat2tbl(res = res2, rclass = rclass, result_level = "result")
    }
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_germplasm_breedingmethods_details")
    }
    show_metadata(res)
    return(out)
  })
}
