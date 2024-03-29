% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subset_clusters_by_id.R
\name{subset_clusters_by_id}
\alias{subset_clusters_by_id}
\title{Subset epicontacts by case-specified clusters}
\usage{
subset_clusters_by_id(x, id)
}
\arguments{
\item{x}{an \code{\link{epicontacts}} object}

\item{id}{a character vector of case identifiers; the connected components
attached to these cases will be retained in the output object.}
}
\value{
An \code{\link{epicontacts}} object whose contact dataframe
    corresponds to all clusters containing specified case id.
}
\description{
This function subsets an \code{\link{epicontacts}} object by identifying
clusters of cases connected to specified cases.
}
\examples{
if (require(outbreaks)) {
## build data
x <- make_epicontacts(ebola_sim$linelist, ebola_sim$contacts,
                       id="case_id", to="case_id", from="infector",
                       directed=TRUE)


id <- "cac51e" ## it can be a vector of id as well


## subset based on cluster to which "cac51e" belongs
x_subset <- subset_clusters_by_id(x, id)

}
}
\author{
Nistara Randhawa (\email{nrandhawa@ucdavis.edu})
}
