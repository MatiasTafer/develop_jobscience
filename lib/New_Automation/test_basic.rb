require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

class TestBasic < Test::Unit::TestCase
 
 # Starting browser before each test
def setup
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120
    case $browserName
        when "firefox"
            $browser = Selenium::WebDriver.for(:firefox, :http_client => client)
        when "chrome"
            $browser = Selenium::WebDriver.for(:chrome, :http_client => client)
        when "safari"
            $browser = Selenium::WebDriver.for(:safari, :http_client => client)
        when "IE"
            $browser = Selenium::WebDriver.for(:internet_explorer, :http_client => client)
        else
            puts "ERROR: Wrong browser name!!"
    end

    $browser.get "https://login.salesforce.com/"  
    $wait = Selenium::WebDriver::Wait.new(:timeout => 30)
end
 
# Closing browser after each test 
def teardown
    $browser.close
end

end