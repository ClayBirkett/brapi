#' ba_studies_table
#'
#' lists studies_table available on a brapi server
#'
#' This function must have set a specific study identifier. The default is an empty
#' string. If not changed to an study identifier present in the database this will
#' result in an error.
#'
#' @note Tested against: sweetpotatobase, BMS
#'
#' @param rclass character; default: "tibble" possible other values: "json"/"list"/"data.frame"
#' @param studyDbId character; default: ''
#' @param con list; brapi connection object
#' @param format character; one of: json, csv, tsv. Default: csv
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyObservationUnitsAsTable.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_table.R
#' @import tibble
#' @import readr
#' @importFrom utils read.csv read.delim
#' @family studies
#' @family phenotyping
#' @export
ba_studies_table <- function(con = NULL,
                             studyDbId = "",
                             format = "csv",
                             rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/table")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  stopifnot(format %in% c("json", "tsv", "csv"))
  check_rclass(rclass =  rclass)
  brp <- get_brapi(con = con)

  studies_table <- paste0(brp, "studies/", studyDbId, "/table?")
  # if (rclass %in% c("data.frame", "tibble") & format == "json") {
  #   format <- "csv"
  # }
  pformat <- ifelse(format %in% c("json", "csv", "tsv"),
                    paste0("format=", format, "&"), "")
  studies_table <- sub("[/?&]$",
                       "",
                       paste0(studies_table,
                              pformat))
  try({
    res <- brapiGET(url = studies_table, con = con)
  })
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      if (format == "json") {
        res2 <- jsonlite::fromJSON(txt = res)$result
        out <- res2$data
        out <- tibble::as.tibble(out)
        if(length(res2$headerRow) != length(colnames(out)))
          stop('Header row length does not coincide with column count. Contact database provider.')
        colnames(out) <- res2$headerRow
      }
      if (format == "csv") {
        if (con$bms == TRUE) {
          out <- read.csv(textConnection(res))
          colnames(out) <- gsub("\\.", "|", colnames(out))
        } else {
        url <- jsonlite::fromJSON(txt = res)$metadata$datafiles[1]
        out <- readr::read_csv(file = url, progress = TRUE)
        }
      }
      if (format == "tsv") {
        if (con$bms == TRUE) {
          out <- read.delim(textConnection(res))
          colnames(out) <- gsub("\\.", "|", colnames(out))
        } else {
        url <- jsonlite::fromJSON(txt = res)$metadata$datafiles[1]
        out <- readr::read_tsv(file = url, progress = TRUE)
        }
      }
      if (rclass == "data.frame") {
        class(out) <- "data.frame"
      }
    }
    class(out) <- c(class(out), "ba_studies_table")
    return(out)

}
