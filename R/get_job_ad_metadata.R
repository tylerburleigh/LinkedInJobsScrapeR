#' Get the metadata for a page of LinkedIn job ad search results
#' 
#' It takes a page of search results and then for each job ad listed, it extracts the job ad description, and the criteria for the job ad.
#' 
#' @param files A vector of files with full system paths
#' @param i The index of the file in the list of files to extract information from. Defaults to 1. Because the scraped files have a lot of redundant information, the job ad metadata can be extracted from any one of the files. So this parameter usually doesn't need to be provided
#' @return A data.frame containing the job_id, company, and URL link for all of the ads listed on the search page that was scraped.
#' @export
get_job_ad_metadata <- function(files, i = 1) {
  
  webpage <- xml2::read_html(files[i])
  
  # Job ids
  ids <- rvest::html_nodes(webpage, '.job-result-card.result-card--with-hover-state') %>% 
    extract_attrs(.)
  
  # Links to job ads
  links <- rvest::html_nodes(webpage, '.result-card__full-card-link') %>%
    extract_attrs() %>%
    utils::head(nrow(ids))
  
  # Job titles
  titles <- rvest::html_nodes(webpage, '.result-card__full-card-link > .screen-reader-text') %>% 
    extract_content() %>%
    utils::head(nrow(ids))
  
  # Companies
  companies <- rvest::html_nodes(webpage, '.job-result-card--company') %>%
    extract_attrs() %>%
    utils::head(nrow(ids))
  
  # Locations
  locations <- rvest::html_nodes(webpage, '.job-result-card__location') %>%
    extract_content() %>%
    utils::head(nrow(ids))
  
  jobs <- ids %>%
    dplyr::bind_cols(links,
                     companies,
                     data.frame(title = titles),
                     data.frame(location = locations)) %>%
    dplyr::mutate(job_id = data.id,
                   company = alt,
                   link = href) %>%
    dplyr::select(job_id, location, title, company, link)
  
  # Remove all of the URL parameters in the links we just fetched
  jobs$link <- gsub("\\?.*", "", jobs$link)
  
  return(jobs)
}