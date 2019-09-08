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

5. Open `inst/nodejs/scrape.js` and change the executable path (line 40) to point it to Chromium's `chrome.exe`

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

This package is useful for understanding job market trends for career planning. For example, you might want to understand what skills are most sought after in the career you're trying to progress in. Maybe you're a data scientist and you want to know which skill to invest in learning next, or how competitive you are.

### Custom job alerts

This package may also be useful for setting up custom job alerts (because let's face it, the LinkedIn alerts kinda suck), by scraping a list sorted by most recent first.

### Generating a bespoke list of jobs

If you're in the market for a job, you could curate your own list of jobs to apply to. Some positions have thousands of job ads -- that can take a lot of work to manually sift through. What if you could do some text mining to filter the jobs that you think are right for you?


## Note

For any given search query, LinkedIn will only return a maximum of 1000 results. As a consequence, if you want more complete job listings data, then you may want to specify more narrow search criteria (e.g., smaller geo-regions). Some users may only need a sample of job ads because they are interested in making inferences about a population of job ads, in which case the 1000 limit may not be a problem.
