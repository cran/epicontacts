context("Retrieving clusters from linelist with get_clusters")

test_that("igraph functions perform as expected", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist,
                        ebola_sim$contacts,
                        id = "case_id",
                        to = "case_id",
                        from = "infector",
                        directed=TRUE)

  net <- as.igraph.epicontacts(x)

  expect_is(net, "igraph")

})






test_that("construction of net nodes works", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist,
                        ebola_sim$contacts,
                        id = "case_id",
                        to = "case_id",
                        from = "infector",
                        directed = TRUE)

  net <- as.igraph.epicontacts(x)
  cs <- igraph::clusters(net)
  cs_size <- data.frame(cluster_member = seq_along(cs$csize),
    cluster_size = cs$csize)

  net_nodes <- data.frame(id =igraph::V(net)$id,
    cluster_member = cs$membership,
    stringsAsFactors = FALSE)

  net_nodes <- dplyr::left_join(net_nodes, cs_size, by = "cluster_member")

  expect_named(net_nodes,
               c("id", "cluster_member","cluster_size"),
               ignore.order = TRUE)

})






test_that("get_clusters returns epicontacts object", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist,
                        ebola_sim$contacts,
                        id = "case_id",
                        to = "case_id",
                        from = "infector",
                        directed = TRUE)

  y <- get_clusters(x)

  expect_is(y, "epicontacts")
})






test_that("get_clusters returns data.frame", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist,
                        ebola_sim$contacts,
                        id = "case_id",
                        to = "case_id",
                        from = "infector",
                        directed = TRUE)

  y <- get_clusters(x, output = "data.frame")

  expect_is(y, "data.frame")

})


test_that("get_clusters errors as expected", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist,
                        ebola_sim$contacts,
                        id = "case_id",
                        to = "case_id",
                        from = "infector",
                        directed = TRUE)

  # add bogus cluster info
  x$linelist$cluster_member <- sample(LETTERS, nrow(x$linelist), replace = TRUE)

  msg <- "'cluster_member' is already in the linelist. Set 'override = TRUE' to write over it, else assign a different member_col name."
  expect_error(get_clusters(x), msg)

  # more bogus cluster info
  x$linelist$cluster_size <- 1:nrow(x$linelist)

  msg <- "'cluster_member' and 'cluster_size' are already in the linelist. Set 'override = TRUE' to write over them, else assign different cluster column names."
  expect_error(get_clusters(x), msg)

})

test_that("get_clusters override behavior works", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist,
                        ebola_sim$contacts,
                        id = "case_id",
                        to = "case_id",
                        from = "infector",
                        directed = TRUE)

  foo <- get_clusters(x)

  x$linelist$cluster_member <- sample(LETTERS, nrow(x$linelist), replace = TRUE)
  x$linelist$cluster_size <- 1:nrow(x$linelist)

  bar <- get_clusters(x, override = T)

  expect_equal(foo, bar)

})



test_that("get_clusters works on different classes", {

  skip_on_cran()

  ## igraph returned cluster information with case ids coerced to character,
  ## causing errors when this information was merged with integer case ids in
  ## the linelist. the fix coerces cluster case id to the same class as the
  ## linelist case ids.
  
  ## all integer
  ll <- data.frame(1:100)
  co <- data.frame(from = sample.int(100, 50, TRUE),
                   to = sample.int(100, 50, TRUE))
  epic_int <- make_epicontacts(ll, co)
  expect_error(get_clusters(epic_int), NA)

  ## integer + factor
  ll <- data.frame(1:100)
  co <- data.frame(from = as.character(sample(100, 50, TRUE)),
                   to = as.character(sample(100, 50, TRUE)))
  epic_int <- make_epicontacts(ll, co)
  expect_error(get_clusters(epic_int), NA)

  ## factor + integer
  ll <- data.frame(as.character(1:100))
  co <- data.frame(from = sample.int(100, 50, TRUE),
                   to = sample.int(100, 50, TRUE))
  epic_int <- make_epicontacts(ll, co)
  expect_error(get_clusters(epic_int), NA)

  ## integer + character
  ll <- data.frame(1:100)
  co <- data.frame(from = as.character(sample(100, 50, TRUE)),
                   to = as.character(sample(100, 50, TRUE)),
                   stringsAsFactors = FALSE)
  epic_int <- make_epicontacts(ll, co)
  expect_error(get_clusters(epic_int), NA)

  ## character + integer
  ll <- data.frame(as.character(1:100),
                   stringsAsFactors = FALSE)
  co <- data.frame(from = sample.int(100, 50, TRUE),
                   to = sample.int(100, 50, TRUE))
  epic_int <- make_epicontacts(ll, co)
  expect_error(get_clusters(epic_int), NA)
  
})
