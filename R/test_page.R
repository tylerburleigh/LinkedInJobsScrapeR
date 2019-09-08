#' View a scraped page in the browser
#' 
#' This can be useful for debugging the output of a scrape job
#' 
#' @param html The HTML to render
#' @export
test_page <- function(html){
  xml2::write_xml(html, file="temp.html")
  utils::browseURL("temp.html")
  file.remove("temp.html")
}