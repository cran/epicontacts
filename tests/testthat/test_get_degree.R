context("Computing number of contacts per case")

test_that("the both argument is working as expected", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist, ebola_sim$contacts,
    id="case_id", to="case_id", from="infector",
    directed=TRUE)

  deg_both <- get_degree(x, "both")
  deg_in <- get_degree(x, "in")
  deg_out <- get_degree(x, "out")

  expect_equal((deg_in+deg_out),deg_both)


  msg <- "x is not an 'epicontacts' object"
  expect_error(get_degree("toto"), msg)

})

test_that("get_degree is producing a named vector that is not null", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist, ebola_sim$contacts,
    id="case_id", to="case_id", from="infector",
    directed=TRUE)

  deg <- get_degree(x)

  expect_gt(length(deg), 0)
  expect_gt(length(names(deg)), 0)

})

test_that("degree computed only in line list is working as expected", {

  skip_on_cran()

  x <- make_epicontacts(ebola_sim$linelist, ebola_sim$contacts,
    id="case_id", to="case_id", from="infector",
    directed=TRUE)

  deg_in_ll <- get_degree(x, "in", only_linelist = T)

  expect_equal(names(deg_in_ll), x$linelist$id)

})
