#' ba_observationvariables_details
#'
#' lists brapi_variables_details available on a brapi server
#'
#' @param rclass character; default: tibble
#' @param con list; brapi connection object
#' @param observationVariableDbId character; default ''; from test server.
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableDetails.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
#' @example inst/examples/ex-ba_observationvariables_details.R
#' @import tibble
#' @family observationvariables
#' @family brapicore
#'
#' @export
ba_observationvariables_details <- function(con = NULL,
                                    observationVariableDbId = "",
                                            rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables/id")
  stopifnot(is.character(observationVariableDbId))
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  brapi_variables_details <- ifelse(observationVariableDbId != "",
                                    paste0(brp, "variables/", observationVariableDbId),
                                    paste0(brp, "variables/"))
  try({
    res <- brapiGET(url = brapi_variables_details, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
        out <- sov2tbl(res = res2, rclass =  rclass, variable = TRUE)
    }
    class(out) <- c(class(out), "ba_observationvariables_details")
    show_metadata(res)
    return(out)
  })
}
