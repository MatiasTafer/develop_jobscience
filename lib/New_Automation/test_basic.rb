require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

class TestBasic < Test::Unit::TestCase
 
# Starting browser before each test
def setup
    
    case $browserName
        when "firefox"
            $browser = Selenium::WebDriver.for :firefox
        when "chrome"
            $browser = Selenium::WebDriver.for :chrome
        when "safari"
            $browser = Selenium::WebDriver.for :safari
        when "IE"
            $browser = Selenium::WebDriver.for :internet_explorer
        else
            puts "ERROR: Wrong browser name!!"
    end

    $browser.get "https://qa.zola.com"
    $wait = Selenium::WebDriver::Wait.new(:timeout => 20)
end
 
# Closing browser after each test 
def teardown
    $browser.quit
end

end