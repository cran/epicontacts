% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colors.R
\name{transp}
\alias{transp}
\alias{edges_pal}
\alias{cases_pal}
\alias{spectral}
\alias{fac2col}
\title{Color tools and palettes for epicontacts}
\usage{
transp(col, alpha = 0.5)

edges_pal(n)

cases_pal(n)

spectral(n)

fac2col(x, pal = cases_pal, NA_col = "lightgrey", legend = FALSE)
}
\arguments{
\item{col}{A color vector to which transparency should be added.}

\item{alpha}{The threshold to be used for transparency: 0 for full
transparency, and 1 for full opacity.}

\item{n}{An integer indicating the number of colors.}

\item{x}{A character or a factor to be converted to colors.}

\item{pal}{A color palette.}

\item{NA_col}{The color to be used for NA values.}

\item{legend}{A logical indicating if legend info should be added to the
output. If TRUE, the output will be a list, with colors in the
\code{$color} component.}
}
\description{
These functions are used for defining palettes or colors in the
\code{epicontacts} package. They include:
}
\details{
\itemize{

\item \code{cases_pal}: discrete color palette used for cases (comes from the
\code{dibbler} package)

\item \code{spectral}: continuous color palette (comes from the
\code{adegenet} package)

\item \code{transp}: makes colors transparent (comes from the
\code{adegenet} package)

\item \code{fac2col}: translates a character or a factor to a color using a
palette (comes from the \code{adegenet} package)

}
}
\examples{

barplot(1:5, col = cases_pal(5))
barplot(1:50, col = cases_pal(50))

}
\author{
Thibaut Jombart \email{thibautjombart@gmail.com}
}
