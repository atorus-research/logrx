% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get.R
\name{get_used_functions}
\alias{get_used_functions}
\title{Get functions used within a file}
\usage{
get_used_functions(file)
}
\arguments{
\item{file}{File path of file to run}
}
\value{
tibble with \code{library} and \code{function_name}
}
\description{
Get functions used within a file
}
\examples{
\dontrun{
file <- "ex1.R"
get_functions_used(file)
}
}
