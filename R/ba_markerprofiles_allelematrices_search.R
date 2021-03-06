#' ba_markerprofiles_allelematrices_search
#'
#' Gets markers in matrix format. If the format parameter is set to either csv or tsv the returned object
#' is always a tibble object. If the format parameter is 'json' (default) the rclass parameter can be used
#' to as in other functions.
#'
#' @param con brapi connection object
#' @param markerprofileDbId character vector; default ''
#' @param markerDbId character vector; default ''
#' @param expandHomozygotes logical; default false
#' @param unknownString chaaracter; default: '-'
#' @param sepPhased character; default: '|'
#' @param sepUnphased character; default: '/'
#' @param format character; default: json; other: csv, tsv
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @note The handling of long-running responses via asynch status messages is not yet implemented.

#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @example inst/examples/ex-ba_markerprofiles_allelematrices_search.R
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/MarkerProfiles/MarkerProfileAlleleMatrices.md}{github}
#'
#' @return data.frame
#' @family markerprofiles
#' @family genotyping
#' @export
ba_markerprofiles_allelematrices_search <- function(con = NULL,
                                                  markerprofileDbId = "",
                                                  markerDbId = "",
                                                  expandHomozygotes = FALSE,
                                                  unknownString = "-",
                                                  sepPhased = "|",
                                                  sepUnphased = "/",
                                                  format = "json",
                                                  page = 0,
                                                  pageSize = 10000,
                                                  rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "allelematrices-search")
  stopifnot(is.character(markerprofileDbId))
  stopifnot(is.character(markerDbId))
  stopifnot(is.logical(expandHomozygotes))
  stopifnot(is.character(unknownString))
  stopifnot(is.character(sepPhased))
  stopifnot(is.character(sepUnphased))
  stopifnot(format %in% c("json", "tsv", "csv"))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)

  brp <- get_brapi(con = con)

  pallelematrix_search <- paste0(brp, "allelematrices-search/?")
  pmarkerprofileDbId <- ifelse(markerprofileDbId != "", paste0("markerprofileDbId=",
                               markerprofileDbId, "&") %>% paste(collapse = ""), "")
  pmarkerDbId <- ifelse(markerDbId != "", paste0("markerDbId=", markerDbId, "&") %>%
    paste(collapse = ""), "")
  pexpandHomozygotes <- ifelse(expandHomozygotes == TRUE,
                               paste0("expandHomozygotes=",
                                tolower(expandHomozygotes), "&"), "")
  psepPhased <- ifelse(sepPhased != "|", paste0("sepPhased=",
                                               sepPhased, "&"), "")
  psepUnphased <- ifelse(sepUnphased != "/",
                         paste0("sepUnphased=", sepUnphased, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                   pageSize, "&"), "")
  rclass <- ifelse(rclass %in%
                     c("tibble", "data.frame", "json", "list"),
                   rclass, "tibble")
  pformat <- ifelse(!(format %in% c("json", "csv", "tsv")) ,
                    paste0("format=", format, "&"), "")
  pallelematrix_search <- paste0(pallelematrix_search,
                                 pmarkerprofileDbId,
                                 pmarkerDbId,
                                 pexpandHomozygotes,
                                 psepPhased,
                                 psepUnphased,
                                 pformat,
                                 ppageSize,
                                 ppage)
  out <- try({
    res <- brapiGET(url = pallelematrix_search, con = con)
    ams2tbl(res = res, format = format, rclass = rclass)
  })

  class(out) <- c(class(out), "ba_markerprofiles_allelematrices_search")
  show_metadata(res)
  return(out)
}
