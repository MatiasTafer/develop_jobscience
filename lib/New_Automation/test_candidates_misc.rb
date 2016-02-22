require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/home_page.rb'

class TestCandidatesMisc < TestBasic
  
  #TC103 - Add Job Order from Uploading File
  def test_AddJobOrderFromUploading
    
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    #Go to HomePage
    $browser.get(HomePage::HOME_TAB_LINK_URL)
    
    # 1 - Click on "Job Order Tools" on sidebar sections
    test = [
      {"displayed" => HomePage::ADD_JOB_ORDERS_XPATH},
    # 2 - Click on "Add Job Order"  
      {"click" => HomePage::ADD_JOB_ORDERS_XPATH}
    ]
    Common.main(test)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => HomePage::UPLOAD_BTN_BROWSE_XPATH},
      {"set_text" => }
    ]
    
    
    
    
  end
  
end