## LinkedInJobsScrapeR: Scrape LinkedIn job ads using R and Node.js

**LinkedInJobsScrapeR** is an `R` package for scraping LinkedIn job ads and building a tidy dataset for analysis.

Using this package, you can scrape thousands of job ads specific to job titles, locations, and experience levels that you're interested in. For example, maybe you are interested in seeing Entry-level "data scientist" jobs in the greater New York City and San Francisco areas.

## Installation

1. Install `Node.js` ([download page](https://nodejs.org/en/download))

2. Install `puppeteer` for Node.js

Open a system terminal and run

```
npm install puppeteer puppeteer-extra puppeteer-extra-plugin-stealth
```

3. Install `LinkedInJobsScrapeR` with vignettes

```
devtools::install_github("tylerburleigh/LinkedInJobsScrapeR", build_vignettes = TRUE)
```

4. Download and unzip Chromium ([download page](https://download-chromium.appspot.com/))

5. Open `scrape.js`, located at the path given by `system.file("nodejs", "scrape.js", package = "LinkedInJobsScrapeR")` and change the executable path (line 40) to point it to Chromium's `chrome.exe`

## Usage

`LinkedInJobsScrapeR` is used in two stages: 

1. Scraping job listings
2. Extracting data and creating a tidy dataset

See the vignettes for these topics:

```
utils::vignette("scraping")
utils::vignette("extracting")
```

## Use cases

### Job market trend analysis

This package is useful for understanding job market trends for career planning. For example, you might want to understand what skills are most sought after in the career you're trying to progress in. Maybe you're a data scientist and you want to know which skill to invest in learning next, or how competitive you are, or if you're over/under-qualified for a type of position.

### Automating the job search

Some positions have thousands of job ads. That can take a lot of work to manually sift through if you have to read each one! If you're in the market for a job, you could scrape job listings, and then run your own filters to curate a list of jobs that seem like a good fit, potentially saving yourself a lot of time and effort.

### Custom job alerts

Let's face it, the LinkedIn job alerts kinda suck. This package could be used to set up custom job alerts. You could write a script that runs on a regular basis to scrape jobs (sorting by most recent first) with custom filters and criteria, and alert yourself if that dream position opens up.


## Note

For any given search query, LinkedIn will only return a maximum of 1000 results. As a consequence, if you want more complete job listings data, then you may want to specify more narrow search criteria (e.g., smaller geo-regions). Some users may only need a sample of job ads because they are interested in making inferences about a population of job ads, in which case the 1000 limit may not be a problem.
