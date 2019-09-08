#' A helper function to extract attributes
#' @param i Input to the function
#' @export
extract_attrs <- function(i) {
  dplyr::bind_rows(lapply(xml2::xml_attrs(i), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))
}

#' A helper function to extract content
#' @param i Input to the function
#' @param na.omit A boolean that specifies whether to remove NAs in the return
#' @export
extract_content <- function(i, na.omit = T){
  as.character(xml2::xml_contents(i)) -> obj
  if(na.omit){
    obj[!is.na(obj)]
  } else {
    obj
  }
}