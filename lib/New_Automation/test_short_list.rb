require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/short_list_detail_page.rb'
require_relative './pages/short_list_home_page.rb'
require_relative './pages/short_list_review_email_popup.rb'
require_relative './pages/short_list_send_email_popup.rb'



class TestShortList < TestBasic
  
def test_addUpdateStauts
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::SHORT_LIST_TAB_LINK_URL
  $wait.until {
    $browser.current_url.eql? HomePage::SHORT_LIST_TAB_LINK_URL
  }
  test = [{"click" => ShortListHomePage::SHORT_LIST_RECORD_XPATH_2}, 
          {"displayed" => ShortListDetailPage::SL_RECORD_XPATH},
          {"click" => ShortListDetailPage::SL_RECORD_XPATH},
          {"click" => ShortListDetailPage::SL_MENU_XPATH},
          {"displayed" => ShortListDetailPage::SL_UPDATE_STATUS_OPTION_XPATH},
          {"click" => ShortListDetailPage::SL_UPDATE_STATUS_OPTION_XPATH}]
  Common.main(test)        
  #newWindow= $browser.window_handles[1]
  #$browser.switch_to.window(newWindow) 
  #new_frame = $browser.find_element(:xpath, ShortListDetailPage::FRAME_STATUS_XPATH)
  $browser.switch_to.frame(1)  
  test2 = [ {"displayed" => ShortListDetailPage::SELECT_STATUS_DROPDOWN_XPATH},
            {"set_text" => ShortListDetailPage::SELECT_STATUS_DROPDOWN_XPATH, "text" => "Not Invited"},
            {"click" => ShortListDetailPage::SUBMIT_BUTTON_XPATH}]
  Common.main(test2)
  assert $wait.until{
    $browser.find_element(:xpath, ShortListDetailPage::CLOSE_BUTTON_XPATH).displayed?
    $browser.find_element(:xpath, ShortListDetailPage::SUBMIT_MESSAGE_XPATH).displayed?
  }      
end
  
  
end