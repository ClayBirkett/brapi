% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ba_observationvariables_datatypes.R
\name{ba_observationvariables_datatypes}
\alias{ba_observationvariables_datatypes}
\title{ba_observationvariables_datatypes}
\usage{
ba_observationvariables_datatypes(con = NULL, rclass = "tibble")
}
\arguments{
\item{con}{object; brapi connection object; default = NULL}

\item{rclass}{character; default: tibble}
}
\value{
rclass as defined
}
\description{
lists variables_datatypes available on a brapi server
}
\examples{
if (interactive()) {
  library(brapi)

  con <- ba_db()$testserver

  ba_observationvariables_datatypes(con)

}
}
\references{
\href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableDataTypeList.md}{github}
}
\seealso{
Other observationvariables: \code{\link{ba_observationvariables_details}},
  \code{\link{ba_observationvariables_ontologies}},
  \code{\link{ba_observationvariables}}

Other brapicore: \code{\link{ba_calls}},
  \code{\link{ba_commoncropnames}}, \code{\link{ba_crops}},
  \code{\link{ba_germplasm_details_study}},
  \code{\link{ba_germplasm_details}},
  \code{\link{ba_germplasm_pedigree}},
  \code{\link{ba_germplasm_progeny}},
  \code{\link{ba_germplasm_search}},
  \code{\link{ba_observationvariables_details}},
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
