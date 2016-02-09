require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'
require 'selenium-webdriver'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'


class Session < TestBasic
    def save_session
      puts "Entro"
      Common.login(Common::USER_EMAIL, Common::PASSWORD)
      
      $browser.manage.all_cookies.each do |cookie|
        puts cookie[:name]
        puts cookie[:value]
        puts cookie[:domain]
        puts "\n"
      end
        
    end
end