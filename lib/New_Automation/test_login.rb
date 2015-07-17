require_relative 'test_basic.rb'
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

class TestLogin < TestBasic
    
	# Check that login link is there
	def login_link_existence
    	assert $wait.until {
        	$browser.find_element(:id, "loginLink").displayed?
    	}
	end
 
	# Checking the modal appears 
	def test_login_ok
    	$browser.find_element(:id, "loginLink").click  
    	assert $wait.until {
        	$browser.find_element(:xpath => ".//*[@class='modal-dialog modal-md']").displayed?
    	}
	end

    # Logging in correctly
    def test_login_ok
        $browser.find_element(:id, "loginLink").click
        $wait.until{
            $browser.find_element(:xpath => ".//*[@name='email']").displayed?
        }
        $browser.find_element(:xpath => ".//*[@name='email']").send_keys 'complete@test.com'      
        $browser.find_element(:xpath => ".//*[@name='password']").send_keys 'password'
        $browser.find_element(:xpath => ".//*[@class='btn btn-primary btn-lg btn-block']").submit
        assert $wait.until {
            $browser.find_element(:xpath => ".//*[@class='dropdown dropdown-hover with-arrow']//*[@href='/account/info']").displayed?
        }
    end

end