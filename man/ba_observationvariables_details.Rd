% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ba_observationvariables_details.R
\name{ba_observationvariables_details}
\alias{ba_observationvariables_details}
\title{ba_observationvariables_details}
\usage{
ba_observationvariables_details(con = NULL, observationVariableDbId = "",
  rclass = "tibble")
}
\arguments{
\item{con}{list; brapi connection object}

\item{observationVariableDbId}{character; default ''; from test server.}

\item{rclass}{character; default: tibble}
}
\value{
rclass as defined
}
\description{
lists brapi_variables_details available on a brapi server
}
\examples{
if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_observationvariables_details(con)

}
}
\references{
\href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableDetails.md}{github}
}
\seealso{
Other observationvariables: \code{\link{ba_observationvariables_datatypes}},
  \code{\link{ba_observationvariables_ontologies}},
  \code{\link{ba_observationvariables}}

Other brapicore: \code{\link{ba_calls}},
  \code{\link{ba_commoncropnames}}, \code{\link{ba_crops}},
  \code{\link{ba_germplasm_details_study}},
  \code{\link{ba_germplasm_details}},
  \code{\link{ba_germplasm_pedigree}},
  \code{\link{ba_germplasm_progeny}},
  \code{\link{ba_germplasm_search}},
  \code{\link{ba_observationvariables_datatypes}},
  \code{\link{ba_observationvariables_ontologies}},
  \code{\link{ba_observationvariables_search}},
  \code{\link{ba_observationvariables}},
  \code{\link{ba_phenotypes_search}},
  \code{\link{ba_programs_search}},
  \code{\link{ba_programs}},
  \code{\link{ba_traits_details}}, \code{\link{ba_traits}}
}
\author{
Reinhard Simon
}
