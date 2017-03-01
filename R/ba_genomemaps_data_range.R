#' ba_genomemaps_data_range
#'
#' lists genomemaps_data_range available on a brapi server

#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 30
#' @param mapDbId integer; default 0
#' @param linkageGroupId integer; default 0
#' @param min integer; default 0
#' @param max integer; default 1000
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapDataByRangeOnLinkageGroup.md}
#' @return rclass as defined
#' @example inst/examples/ex-ba_genomemaps_data_range.R
#' @import tibble
#' @importFrom magrittr '%>%'
#' @family genomemaps
#' @family genotyping
#' @export
ba_genomemaps_data_range <- function(con = NULL, mapDbId = 1, linkageGroupId = 1,
                                  min = 1, max = 1000, page = 0,
    pageSize = 30, rclass = "tibble") {
    # TODO: revision; rename: map_data_range
    ba_check(con, FALSE, "maps/id/positions/id")
    brp <- get_brapi(con)
    maps_positions_range_list <- paste0(brp, "maps/", mapDbId, "/positions/",
                                       linkageGroupId, "/?")
    amin <- ifelse(is.numeric(min), paste0("min=", min, "&"), "")
    amax <- ifelse(is.numeric(max), paste0("max=", max, "&"), "")

    ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
    ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                   pageSize, "&"), "")
    if (pageSize >= 10000) {
      ppage <- ""
      ppageSize <- ""
    }
    maps_positions_range_list <- paste0(maps_positions_range_list, amin, amax,
                                       ppageSize, ppage )
    try({
        res <- brapiGET(maps_positions_range_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        if (rclass == "vector")
            rclass <- "tibble"
        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "ba_genomemaps_data_range")
        return(out)
    })
}