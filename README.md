## LinkedInJobsScrapeR: Scrape LinkedIn job ads using R and Node.js

**LinkedInJobsScrapeR** is an `R` package for scraping LinkedIn job ads and building a tidy dataset for analysis.

Using this package, you can scrape thousands of job ads specific to job titles, locations, and experience levels that you're interested in. For example, maybe you are interested in seeing Entry-level "data scientist" jobs in the greater New York City and San Francisco areas. You can do that!

Note: For any given search query, LinkedIn will only return 1000 results. As a consequence, if you want more complete job listings data, then you may want to specify more narrow search criteria (e.g., smaller geo-regions). Some users may only need a sample of job ads because they are interested in making inferences about a population of job ads, in which case the 1000 limit may not be a problem.

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
``


