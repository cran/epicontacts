
#' Subset clusters from epicontacts object by cluster size
#'
#' This function subsets an \code{\link{epicontacts}} object based on defined
#' size(s) of clusters (clusters being groups of connected
#' individuals/nodes). Subsetting may be done by specifying a particular cluster
#' size of interest, minimum cluster size, maximum cluster size, or a range
#' (minimum and maximum) of cluster sizes.
#'
#' @export
#'
#' @author Nistara Randhawa (\email{nrandhawa@@ucdavis.edu})
#'
#' @param x an \code{\link{epicontacts}} object
#'
#' @param cs cluster size to be used for subsetting
#'
#' @param cs_min minimum cluster size for subsetting
#'
#' @param cs_max maximum cluster size for subsetting
#'
#' @return An \code{\link{epicontacts}} object whose contact dataframe corresponds to
#' all clusters of specified cluster sizes.
#'
#' @examples
#' if (require(outbreaks)) {
#' ## build data
#' x <- make_epicontacts(ebola_sim$linelist, ebola_sim$contacts,
#'                        id="case_id", to="case_id", from="infector",
#'                        directed=TRUE)
#'
#'
#' ## subset based on cluster size range
#' x_subset <- subset_clusters_by_size(x, cs_min = 12, cs_max = 15)
#'
#'
#' ## subset based on single cluster size
#' x_subset <- subset_clusters_by_size(x, cs = 12)
#'
#'
#' ## subset based on minimum cluster size
#' x_subset <- subset_clusters_by_size(x, cs_min = 10)
#'
#'
#' ## subset based on maximum cluster size
#' x_subset <- subset_clusters_by_size(x, cs_max = 9)
#' }

subset_clusters_by_size <- function(x, cs = NULL, cs_min = NULL, cs_max = NULL){

    ## Halt if no cluster value is specified
    if(is.null(cs) & is.null(cs_min) & is.null(cs_max)) {
        stop("You must enter either cs, cs_min, or cs_max")
    }

    net <- as.igraph.epicontacts(x)
    clusters <- igraph::clusters(net)


    ## If all 3 (cs, cs_min, and cs_max) are specified
    if(!is.null(cs) & !is.null(cs_min) & !is.null(cs_max)) {
        message("Using cs_min and cs_max to subset data")
    }


    ## If only cs is specified
    if(!is.null(cs) & is.null(cs_min) & is.null(cs_max)) {
        cs_min = cs
        cs_max = cs
    }


    ## If only cs_min is specified
    if(!is.null(cs_min) & is.null(cs_max)) {
        cs_max = max(clusters$csize)
    }


    ## If only cs_max is specified
    if(is.null(cs_min) & !is.null(cs_max)) {
        cs_min = min(clusters$csize)
    }

    csize <- seq(from = cs_min, to = cs_max, by = 1)

    ## nodes$cs_member is clusters$membership and is the cluster each individual node is part of
    ## cluster_csize is the size of the node, and from clusters 1:whatever

    nodes <- data.frame(nodes =igraph::V(net)$id,
                        cs_member = clusters$membership,
                        stringsAsFactors = FALSE)
    cluster_to_subset <- which(clusters$csize %in% csize)
    nodes_to_subset <- nodes$nodes[ which(nodes$cs_member %in% cluster_to_subset)]
    graph_subset <- igraph::induced_subgraph(net,
                                             igraph::V(net)$id %in% nodes_to_subset)

    epi_subset <- x[i=nodes_to_subset,j=nodes_to_subset]
    return(epi_subset)
}


