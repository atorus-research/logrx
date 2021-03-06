#' Build approved packages and functions tibble
#'
#' A utility function to help you build your approve package and functions list.
#' This can be used by logrx to log unapproved use of packages and functions.
#'
#' For more details see the help vignette:
#'
#' \code{vignette("approved", package = "logrx")}
#'
#' @param pkg_list A named list of character vectors where the name is the
#' package name with a character vector of approved functions or 'All'
#' @param file Name of file where the approved tibble will be read to.
#' If not specified, the tibble is returned.
#'
#' Default: NULL
#'
#' Permitted Files: .RDS
#'
#' @return A tibble with two columns (library, function) and one row per function
#' @importFrom purrr map2_dfr
#' @export
#'
#' @examples
#' approved_pkgs <- list(
#'   base = c("library", "mean"),
#'   dplyr = "All"
#' )
#'
#' # build and return
#' build_approved(approved_pkgs)
#'
#' # build and save
#' dir <- tempdir()
#' build_approved(approved_pkgs, file.path(dir, "approved.rds"))
build_approved <- function(pkg_list, file = NULL) {
  approved <- purrr::map2_dfr(
    names(pkg_list),
    pkg_list,
    ~ {
      all <- tibble::tibble(
        function_name = getNamespaceExports(.x),
        library = paste0("package:", .x)
      )

      if (.y[1] %in% c("All", "all")) {
        all
      } else {
        all[all$function_name %in% .y, ]
      }
    }
  )

  if (is.null(file)) {
    approved
  } else {
    saveRDS(approved, file)
  }
}
