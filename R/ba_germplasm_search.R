#' ba_germplasm_search
#'
#' Lists germplasmm as result of a search.
#'
#' @param con brapi connection object
#' @param germplasmDbId character default ''
#' @param germplasmName character default: ''
#' @param germplasmPUI character default: ''
#' @param pageSize integer default: 0
#' @param page integer default: 10
#' @param rclass character; default: tibble
#' @param method string; default 'GET'; alternative 'POST'
#'
#' @author Reinhard Simon
#' @example inst/examples/ex-ba_germplasm_search.R
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Germplasm/GermplasmSearchGET.md}{github}
#' @return tibble
#' @family brapicore
#' @family genotyping
#' @family germplasm
#' @export
ba_germplasm_search <- function(con = NULL,
                                germplasmDbId = "",
                                germplasmName = "",
                                germplasmPUI = "",
                                page = 0,
                                pageSize = 10,
                                method = "GET",
                                rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "germplasm-search")
  stopifnot(is.character(germplasmDbId))
  stopifnot(is.character(germplasmName))
  stopifnot(is.character(germplasmPUI))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate the brapi call url
  if (is.numeric(page) & is.numeric(pageSize)) {
    germplasm_search <- paste0(brp, "germplasm-search/?page=", page,
                               "&pageSize=", pageSize)
  }
  if (germplasmName != "none") {
    germplasm_search <- paste0(germplasm_search, "&germplasmName=",
                               germplasmName)
  }

  if (germplasmPUI != "none") {
    germplasm_search <- paste0(brp, "germplasm-search/?germplasmPUI=",
                               germplasmPUI)
  }

  get_data <- function(res2, typ = '1' )  {
    out <- dat2tbl(res = res2, rclass = rclass)
    if (rclass == "data.frame") {
      out <- gp2tbl(res2, typ)
    }
    if (rclass == "tibble") {
      out <- gp2tbl(res2, typ) %>% tibble::as_tibble()
    }
    out
  }


  if (method == "POST") {
    body <- list(germplasmDbId = germplasmDbId,
                 germplasmName = germplasmName,
                 germplasmPUI = germplasmPUI,
                 page = page,
                 pageSize = pageSize)
    out <- try({
      germplasm_search <- paste0(brp, "germplasm-search/")
      res <- brapiPOST(url = germplasm_search, body = body, con = con)
      res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
      get_data(res2, '2')
    })
  } else {
    out <- try({
      res <- brapiGET(url = germplasm_search, con = con)
      res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")

      get_data(res2)
      })
  }
  nms <- names(out)
  if (all(stringr::str_detect(nms, "data."))) {
    names(out) <- stringr::str_replace_all(nms, "data.", "")
  }
  class(out) <- c(class(out), "ba_germplasm_search")
  show_metadata(res)
  return(out)
}
