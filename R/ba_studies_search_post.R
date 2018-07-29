#' ba_studies_search_post
#'
#' Search studies on a brapi server via a GET or POST method
#'
#' @note This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#' @note Tested against: sweetpotatobase
#'
#' @param con brapi connection object
#'
#' @param studyDbIds character; default: ''
#' @param trialDbIds character; default: ''
#' @param programDbIds  character; default: ''
#' @param locationDbIds  character; default: ''
#' @param seasonDbId  character; default: ''
#' @param studyType  character; default: ''
#' @param studyNames  character; default: ''
#' @param studyLocations  character; default: ''
#' @param programNames  character; default: ''
#' @param commonCropName  character; default: ''
#' @param germplasmDbIds  character; default: ''
#' @param observationVariableDbIds  character; default: ''
#' @param active  character; default: ''
#' @param sortBy  character; default: ''
#' @param sortOrder  character; default: ''
#' @param page integer; default: 1000
#' @param pageSize integer; default: 0

#' @param rclass character; default: tibble
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/StudiesSearch_POST.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
# @example inst/examples/ex-ba_studies_search.R

#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active

#' @import tibble
#' @family studies
#' @family phenotyping
#' @export
ba_studies_search_post <- function(con = NULL,

                              studyDbIds = "",
                              trialDbIds = "",
                              programDbIds = "",
                              locationDbIds = "",
                              seasonDbId = "",
                              studyType = "",
                              studyNames = "",
                              studyLocations = "",
                              programNames = "",
                              commonCropName = "",
                              germplasmDbIds = "",
                              observationVariableDbIds = "",
                              active = "",
                              sortBy = "",
                              sortOrder = "",
                              page = 0,
                              pageSize = 1000,

                              rclass = "tibble") {
  .Deprecated("ba_studies_search")
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies-search")
  brp <- get_brapi(con = con)
  stopifnot(is.character(studyDbIds))
  stopifnot(is.character(trialDbIds))
  stopifnot(is.character(programDbIds))
  stopifnot(is.character(seasonDbId))
  stopifnot(is.character(studyType))
  stopifnot(is.character(studyNames))
  stopifnot(is.character(studyLocations))
  stopifnot(is.character(programNames))
  stopifnot(is.character(commonCropName))
  stopifnot(is.character(germplasmDbIds))
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.character(active))
  stopifnot(is.character(sortBy))
  stopifnot(is.character(sortOrder))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)

  out <- NULL

  body <- list(
    studyDbIds = studyDbIds,
    trialDbIds = trialDbIds,
    programDbIds = programDbIds,
    locationDbIds = locationDbIds,
    seasonDbId = seasonDbId,
    studyType = studyType,
    studyNames = studyNames,
    studyLocations = studyLocations,
    programNames = programNames,
    commonCropName = commonCropName,
    germplasmDbIds = germplasmDbIds,
    observationVariableDbIds = observationVariableDbIds,
    active = active,
    sortBy = sortBy,
    sortOrder = sortOrder,
    page = page,
    pageSize = pageSize
  )

  for(i in length(body)) {
    if (length(body[i]) == 0) body[i] <- NULL
  }
  #print(str(body))

  out <- try({
    pstudies_search <- paste0(brp, "studies-search/")
    print(pstudies_search)
    res <- brapiPOST(url = pstudies_search, body = body, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("list", "json")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- std2tbl(res2, rclass)
    }
    out
  })
  if(is.null(out)) {
    message("Server did not return a result!
            Check your query parameters or contact the server administrator.")
  } else {
    class(out) <- c(class(out), "ba_studies_search")
  }

  show_metadata(res)
  return(out)
}