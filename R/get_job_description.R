#' Get the job description and job criteria from a scraped job ad file
#' 
#' For each job ad, it will extract the job ad description, and the criteria for
#' the job ad.
#' 
#' @param files A vector of files with full system paths
#' @param i The index of the file in the list of files to extract information from.
#' @return A list containing the description and job criteria
#' @export
get_job_description <- function(files, i) {
  
  description <- data.frame()
  criteria <- data.frame()
    
  webpage <- read_html(files[i])
  
  ##
  ## Job id
  id <- rvest::html_nodes(webpage, '#decoratedJobPostingId') %>% 
    extract_content() %>% 
    gsub("<!--\"", "", .) %>% 
    gsub("\"-->", "", .)
  
  ##
  # Job description
  d <- rvest::html_nodes(webpage, '.description__text') %>%
    paste0(., collapse = " ") %>%
    gsub("<.*?>", "", .)
  description <- rbind(description, data.frame(job_id = id, description = d))
  
  ##
  # Job criteria
  c <- rvest::html_nodes(webpage, '.job-criteria__list') %>%
    extract_content(.)
  
  for(k in 1:length(c)){
    name <- xml2::read_html(c[[k]]) %>% 
      rvest::html_nodes(., '.job-criteria__subheader') %>%
      extract_content(.)
    
    content <- xml2::read_html(c[[k]]) %>% 
      rvest::html_nodes(., '.job-criteria__text--criteria') %>%
      extract_content(.) %>%
      paste0(., collapse=", ")
    
    criteria <- rbind(criteria, data.frame(
      job_id = id,
      name = name,
      content = content
    ))
  }
  
  return(list(description = description, criteria = criteria))
  
}