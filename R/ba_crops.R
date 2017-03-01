#' ba_crops
#'
#' lists crops available in a database
#'
#' @param con brapi connection object
#' @param rclass logical; default is FALSE; whether to display the raw list object or not
#'
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @example inst/examples/ex_crops.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Crops/ListCrops.md}{github}
#' @family brapicore
#' @export
ba_crops <- function(con = NULL, rclass = "tibble") {
    omc <- con$multicrop
    con$multicrop <- FALSE
    ba_check(con, FALSE, "crops")
    crops_list <- paste0(get_brapi(con), "crops")
    rclass <- df2tibble(rclass)

    out <- try({
        res <- brapiGET(crops_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- dat2tbl(res, rclass)
        if (any(c("tbl_df", "data.frame") %in% class(out))) {
            names(out)[1] <- "crops"
        }
        class(out) <- c(class(out), "ba_crops")
        out
    })

    con$multicrop <- omc
    return(out)

}