% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ba_studies_search_post.R
\name{ba_studies_search_post}
\alias{ba_studies_search_post}
\title{ba_studies_search_post}
\usage{
ba_studies_search_post(con = NULL, studyDbIds = "", trialDbIds = "",
  programDbIds = "", locationDbIds = "", seasonDbId = "",
  studyType = "", studyNames = "", studyLocations = "",
  programNames = "", commonCropName = "", germplasmDbIds = "",
  observationVariableDbIds = "", active = "", sortBy = "",
  sortOrder = "", page = 0, pageSize = 1000, rclass = "tibble")
}
\arguments{
\item{con}{brapi connection object}

\item{studyDbIds}{character; default: ''}

\item{trialDbIds}{character; default: ''}

\item{programDbIds}{character; default: ''}

\item{locationDbIds}{character; default: ''}

\item{seasonDbId}{character; default: ''}

\item{studyType}{character; default: ''}

\item{studyNames}{character; default: ''}

\item{studyLocations}{character; default: ''}

\item{programNames}{character; default: ''}

\item{commonCropName}{character; default: ''}

\item{germplasmDbIds}{character; default: ''}

\item{observationVariableDbIds}{character; default: ''}

\item{active}{character; default: ''}

\item{sortBy}{character; default: ''}

\item{sortOrder}{character; default: ''}

\item{page}{integer; default: 1000}

\item{pageSize}{integer; default: 0}

\item{rclass}{character; default: tibble}
}
\value{
rclass as defined
}
\description{
Search studies on a brapi server via a GET or POST method
}
\note{
This call must have set a specific identifier. The default is an empty string.
     If not changed to an identifier present in the database this will result in an error.

Tested against: sweetpotatobase

Tested against: sweetpotatobase, test-server

BrAPI Version: 1.0, 1.1, 1.2

BrAPI Status: active
}
\references{
\href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/StudiesSearch_POST.md}{github}
}
\seealso{
Other studies: \code{\link{ba_studies_details}},
  \code{\link{ba_studies_layout}},
  \code{\link{ba_studies_observationlevels}},
  \code{\link{ba_studies_observations}},
  \code{\link{ba_studies_observationunits}},
  \code{\link{ba_studies_observationvariables}},
  \code{\link{ba_studies_search_get}},
  \code{\link{ba_studies_search}},
  \code{\link{ba_studies_seasons}},
  \code{\link{ba_studies_studytypes}},
  \code{\link{ba_studies_table_save}},
  \code{\link{ba_studies_table}}

Other phenotyping: \code{\link{ba_samples_save}},
  \code{\link{ba_samples}},
  \code{\link{ba_studies_details}},
  \code{\link{ba_studies_layout}},
  \code{\link{ba_studies_observationlevels}},
  \code{\link{ba_studies_observations}},
  \code{\link{ba_studies_observationunits_save}},
  \code{\link{ba_studies_observationunits}},
  \code{\link{ba_studies_observationvariables}},
  \code{\link{ba_studies_search_get}},
  \code{\link{ba_studies_search}},
  \code{\link{ba_studies_seasons}},
  \code{\link{ba_studies_studytypes}},
  \code{\link{ba_studies_table_save}},
  \code{\link{ba_studies_table}},
  \code{\link{ba_trials_details}}, \code{\link{ba_trials}}
}
\author{
Reinhard Simon
}