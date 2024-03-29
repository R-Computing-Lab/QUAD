## seeded with content from same in adv-r
## deleted bits that seem irrelevant
## commented out bits that look like they may become relevant



## Standard Libraries
if (!require("tweetrmd"))  devtools::install_github("gadenbuie/tweetrmd")
library(tweetrmd) #... embedding tweets
library(vembedr)  #... embedding youtube videos
library(knitr)
if (!require("gapminder")) install.packages("gapminder")



## Options
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE
  # cache = TRUE,
  # fig.retina = 0.8, # figures are either vectors or 300 dpi diagrams
  # dpi = 300,
  # out.width = "70%",
  # fig.align = 'center',
  # fig.width = 6,
  # fig.asp = 0.618,  # 1 / phi
  # fig.show = "hold"
)

options(
  rlang_trace_top_env = rlang::current_env(),
  rlang__backtrace_on_error = "none"
)

options(
  digits = 3,
  str = strOptions(strict.width = "cut")
)

if (knitr::is_latex_output()) {
  knitr::opts_chunk$set(width = 69)
  options(width = 69)
  options(crayon.enabled = FALSE)
  options(cli.unicode = TRUE)
}

# knitr::knit_hooks$set(
#   small_mar = function(before, options, envir) {
#     if (before) {
#       par(mar = c(4.1, 4.1, 0.5, 0.5))
#     }
#   }
# )


knitr::knit_hooks$set(chunk_envvar = function(before, options, envir) {
  envvar <- options$chunk_envvar
  if (before && !is.null(envvar)) {
    old_envvar <<- Sys.getenv(names(envvar), names = TRUE, unset = NA)
    do.call("Sys.setenv", as.list(envvar))
    #print(str(options))
  } else {
    do.call("Sys.setenv", as.list(old_envvar))
  }
})

check_quietly <- purrr::quietly(devtools::check)
install_quietly <- purrr::quietly(devtools::install)


# functions
shhh_check <- function(..., quiet = TRUE) {
  out <- check_quietly(..., quiet = quiet)
  out$result
}

pretty_install <- function(...) {
  out <- install_quietly(...)
  output <- strsplit(out$output, split = "\n")[[1]]
  output <- grep("^(\\s*|[-|])$", output, value = TRUE, invert = TRUE)
  c(output, out$messages)
}


sample_no_surprises <- function(x) {
  if (length(x) <= 1) {
    return(x)
  } else {
    return(sample(x,1))
  }
}


slide_url=function(df_url,title,slide=NULL){
  var_url=paste0(df_url$link[df_url$title==title],slide)
  return(var_url)
}

