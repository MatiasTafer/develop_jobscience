require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'
require_relative './pages/home_page.rb'
require_relative './pages/contacts_detail_page.rb'
require_relative './pages/contacts_new_edit_page.rb'
require_relative './pages/add_resume_popup_page.rb'
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_login_page.rb'
require_relative './pages/add_resume_popup_page.rb'

class TestDaxtraParse < TestBasic
  @@Daxtra01 = "/New_Automation/Daxtra/DaxtraResume01.pdf"
  @@Daxtra02 = "/New_Automation/Daxtra/DaxtraResume02.pdf"
  @@Daxtra03 = "/New_Automation/Daxtra/DaxtraResume03.pdf"
  @@Daxtra04 = "/New_Automation/Daxtra/DaxtraResume04.pdf"
  @@Daxtra05 = "/New_Automation/Daxtra/DaxtraResume05.pdf"
  @@Daxtra06 = "/New_Automation/Daxtra/DaxtraResume06.pdf"
  @@Daxtra07 = "/New_Automation/Daxtra/DaxtraResume07.pdf"
  @@Daxtra08 = "/New_Automation/Daxtra/DaxtraResume08.pdf"
  @@Daxtra09 = "/New_Automation/Daxtra/DaxtraResume09.pdf"
  @@DaxtraDoc01 = "/New_Automation/Daxtra/DaxtraResumeDoc01.doc"
  @@DaxtraFrench = "/New_Automation/Daxtra/DaxtraResumeFrench.pdf"
  @@DaxtraDutch = "/New_Automation/Daxtra/DaxtraResumeDutch.pdf"
  @@DaxtraGerman = "/New_Automation/Daxtra/DaxtraResumeGerman.pdf"
  @@DaxtraSpanish = "/New_Automation/Daxtra/DaxtraResumeEspanol.pdf"
  @@DaxtraEnglish = "/New_Automation/Daxtra/DaxtraResumeEnglish.pdf"

  #TC148 - Add resume with "Add Resume Dupe Prevention" set to "Attach Only"
  def test_AddResumeDupePreventionAttachOnly
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    # "Attach Only" on "Add Resume Dupe Prevention"
    CustomSettings.AddResumeDupePrevention("Attach Only")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},
    # 1 - On left sidebar on home page click Add Resumes in Resume Tools section  
      {"click" => HomePage::ADD_RESUMES_XPATH}
    ]
    Common.main(test)
     
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra01)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # 2 - Click Browse  
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
    # 3 - Locate Resume and click Add Resume  
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH},
      #{"not_displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test) 
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    name = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text
    # 4 - Change fields on the resume (keep email address the same)
    # 5 - Click Add Resumes in the Resume tools section of the left sidebar
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},
      {"click" => HomePage::ADD_RESUMES_XPATH}
    ]
    Common.main(test)
     
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@Daxtra02)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # 6 - Click Browse  
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
    # 7 - Locate updated resume and click Add Resume 
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH},
      #{"not_displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test) 
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    # RESULTS
    # Contact page should refresh. Fields on contact record should not change
    assert_equal(name, $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    
    # Both resume versions should be attached to the contact record
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_FIRST_XPATH).displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH).displayed?
    }
    
    Common.DeleteCandidateCreatedToday("Manolo, Manuel")
    
    $browser.close
    
  end

  #TC149 - Upload resume with "Add Resume Dupe Prevention" set to "Parse Fileds"
  def test_UploadResumeDupePreventionParseFields
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    # "Attach Only" on "Add Resume Dupe Prevention"
    CustomSettings.AddResumeDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},
    # 1 - On left sidebar on home page click Add Resumes in Resume Tools section  
      {"click" => HomePage::ADD_RESUMES_XPATH}
    ]
    Common.main(test)
     
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra01)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # 2 - Click Browse  
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
    # 3 - Locate Resume and click Add Resume  
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH},
      #{"not_displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test) 
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    name = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text
    # 4 - Change fields on the resume (keep email address the same)
    # 5 - Click Add Resumes in the Resume tools section of the left sidebar
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},
      {"click" => HomePage::ADD_RESUMES_XPATH}
    ]
    Common.main(test)
     
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@Daxtra02)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # 6 - Click Browse  
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
    # 7 - Locate updated resume and click Add Resume 
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH},
      #{"not_displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test) 
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    # RESULTS
    # Contact page should refresh. Fields on contact record should repopulate with changed values, unless custom settings specify otherwise.
    assert_equal("Manuel Gonzales", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    
    # Both resume versions should be attached to the contact record
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_FIRST_XPATH).displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH).displayed?
    }
    
    Common.DeleteCandidateCreatedToday("Gonzales, Manuel")
  
  end

  #TC150 - Upload resume in Job Board with "Job Board Dupe Prevention" set to "Attach Only"
  def test_UploadResumeJobBoardDupePreventionAttachOnly
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
        
    #Set Contact
    self.SetContact
    
    CustomSettings.JobBoardLogin(true)
    CustomSettings.BoardSetupInit
    
    # "Attach Only" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Attach Only")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    # 5 - Click on "Site URL" for "openings"
    $browser.get(HomePage::JOB_BOARD_URL)
    
    file = File.join(Dir.pwd, @@Daxtra01)
     
    # Must Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
    # 6 - Click on "Update Your Resume"  
      {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},  
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => file},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH},
    ]
    Common.main(test)
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH).text) 
    
    file2 = File.join(Dir.pwd, @@Daxtra02)
    
    test =[
       {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},  
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => file2},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH},
    ]
    Common.main(test)
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH).text) 
    
    $browser.get(JobBoardLoginPage::JOB_BOARD_USER_PROFILE_URL)
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).displayed?
    }
    # RESULTS
    # Contact page should refresh. Fields on contact record should repopulate with changed values, unless custom settings specify otherwise.
    assert_equal("test2016 Manolo", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    
    # Both resume versions should be attached to the contact record
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH).displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_THIRD_XPATH).displayed?
    }
    
    #Set Contact
    self.SetContact
    
  end
  
  #TC151 - Upload resume in Job Board with "Job Board Dupe Prevention" set to "Parse Fields"
  def test_UploadResumeJobBoardDupePreventionParseFields
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
        
    #Set Contact
    self.SetContact
    
    CustomSettings.JobBoardLogin(true)
    CustomSettings.BoardSetupInit
    
    # "Attach Only" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    # 5 - Click on "Site URL" for "openings"
    $browser.get(HomePage::JOB_BOARD_URL)
    
    file = File.join(Dir.pwd, @@Daxtra01)
     
    # Must Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
    # 6 - Click on "Update Your Resume"  
      {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},  
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => file},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH},
    ]
    Common.main(test)
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH).text) 
    
    file2 = File.join(Dir.pwd, @@Daxtra02)
    
    test =[
       {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},  
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => file2},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH},
    ]
    Common.main(test)
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH).text) 
    sleep(7)
    $browser.get(JobBoardLoginPage::JOB_BOARD_USER_PROFILE_URL)
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).displayed?
    }
    $browser.get(JobBoardLoginPage::JOB_BOARD_USER_PROFILE_URL)
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).displayed?
    }
    # RESULTS
    # Contact page should refresh. Fields on contact record should repopulate with changed values, unless custom settings specify otherwise.
    assert_equal("test2016 Gonzales", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    
    # Both resume versions should be attached to the contact record
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH).displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_THIRD_XPATH).displayed?
    }
    
    #Set Contact
    self.SetContact
    
  end
 

 
  #TC152 - Upload resume with "Overwrite Address" set to "TRUE"
  def test_UploadResumeOverwriteAddressTrue
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact)
        
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
   
    # "Overwrite Address" set to "TRUE"
    CustomSettings.DaxtraParseOverwrite(true, false, false, false)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra03)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH}
    ]
    Common.main(test)
    mailing_address = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text
    
    #
    sleep(2)
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@Daxtra04)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow3= $browser.window_handles.first
    $browser.switch_to.window(newWindow3)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH}
    ]
    Common.main(test)
    mailing_address2 = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text
    
    assert_not_equal(mailing_address, mailing_address2)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1)  
    
    
  end 

  #TC153 - Upload resume with "Overwrite Address" set to "FALSE"
  def test_UploadResumeOverwriteAddressFalse
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact)
        
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
   
    # "Overwrite Address" set to "TRUE"
    CustomSettings.DaxtraParseOverwrite(false, false, false, false)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    sleep(6)
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra03)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
        
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH}
    ]
    Common.main(test)
    mailing_address = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text
    
    #
    sleep(6)
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
 
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@Daxtra04)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow3= $browser.window_handles.first
    $browser.switch_to.window(newWindow3)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH}
    ]
    Common.main(test)
    
    assert_equal(mailing_address, $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1)  
    
    
  end    
 
  
  #TC154 - Upload resume with "Overwrite Employment" set to "TRUE"
  def test_UploadResumeOverwriteEmploymentTrue
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact)
        
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
   
    # "Overwrite Address" set to "TRUE"
    CustomSettings.DaxtraParseOverwrite(false, true, false, false)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
   test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra05)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_LIST_FIRST_NAME_XPATH}
    ]
    Common.main(test)
    employment_name = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text
    
    #
    sleep(2)
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@Daxtra06)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow3= $browser.window_handles.first
    $browser.switch_to.window(newWindow3)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_LIST_FIRST_NAME_XPATH}
    ]
    Common.main(test)
    employment_name2 = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text
    
    assert_not_equal(employment_name, employment_name2)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1)  
    
    
  end
 
  #TC155 - Upload resume with "Overwrite Employment" set to "FALSE"
  def test_UploadResumeOverwriteEmploymentFalse
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact)
        
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
   
    # "Overwrite Address" set to "TRUE"
    CustomSettings.DaxtraParseOverwrite(false, false, false, false)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(3)
    
    file = File.join(Dir.pwd, @@Daxtra05)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_LIST_FIRST_NAME_XPATH}
    ]
    Common.main(test)
    employment_name = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text
    
    #
    sleep(4)
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@Daxtra06)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow3= $browser.window_handles.first
    $browser.switch_to.window(newWindow3)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_LIST_FIRST_NAME_XPATH}
    ]
    Common.main(test)
    
    assert_equal(employment_name, $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1)  
    
    
  end

  #TC156 - Upload resume with "Overwrite Education" set to "TRUE"
  def test_UploadResumeOverwriteEducationTrue
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact)
        
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
   
    # "Overwrite Address" set to "TRUE"
    CustomSettings.DaxtraParseOverwrite(false, false, true, false)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra07)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_EDUCATION_LIST_FIRST_XPATH}
    ]
    Common.main(test)
    education_name = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text
    
    #
    sleep(2)
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@Daxtra08)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow3= $browser.window_handles.first
    $browser.switch_to.window(newWindow3)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_EDUCATION_LIST_FIRST_XPATH}
    ]
    Common.main(test)
    education_name2 = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text
    
    assert_not_equal(education_name, education_name2)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1)  
    
    
  end
  
  #TC157 - Upload resume with "Overwrite Education" set to "FALSE"
  def test_UploadResumeOverwriteEducationFalse
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact)
        
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
   
    # "Overwrite Address" set to "TRUE"
    CustomSettings.DaxtraParseOverwrite(false, false, false, false)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra07)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_EDUCATION_LIST_FIRST_XPATH}
    ]
    Common.main(test)
    education_name = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text
    
    #
    sleep(2)
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@Daxtra08)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow3= $browser.window_handles.first
    $browser.switch_to.window(newWindow3)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_EDUCATION_LIST_FIRST_XPATH}
    ]
    Common.main(test)
    education_name2 = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text
    
    assert_equal(education_name, education_name2)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1)  
    
    
  end

  #TC158 - Upload resume with "Include Skills" set to "TRUE"
  def test_UploadResumeIncludeSkillsTrue
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact)
        
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
   
    # "Include Skills" set to "TRUE"
    CustomSettings.DaxtraParseOverwrite(false, false, false, true)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra09)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(3)
    test=[
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH}
    ]
    Common.main(test)
    
    assert $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?
    }
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
    
  end
 
  #TC159 - Upload resume with "Include Skills" set to "FALSE"
  def test_UploadResumeIncludeSkillsFalse
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact)
        
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.JobBoardDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
   
    # "Include Skills" set to "False"
    CustomSettings.DaxtraParseOverwrite(false, false, false, false)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra09)
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(3)
        
    test = [
      {"not displayed" => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH},
      {"not displayed" => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH}
    ]
    assert Common.main(test)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
  end

  #TC162 - Upload resume with "Add Resume Allowed Filetypes" set to "pdf"
  def test_UploadResumeFilesTypesPDF
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
            
    #  Enter "pdf" on "Add Resume Allowed Filetypes"
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    #The test case specified HomePage but It make an error, so It's autommated from Contacts' Tab
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},
      {"click" => HomePage::ADD_RESUMES_XPATH}
     ]
    Common.main(test)
    
    sleep(2)
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    file = File.join(Dir.pwd, @@DaxtraDoc01)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
    
    assert_equal(AddResumePopUpPage::ADD_RESUME_POPUP_ERROR_WRONG_TYPE_TEXT, $browser.find_element(:xpath => AddResumePopUpPage::ADD_RESUME_POPUP_ERROR_MESSAGE_XPATH).text)
    
    test = [
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_CANCEL_XPATH},
    ]
    Common.main(test)
    
    sleep(1)
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    sleep(1)
  end 
  
  #TC163 - Upload resume with "Add Resume Allowed Filetypes" set to blank
  def test_UploadResumeFilesTypesBlank
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
            
    #  Enter "pdf" on "Add Resume Allowed Filetypes"
    CustomSettings.DefineResumeAllowedTypes(" ")
    
    #The test case specified HomePage but It make an error, so It's autommated from Contacts' Tab
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},  
      {"click" => HomePage::ADD_RESUMES_XPATH}
    ]
    Common.main(test)
     
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file = File.join(Dir.pwd, @@Daxtra09)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # Click Browse  
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
    # Locate Pdf Resume and click Add Resume  
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH},
      
    ]
    Common.main(test) 
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    # Click Add Resumes in the Resume tools section of the left sidebar
    test = [
      {"displayed" => HomePage::ADD_RESUMES_XPATH},
      {"click" => HomePage::ADD_RESUMES_XPATH}
    ]
    Common.main(test)
     
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    file2 = File.join(Dir.pwd, @@DaxtraDoc01)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
    # Browse  
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file2},
    # Locate Doc resume and click Add Resume 
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH},
      #{"not_displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test) 
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    # Both resume versions should be attached to the contact record
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_FIRST_XPATH).displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH).displayed?
    }
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
  end

  #TC164 - Upload resume by Job Board "Job Board Allowed Filetypes" set to "pdf"
  def test_UploadResumeJobBoardDupePreventionAttachOnly
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
        
    #Set Contact
    self.SetContact
    
    CustomSettings.JobBoardLogin(true)
    CustomSettings.BoardSetupInit
    
    #  Enter "pdf" on "Job Board Allowed Filetypes"
    CustomSettings.DefineResumeAllowedTypesJobBoard("pdf")
    
    # 5 - Click on "Site URL" for "openings"
    $browser.get(HomePage::JOB_BOARD_URL)
    
    file = File.join(Dir.pwd, @@Daxtra01)
    
     
    # Must Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
    # 6 - Click on "Update Your Resume"  
      {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},  
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => file},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH},
    ]
    Common.main(test)
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH).text) 
    
    file_doc = File.join(Dir.pwd, @@DaxtraDoc01)
    
    test =[
       {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},  
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => file_doc},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_ERROR_TYPE_XPATH},
    ]
    Common.main(test)
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_ERROR_TYPE_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_ERROR_TYPE_XPATH).text) 
    
    $browser.get(JobBoardLoginPage::JOB_BOARD_USER_PROFILE_URL)
    #RESULT
    # pdf should be added.
    
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH).displayed?
    }
    
    #Set Contact
    self.SetContact
    
  end
 
  #TC165 - Upload resume by Job Board "Job Board Allowed Filetypes" set to blank
  def test_UploadResumeJobBoardDupePreventionAttachOnly
    
    #PRECONDITIONS:
    
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
        
    #Set Contact
    self.SetContact
    
    CustomSettings.JobBoardLogin(true)
    CustomSettings.BoardSetupInit
    
    CustomSettings.JobBoardDupePrevention("Attach Only")
    
    # Leave blank on "Job Board Allowed Filetypes"
    CustomSettings.DefineResumeAllowedTypesJobBoard(" ")
    
    # 5 - Click on "Site URL" for "openings"
    $browser.get(HomePage::JOB_BOARD_URL)
    
    file = File.join(Dir.pwd, @@Daxtra01)
     
    # Must Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
    # 6 - Click on "Update Your Resume"  
      {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},  
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH}
     ]
    Common.main(test) 
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_ALL_TYPES_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_BROWSE_TEXT_XPATH).text)
    test = [
      {"click" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => file},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH},
    ]
    Common.main(test)
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH).text) 
    
    file2 = File.join(Dir.pwd, @@Daxtra02)
    
    test =[
       {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},  
      {"displayed" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"click" => JobBoardHomePage::UPLOAD_CHECKBOX_XPATH},
      {"upload" => JobBoardHomePage::BROWSE_BUTTON_XPATH, "file" => file2},
      {"click" => JobBoardHomePage::CONTINUE_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH},
    ]
    Common.main(test)
    assert_equal(JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_TEXT, $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_UPLOAD_RESUME_SUCCESS_OUTPUT_XPATH).text) 
    
    $browser.get(JobBoardLoginPage::JOB_BOARD_USER_PROFILE_URL)
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).displayed?
    }
    # RESULTS
    # Both resume versions should be attached to the contact record
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH).displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_THIRD_XPATH).displayed?
    }
    
    #Set Contact
    self.SetContact
    
  end 

  #TC166 - Upload a resume in English
  def test_UploadResumeGerman
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact) 
    
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.AddResumeDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    file = File.join(Dir.pwd, @@DaxtraEnglish)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
   
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    sleep(2)
    # RESULTS
    # Resumes should parse all fields in German.
    assert_equal("Martin Martinez", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    assert_equal("Product Developer", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text)
    assert_equal("Master of Engineering", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text)
    assert_equal("Italy Street 2000\nNew York, NY\nUS", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
  
  end

  #TC167 - Upload a resume in French
  def test_UploadResumeFrench
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact) 
    
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.AddResumeDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    file = File.join(Dir.pwd, @@DaxtraFrench)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
   
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    sleep(2)
    # RESULTS
    # Resumes should parse all fields in French.
    assert_equal("Martin Martinez", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    assert_equal("Développeur de produit", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text)
    assert_equal("Master", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text)
    assert_equal("Paris, Saint-Lazare, 75003\nFR", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
  
  end
  
  #TC168 - Upload a resume in Canadian French
  def test_UploadResumeCanadianFrench
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact) 
    
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.AddResumeDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    file = File.join(Dir.pwd, @@DaxtraFrench)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
   
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    sleep(2)
    # RESULTS
    # Resumes should parse all fields in Canadian French.
    assert_equal("Martin Martinez", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    assert_equal("Développeur de produit", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text)
    assert_equal("Master", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text)
    assert_equal("Paris, Saint-Lazare, 75003\nFR", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
  
  end


  #TC169 - Upload a resume in Spanish
  def test_UploadResumeSpanish
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact) 
    
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.AddResumeDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    file = File.join(Dir.pwd, @@DaxtraSpanish)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
   
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    sleep(2)
    # RESULTS
    # Resumes should parse all fields in Spanish.
    assert_equal("Martin Martinez", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    assert_equal(" ", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text)
    assert_equal("Master en Ingenieria", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text)
    assert_equal("Montevideo,\nUY", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
  
  end

  #TC170 - Upload a resume in Dutch
  def test_UploadResumeDutch
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact) 
    
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.AddResumeDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    file = File.join(Dir.pwd, @@DaxtraDutch)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
   
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    sleep(2)
    # RESULTS
    # Resumes should parse all fields in Dutch.
    assert_equal("Martin Martinez", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    assert_equal("Productontwikkelaar", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text)
    assert_equal("Meester", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text)
    assert_equal("Italy Street 2000\nNew York, NY\nUS", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
  end
  
  #TC171 - Upload a resume in German
  def test_UploadResumeGerman
    randomContact = "a" + SecureRandom.hex(4)
    
    #PRECONDITIONS:
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD) 
    
    Common.CreateAccount(randomContact) 
    Common.CreateContact(randomContact, randomContact) 
    
    # "Parse Fields" on "Add Resume Dupe Prevention"
    CustomSettings.AddResumeDupePrevention("Parse Fields")
    CustomSettings.DefineResumeAllowedTypes("pdf")
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    
    $wait.until{
      $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH).displayed?  
      }
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_HOVER_LINKS_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
     ]
    Common.main(test)
    
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}
    ]
    Common.main(test)
    
    sleep(2)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    sleep(4)
    file = File.join(Dir.pwd, @@DaxtraGerman)
    
    test = [
      {"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
      {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => file},
      {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}
    ]
    Common.main(test)
   
    sleep(2)
    $browser.switch_to.window($browser.window_handles.first)
    
    sleep(2)
    # RESULTS
    # Resumes should parse all fields in German.
    assert_equal("Martin Martinez", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).text)
    assert_equal("Produktentwickler", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH).text)
    assert_equal(" ", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_DEGREE_NAME_1_XPATH).text)
    assert_equal("Italien Straße 2000\nNew York, NY\nUS", $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text)
    
    $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH).displayed?  
      }
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_DELETE_XPATH}
    ]
    Common.main(test)  
    
    sleep(2)
    
    $browser.switch_to.alert.accept
    sleep(1) 
    
  end

  
    
