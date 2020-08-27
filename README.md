# covidscraper

John Hopkins University publishes everyday current and historic information about COVID-19 development int the world.
The following project is an excersice of a scrapper that will retrieve statistical information from their website.

## Built With
​
Ruby 2.6.5
Google Chrome 84 
Chromedriver 84

## Requirements

### The following Gems are required
- nokogiri 1.10.10
- watir 6.17.0
- open-uri
- awesome_print 1.8.0
- pry 0.13.1

The can are included in a Gemfile and are to be installed with Bundler.

`bundle install` 

### Testing was performe Rspec 3.9

### Chromedriver 
Chrome driver is required by Watir to fetch web pages.
Follow instruction from: `https://chromedriver.chromium.org/`
\Quick tip: 
After downloading the corresponding version for your Chrome browser, unpack the file and copy it to a location in your path or add the desired location to it.

## Getting Started

​To get a local copy up and running follow these simple example steps.​ 
`git clone https://github.com/gdumani/covidscaper`

## Commands
In the bin directory 

`ruby covidscraper.rb`

## Intructions

The program has to main functions for which corresponig objects exit:
 ### rgn 
 It retrieves the link of a location. When the program starts it will fetch all the regions and their available links and classify it it two groups, `us` and `world`. Each group is stored in standard Hash format `{ country => link , country => link ...}` and accepts normal ruby Hash commands. Additionaly `country` and `state` methods are provided to retrive single entries from 'world' an 'us' respectively. Examples:
  - `rgn.us` => all US links .
  - `rgn.world` => all WORLD links.
  - `rgn.country 'Ireland'` => hash with link to for Ireland.
  - `rgn.state 'Colorado'` => hash with link to for US state Colorado.
  
### scrap
It uses a browser instance created by Watir to retrieve the information for a given `{ location => link, location => link ...}` hash. the information is stored in hash format. `extract` with a hash argument triggers the brower to to fetch the information and stores it in `result` for futher analisys. This approach was used to let the browser do de processing of data retrieving scripts in the website. It also scans all historical information by instructing the browser to click the specific text. Examples:
  - `scrap.extract rgn.world`
  - `scrap.extract rgn.us`
  - `scrap.extract rgn.country "Canada"`
  - `scrap.extract rgn.state "Ohio"`
  - `scrap.result`
  - `scrap.result[ location-key ]` location-key can be a state or country depending on data in `result`
  Because `result` is a multilevel hash it can be digged down using hash-keys and tools.
  AwesomePrint is integrated to facilitate data presentation. Example
   - `ap scrap.result`

## Screenshot

![screenshot](/images/covscraper-intro.png)
![screenshot](/images/us-links.png)
![screenshot](/images/region-data.png)
![screenshot](/images/us-state.png)
![screenshot](/images/state-web.png)
![screenshot](/images/world-country.png)
![screenshot](/images/country-web.png)

## Instructions to test with Rspec

Go to the directory where TicTacToe is installed according to the getting started previous instructions and install Rspec. 

- To install rspec run: `gem install rspec`

- To run curren tests just type: `rspec` 

New test can be added in ./spec/main_spec.rb file following the Rspec guidelines.

## Program Files

  /bin/covscraper.rb   :main program
  /lib/regions_hash.rb :RegionJhu class that fetches link
  /lib/scrap.rb        :ScrapJhu class that uses browser to retrieve data
  /lib/modules.rb      :filter module to remove html tags from strings

## Future improvements

- add a menu-driven user interface
- replace Watir for another HTML tool that queries data directly whithout the requirement of a full Web browser like Chrome. As an excercise it done the job of letting Chrome deal with active code. It is extremly useful for testing WWW aplications and simulate user interacitons. In this scenario it uses high amount of resources and has a big performance toll.

## Authors

👤 **Giancarlo Dumani**

- Github: [gdumani](https://github.com/gdumani)
- Twitter: [@gdumani1](https://twitter.com/gdumani1)
- Linkedin: [Giancarlo-Dumani](https://www.linkedin.com/in/giancarlo-dumani-a7364a1a1/?originalSubdomain=cr)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

​- This project was part of Microverse's curriculum in Ruby learning program.
- Special thanks to John Hopkins University for keeping such an amazing compilation of statistics up to date and making it available to us

## 📝 License

​This project has MIT license.
