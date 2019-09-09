#' Start a scraping job
#' 
#' This is the master scraping function. It will call \code{scrape()} to invoke
#' NodeJS puppeteer for scraping, and then move the files to the appropriate
#' directory structure.
#' 
#' Note that this function expects the data.frames defined in jobs_to_scrape.R to be initialized (job_titles, experience_levels, locations, job_titles_abbv, and locations_abbv).
#' 
#' @param job_titles_index The index of the job gtitle to search for from the job_titles data.frame (e.g., job_titles <- c('data scientist', 'data analyst', 'data engineer'))
#' @param experience_level_index The index of the experience level to search for from the experience_levels data.frame (e.g., experience_levels <- c(1, 2, 3))
#' @param locations_index  The index of the experience level to search for from the locations data.frame (e.g., locations <- c(locations <- c('New York City Metropolitan Area', 'Greater Toronto Area Metropolitan Area'))
#' @export
scrape_job <- function(job_titles_index, 
                       experience_level_index, 
                       locations_index,
                       sort = 'R'){
  
  # Create the data and temp directories
  dir.create('data/', showWarnings = FALSE)
  dir.create('data/temp/', showWarnings = FALSE)
  
  a = job_titles_index
  b = experience_level_index
  c = locations_index
  
  node_scrape(
    job_title = job_titles[a], 
    experience_level = experience_levels[b],
    location = locations[[c]][1],
    sort = sort
  )
  
  # Get a list of files from the temp dir
  files <- list.files("data/temp", full.names = TRUE, recursive = TRUE)
  
  # Move each file to the appropriate directory
  #   create the directory structure if it doesn't exist
  for(k in 1:length(files)) {
    
    create_dir_structure(a, b, c)
    
    job_title_no_space <- gsub("\\s", "", job_titles[a])
    
    # Copy file
    file.copy(files[k], paste0('data/',
                               job_title_no_space, '/',
                               experience_levels[b], '/',
                               locations[[c]][2]))
    # Delete file from temp
    file.remove(files[k])
  }
  
}


#' Call NodeJS to scrape a LinkedIn search result
#' 
#' When scraping, it saves html files for each job ad to the data/temp directory
#' 
#' @param job_title The title of the job to search for (e.g., 'data scientist')
#' @param experience_level The experience level to search for jobs (e.g., '1' corresponds to entry level jobs, '2' to Associate, '3' to Mid-senior, etc...)
#' @param location The name of the location to search in (e.g., 'New York City Metropolitan Area')
#' @export
node_scrape <- function(job_title, 
                        experience_level,
                        location,
                        sort = 'R'){
  
  base_url <- paste0(
    'https://www.linkedin.com/jobs/search/?f_E=', 
    experience_level,
    '&keywords=',
    utils::URLencode(job_title),
    '&location=',
    utils::URLencode(location),
    '&sortBy',
    sort
  )
  
  # Write the URL to the Node.js file
  path = system.file("nodejs", "scrape.js", 
                     package = "LinkedInJobsScrapeR")
  xfun::gsub_file(path, 'var url = ".*"', 
                  paste0('var url = "', base_url, '"'))
  
  system(paste0("node ", system.file("nodejs", "scrape.js", package = "LinkedInJobsScrapeR")))
}


#' Create a directory structure when saving the files
#' 
#'   The structure is:
#'   data/
#'   └── job title/
#'       └── experience level/
#'           └── location/
#'               └── file
#' 
#' @param a The job title index
#' @param b The experience level index
#' @param c The location index
#' @export
create_dir_structure <- function(a, b, c){
  
  job_title_no_space <- gsub("\\s", "", job_titles[a])
  
  dir.create(file.path(paste0('data/',
                              job_title_no_space)), showWarnings = FALSE)
  
  dir.create(file.path(paste0('data/',
                              job_title_no_space, '/',
                              experience_levels[b])), showWarnings = FALSE)
  
  dir.create(file.path(paste0('data/',
                              job_title_no_space, '/',
                              experience_levels[b], '/',
                              locations[[c]][2])), showWarnings = FALSE)

}