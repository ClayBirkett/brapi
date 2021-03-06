#' ba_genomemaps_data_range
#'
#' Get map data by range on linkageGroup
#'
#' markers ordered by linkageGroup and position

#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param page integer; default 0
#' @param pageSize character; default 30
#' @param mapDbId character; default 0
#' @param linkageGroupName character; default 1
#' @param min character; default ''
#' @param max character; default ''
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapDataByRangeOnLinkageGroup.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_genomemaps_data_range.R
#' @import tibble
#' @importFrom magrittr '%>%'
#' @family genomemaps
#' @family genotyping
#' @export
ba_genomemaps_data_range <- function(con = NULL,
                                     mapDbId = "1",
                                     linkageGroupName = "1",
                                     min = "",
                                     max = "",
                                     page = 0,
                                     pageSize = 30,
                                     rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "maps/id/positions/id")
  stopifnot(is.character(mapDbId))
  stopifnot(is.character(linkageGroupName))


  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate the brapi call url
  maps_positions_range_list <- paste0(brp, "maps/", mapDbId,
                                  "/positions/", linkageGroupName, "/?")
  amin <- ifelse(is.numeric(min), paste0("min=", min, "&"), "")
  amax <- ifelse(is.numeric(max), paste0("max=", max, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                   pageSize, "&"), "")
  if (pageSize >= 10000) {
    ppage <- ""
    ppageSize <- ""
  }
  # modify the brapi call url for ordered range and pagenation
  maps_positions_range_list <- paste0(maps_positions_range_list, amin,
                                      amax, ppageSize, ppage)
  try({
    res <- brapiGET(url = maps_positions_range_list, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    if (rclass == "vector") {
      rclass <- "tibble"
    }
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_genomemaps_data_range")

    show_metadata(res)
    return(out)
  })
}
