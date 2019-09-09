// We use puppeteer extra for some browser stealth features
const puppeteer = require('puppeteer-extra');
const fs = require("fs");

// add stealth plugin and use defaults (all evasion techniques)
const pluginStealth = require("puppeteer-extra-plugin-stealth")
puppeteer.use(pluginStealth())

// R writes the URL here -- DON'T TOUCH
var url = "x"

// Delay the async by so many milliseconds
function delay(timeout) {
  return new Promise((resolve) => {
    setTimeout(resolve, timeout);
  });
}

// Let the scraping begin!
(async () => { 

	// Puppeteer arguments
	const args = [
		'--no-sandbox',
		'--disable-setuid-sandbox',
		'--disable-infobars',
		'--window-position=0,0',
		'--ignore-certifcate-errors',
		'--ignore-certifcate-errors-spki-list'
	];
	
	// add stealth plugin and use defaults (all evasion techniques)
	const pluginStealth = require("puppeteer-extra-plugin-stealth")
	puppeteer.use(pluginStealth())

	const browser = await puppeteer.launch({
		executablePath: 'C:/Users/tyler/Documents/R/win-library/3.6/LinkedInJobsScrapeR/nodejs/scrape.js',  
		args: args,
		ignoreHTTPSErrors: true,
		headless: false
	});

	const page = await browser.newPage();
	await page.goto(url);

	console.log("Loading ads");
	// Pause for initial loading
	await delay(3000);

	// How many ads are there
	const el = await page.$(".results-context-header__job-count");
	const job_ad_count = await page.evaluate(el => el.textContent, el);

	console.log(parseInt(job_ad_count.replace(/\D/g,'')) + " ads");
	// In some rare cases more than 1000 results are returned
	// for consistency's sake let's force a 40-click limit
	console.log(Math.ceil(parseInt(job_ad_count.replace(/\D/g,'')) / 25) < 40 ? Math.ceil(parseInt(job_ad_count.replace(/\D/g,'')) / 25) : 40 + " clicks needed");

	// Press "see more jobs" button until all are loaded  
	// each page has 25 results, so we divide the total ads by 25 to get the
	// number of times we need to click "see more"
	for(let i = 1; i < (Math.ceil(parseInt(job_ad_count.replace(/\D/g,'')) / 25) < 40 ? Math.ceil(parseInt(job_ad_count.replace(/\D/g,'')) / 25) : 40); i++){
		console.log(i)
		await page.$eval('.see-more-jobs', el => el.click());
		await delay(1000);
	}

	// Fetch all job ad links
	const ads = await page.$$('.result-card__full-card-link');  
	console.log(ads.length + " ads links found");

	// Save the first ad data to a file
	let bodyHTML = await page.evaluate(() => document.body.innerHTML);
	fs.writeFile("data/temp/ad_1.txt", bodyHTML, (err) => {
	if (err) console.log(err);
	});
	console.log("\nScrape ad #" + 1);

	// For each ad, click the ad, then write the page contents to a file
	// some delays are used here to account for loading times
	for(let i = 1; i < ads.length; i++){
	  
	  await delay(500);
	  try {
		  console.log("\nClick ad #" + (parseInt(i)+1));
		  await ads[i].click();		
		  await delay(2500); 
		  // Save the page data to a file
		  let bodyHTML = await page.evaluate(() => document.body.innerHTML);
		  fs.writeFile("data/temp/ad_" + (parseInt(i)+1) + ".txt", bodyHTML, (err) => {
			if (err) console.log(err);
		  });	
		  console.log("Scrape ad #" + (parseInt(i)+1));
	  } catch(e) {
		// The click action will sometimes fail at the end -- that's OK, it still seems
		//	to get a complete set of data
		console.log('Error when trying to click ' + ads[i] + " " + e);
	  }
	}
 
	await browser.close();
})();
