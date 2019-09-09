#' Set the Chromium chrome.exe path for Node.js
#' 
#' @param path The path to Chromium chrome.exe
#' @export
set_chrome_path <- function(path){
  fpath = system.file("nodejs", "scrape.js", 
                     package = "LinkedInJobsScrapeR")
  xfun::gsub_file(fpath, "executablePath: '.*'", 
                  paste0("executablePath: '", path, "'"))
}