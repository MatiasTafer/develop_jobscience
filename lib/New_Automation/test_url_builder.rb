require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'
require_relative './pages/board_setup_home_page.rb'
require_relative './pages/board_setup_detail_page.rb'

class TestURLBuilder < TestBasic
  
  #TC843 - Search URL Builder 
  def test_SearchUrlBuilder
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    $browser.get(HomePage::BOARD_SETUP_TAB_LINK_URL)
    
    test = [
      {"displayed" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"click" => BoardSetupHomePage::FIRST_ELEMENT_BOARD_LIST_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"click" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
      {"displayed" => BoardSetupDetailPage::BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH},
    ]
  end
  
end