require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

class ExampleTestCase < Test::Unit::TestCase
 
# Starting browser before each test
def setup
    
    case $browserName
        when "firefox"
            @browser = Selenium::WebDriver.for :firefox
        when "chrome"
            @browser = Selenium::WebDriver.for :chrome
        when "safari"
            @browser = Selenium::WebDriver.for :safari
        when "IE"
            @browser = Selenium::WebDriver.for :internet_explorer
        else
            puts "ERROR: Wrong browser name!!"
    end

    @browser.get "https://qa.zola.com"
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15)
end
 
# Closing browser after each test 
def teardown
    @browser.quit
end
 
# Check that login link is there
def login_link_existence
    assert @wait.until {
        @browser.find_element(:id, "loginLink").displayed?
    }
end
 
# Checking the modal appears 
def test_login_ok
    @browser.find_element(:id, "loginLink").click
   
    assert @wait.until {
        @browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").displayed?
    }
end
 
end