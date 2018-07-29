#' ba_studies_search_get
#'
#' Search for study details on a brapi server via a GET method
#'
#' @param con list, brapi connection object
#' @param studyDbId character, search for study details by an internal study
#'                  database identifier; default: ""
#' @param trialDbId character, search for studies by an internal trial database
#'                  identifier; default: ""
#' @param programDbId character, search studies by an internal program database
#'                    identifier; default: ""
#' @param commonCropName character, search for studies by a common crop name;
#'                       default: ""
#' @param locationDbId character, search for studies by an internal location
#'                     database identifier; default: ""
#' @param seasonDbId  character, search for studies by an internal season
#'                    database identifier; default: ""
#' @param studyType character; search for studies based on a study type e.g.
#'                  Nursery, Trial or Genotype; default: ""
#' @param germplasmDbIds  character; search for studies where specified
#'                        germplasms, supplied as a comma separated string of
#'                        internal gerplasm database identifiers (e.g. "1,12,
#'                        281"), have been used/tested; default: ""
#' @param observationVariableDbIds  character; search for studies where specified
#'                                  observation variables, supplied as a comma
#'                                  separated string of internal observation
#'                                  variable database identifiers (e.g. "15,100"
#'                                  ), have been measured; default: ""
#' @param active  logical; search studies by active status; default: "",
#'                other possible values TRUE/FALSE
#' @param sortBy character; name of the field to sort by; default: ""
#' @param sortOrder character; sort order direction; default: "", possible values
#'                  "asc"/"desc"
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the studies and
#'         details fulfilling the search criteria.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListStudySummaries.md}{github}
#' @family studies
#' @family phenotyping
# @example inst/examples/ex-ba_studies_search.R

#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active

#'
#' @import tibble
#' @export
ba_studies_search_get <- function(con = NULL,
                              studyDbId = "",
                              trialDbId = "",
                              programDbId = "",
                              commonCropName = "",
                              locationDbId = "",
                              seasonDbId = "",
                              studyType = "",
                              germplasmDbIds = "",
                              observationVariableDbIds = "",
                              active = "",
                              sortBy = "",
                              sortOrder = "",
                              pageSize = 1000,
                              page = 0,
                              rclass = "tibble") {
  .Deprecated("ba_studies_search")
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies-search-get")
  stopifnot(is.character(studyType))
  stopifnot(is.character(programDbId))
  stopifnot(is.character(locationDbId))
  stopifnot(is.character(seasonDbId))
  stopifnot(is.character(germplasmDbIds))
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.character(active))
  stopifnot(is.character(sortBy))
  stopifnot(is.character(sortOrder))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  pstudies_search <- paste0(brp, "studies-search?")
  pstudyType <- ifelse(studyType == "", "",
                       paste0("studyType=", studyType, "&"))
  pprogramDbId <- ifelse(programDbId == "", "",
                         paste0("programDbId=", programDbId, "&"))
  plocationDbId <- ifelse(locationDbId == "", "",
                          paste0("locationDbId=", locationDbId, "&"))
  pseasonDbId <- ifelse(seasonDbId == "", "",
                        paste0("seasonDbId=", seasonDbId, "&"))
  pgermplasmDbIds <- ifelse(germplasmDbIds == "", "",
        paste0("germplasmDbIds=", germplasmDbIds, "&") %>%
          paste0(collapse = ""))
  pobservationVariableDbIds <- ifelse(observationVariableDbIds == "", "",
        paste0("observationVariableDbIds=",
               observationVariableDbIds, "&") %>% paste(collapse = ""))
  pactive <- ifelse(active == "", "", paste0("active=", active, "&"))
  psortBy <- ifelse(sortBy == "", "", paste0("sortBy=", sortBy, "&"))
  psortOrder <- ifelse(sortOrder == "", "",
                       paste0("sortOrder=", sortOrder, "&"))
  ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize <- ifelse(is.numeric(pageSize),
                      paste0("pageSize=", pageSize, "&"), "")
  pstudies_search <- paste0(pstudies_search,
                            pstudyType,
                            pprogramDbId,
                            plocationDbId,
                            pseasonDbId,
                            pgermplasmDbIds,
                            pobservationVariableDbIds,
                            pactive,
                            psortBy,
                            psortOrder,
                            ppageSize,
                            ppage)
  nurl <- nchar(pstudies_search)
  out <- NULL
  if (nurl <= 2000) {
    message("Using GET")
    out <- try({
      res <- brapiGET(url = pstudies_search, con = con)
      res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
      out <- NULL
      if (rclass %in% c("list", "json")) {
        out <- dat2tbl(res = res2, rclass = rclass)
      }
      if (rclass %in% c("data.frame", "tibble")) {
        out <- std2tbl(res = res2, rclass = rclass)
      }
      out
    })
  }

  if (nurl > 2000 ) {
    message("URL too long. Use ba_studies_search_post.")
  }
  if(!is.null(out)) {
    class(out) <- c(class(out), "ba_studies_search_get")

  } else {
    message("Server did not return a result!
            Check your query parameters or contact the server administrator.")
  }

  show_metadata(res)
  return(out)
}