####### CUSTOM METHODS ######
def SetContact
  #Set Contact
    $browser.get(JobBoardLoginPage::JOB_BOARD_USER_PROFILE_URL)
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_EDIT_XPATH},
    ]
    Common.main(test)
    if $browser.find_element(:xpath => ".//*[@id='RLPanelFrame']").displayed?
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH).click
    end
    sleep(2)
    test = [
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_EDIT_XPATH}
    ]
    Common.main(test)
    
    test = [  
      {"displayed" => ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH},
      {"set_text" => ContactNewEditPage::CONTACT_NEW_LAST_NAME_INPUT_XPATH, "text" => ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_OKTANA_TEXT},
      {"click" => ContactNewEditPage::CONTACT_NEW_BTN_SAVE_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_EDIT_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_XPATH},
    ]
    Common.main(test)
    
    begin
      displayed5 = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_FIFTH_XPATH).displayed?
    rescue 
      displayed5 = false 
    end
    if displayed5 == true
        $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_FIFTH_XPATH + "//td[1]//a[3]").click
        sleep(1)
        $browser.switch_to.alert.accept
        sleep(2)
        $wait.until{
          $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_XPATH).displayed?
        }
        
    end
    
    begin
      displayed = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_FOURTH_XPATH).displayed?
    rescue 
      displayed = false 
    end
    if displayed == true
        $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_FOURTH_XPATH + "//td[1]//a[3]").click
        sleep(1)
        $browser.switch_to.alert.accept
        sleep(2)
        $wait.until{
          $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_XPATH).displayed?
        }
        
    end
    
    begin
      displayed3 = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_THIRD_XPATH).displayed?
    rescue 
      displayed3 = false 
    end
    if displayed3 == true
        $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_THIRD_XPATH + "//td[1]//a[3]").click
        sleep(1)
        $browser.switch_to.alert.accept
        sleep(2)
        $wait.until{
          $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_XPATH).displayed?
        }
        
    end
    begin
      displayed2 = $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH).displayed?
    rescue 
      displayed2 = false 
    end
    if displayed2 == true
        $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH + "//td[1]//a[3]").click
        sleep(1)
        $browser.switch_to.alert.accept
        $wait.until{
          $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_NOTES_ATTACH_LIST_XPATH).displayed?
        }
    end
end  
end  