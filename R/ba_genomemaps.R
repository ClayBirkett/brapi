#' ba_genomemaps
#'
#' Get list of maps
#'
#' @note This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param species character; default:
#' @param type character, default: ''
#' @param page integer; default 0
#' @param pageSize integer; default 30
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/ListOfGenomeMaps.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_genomemaps.R
#' @import tibble
#' @family genomemaps
#' @family genotyping
#' @export
ba_genomemaps <- function(con = NULL,
                          species = "",
                          type = "",
                          page = 0,
                          pageSize = 30,
                          rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "maps")
  stopifnot(is.character(species))
  stopifnot(is.character(type))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate the call url
  genomemaps_list <- paste0(brp, "maps/?")
  species <- ifelse(species != "", paste0("species=", species, "&"), "")
  type <- ifelse(type != "", paste0("type=", type, "&"), "")
  page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize <- ifelse(is.numeric(pageSize),
                     paste0("pageSize=", pageSize, "&"), "")
  # modify the call url to include pagenation
  genomemaps_list <- paste0(genomemaps_list, page, pageSize, species, type)
  try({
    res <- brapiGET(url = genomemaps_list, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    if (rclass == "vector") {
      rclass <- "tibble"
    }
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_genomemaps")

    show_metadata(res)
    return(out)
  })
}
