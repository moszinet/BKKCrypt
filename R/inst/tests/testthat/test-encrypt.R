library(BKKCrypt)
library(testthat)

context('encryption works')

test_that('encrypting static text', {
    expect_equal(BKKCrypt('foo'), 'foo')
    expect_equal(BKKCrypt('bar'), 'bar')
})

test_that('encrypting variables', {
    x <- 'foo'
    expect_equal(BKKCrypt(x), 'foo')
})

test_that('vectorized encryption', {
    expect_equal(BKKCrypt(as.character(1:3)), as.character(1:3))
})

test_that('wrong class', {
    expect_error(BKKCrypt(1:3))
})
