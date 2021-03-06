% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/help.R, R/registr.R
\docType{package}
\name{registr}
\alias{registr}
\title{Register Exponential Family Functional Data}
\usage{
registr(
  obj = NULL,
  Y = NULL,
  Kt = 8,
  Kh = 4,
  family = "binomial",
  gradient = TRUE,
  beta = NULL,
  t_min = NULL,
  t_max = NULL,
  row_obj = NULL,
  parametric_warps = FALSE,
  ...
)
}
\arguments{
\item{obj}{Current estimate of FPC object. 
Can be NULL only if Y argument is selected.}

\item{Y}{Dataframe. Should have values id, value, index.}

\item{Kt}{Number of B-spline basis functions used to estimate mean functions. Default is 8.}

\item{Kh}{Number of B-spline basis functions used to estimate warping functions \emph{h}. Default is 4.}

\item{family}{\code{gaussian} or \code{binomial}.}

\item{gradient}{if \code{TRUE}, uses analytic gradient to calculate derivative. 
If \code{FALSE}, calculates gradient numerically.}

\item{beta}{Current estimates for beta for each subject. Default is NULL.}

\item{t_min}{Minimum value to be evaluated on the time domain.
if `NULL`, taken to be minimum observed value.}

\item{t_max}{Maximum value to be evaluated on the time domain. 
if `NULL`, taken to be maximum observed value.}

\item{row_obj}{If NULL, the function cleans the data and calculates row indices. 
Keep this NULL if you are using standalone \code{registr} function.}

\item{parametric_warps}{If FALSE (default), inverse warping functions are 
estimated nonparametrically. If 'beta_cdf', they are assumed to have the form of a 
Beta(a,b) CDF. If 'piecewise' they follow a piecewise parameterized function.}

\item{...}{additional arguments passed to or from other functions}
}
\value{
An object of class \code{fpca} containing:
\item{Y}{The observed data. The variable index is the new estimated time domain.}
\item{loss}{Value of the loss function after registraton.}
\item{beta}{Matrix of B-spline basis coefficients used to construct subject-specific warping functions.}
}
\description{
Software for registering functional data from the exponential family of distributions.

Function used in the registration step of an FPCA-based approach for 
registering exponential-family functional data, called by \code{\link{register_fpca}}. 
This method uses constrained optimization to estimate spline 
coefficients for warping functions, where the objective function for optimization comes from 
maximizing the EF likelihood subject to monotonicity constraints on the warping functions. 
You have to either specify \code{obj}, which is a fpca 
object from an earlier step, or \code{Y}, a dataframe in long format with variables 
\code{id}, \code{index}, and \code{value} to indicate subject IDs, times, and observations, 
respectively.
}
\examples{
Y = simulate_unregistered_curves()
register_step = registr(obj = NULL, Y = Y, Kt = 6, Kh = 3, family = "binomial", 
   gradient = TRUE)
testthat::expect_error({
registr(obj = list(Y = Y), Kt = 6, Kh = 3, family = "binomial", 
   gradient = TRUE)
})
testthat::expect_error({
registr(obj = NULL, Y = Y, Kt = 2, Kh = 3)
})
testthat::expect_error({
registr(obj = NULL, Y = Y, Kt = 6, Kh = 2)
})
\donttest{
Y = simulate_unregistered_curves()
register_step = registr(obj = NULL, Y = Y, Kt = 6, Kh = 3, family = "binomial", 
   gradient = TRUE)
}

}
\author{
Julia Wrobel

Julia Wrobel \email{jw3134@cumc.columbia.edu}
}
