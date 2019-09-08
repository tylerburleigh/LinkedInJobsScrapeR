# LinkedInJobsScrapeR: Scrape LinkedIn job ads using R and Node.js

**LinkedInJobsScrapeR** is an `R` package that you can use to scrape LinkedIn job ads and build a tidy dataset for analysis. It uses `Node.js` in addition to `R`.

# Installation

1. Install `Node.js` ([download page](https://nodejs.org/en/download))

2. Install `puppeteer` for Node.js

Open a system terminal and run

```
npm install puppeteer puppeteer-extra puppeteer-extra-plugin-stealth
```

3. Install `LinkedInJobsScrapeR`

```
devtools::install_github("tylerburleigh/LinkedInJobsScrapeR")
```

4. Download and unzip Chromium ([download page](https://download-chromium.appspot.com/))

5. Open `inst/nodejs/scrape.js` and change the executable path so that it points to your Chromium `chrome.exe` (on line 40)

# Usage

## Scraping the data

The `scrape_job()` function is used to invoke a Node.js script that will first open a browser window to a LinkedIn search results page, click on each of the job ads, and save each one to a file. Then a separate function is run that organizes the files into folders that are named according to the job title, experience level, and locations given.

The following directory structure is used for saving the scraped files.

```
data/
└── job title/
	└── experience level/
		└── location/
			└── file
```

A recipe for using the package to scrape job ads is given in `inst/scrape_recipe.R`, with job titles, locations, and experience levels for the recipe defined in `inst/scrape_definitions.R`.

```
# Load information about the jobs to scrape
source("inst/scrape_definitions.R")

# For the jobs to scrape, loop through all of the...
#   i = locations
#   k = experience levels
#   j = job titles
for(i in 1:length(locations)){
  for(k in 1:length(experience_levels)){
    for (j in 2:length(locations)){
      
      # Check if files exist in the directory
      #   and skip if they do
      files <- list.files(paste0('data/',
                                job_titles_abbv[j], '/',
                                experience_levels[k], '/',
                                locations_abbv[i]))
      if(length(files) > 0) next
      
      scrape_job(locations_index = i,
                       experience_level_index = k,
                       job_titles_index = j)  
    }
  }
}
```

This will scrape and save all of the files to the `data/` folder.

## Building a tidy dataset from the scraped files



