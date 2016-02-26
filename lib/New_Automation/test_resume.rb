require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'


require_relative './pages/home_page.rb'
require_relative './pages/requisitions_home_page.rb'
require_relative './pages/requisitions_detail_page.rb' 
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/job_board_login_page.rb'
require_relative './pages/job_board_register_page.rb'  
require_relative './pages/contacts_detail_page.rb'
require_relative './pages/add_resume_popup_page.rb'
require_relative './pages/contacts_home_page.rb'
require_relative './pages/contacts_detail_page.rb'




$EMAIL =  "testrodrigo@gmail.com"
$PASSWOR = "password123"

class TestResume < TestBasic
=begin
#TC979 - Job Board Resume, Attach Only  
def test_jobBoardResumeAttachOnly
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
    Common.main(test)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }          
end 
=begin
=begin  
#TC978 - Job Board Register and upload Resume  
 def test_jobBoardUploadResume
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get HomePage::JOB_BOARD_URL
    test =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
 end 
=end  
=begin 
#TC980 - Job Board Resume, Parse Fields 
def test_jobBoardResumeParseFields
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
    Common.main(test)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }  
end 
=end

=begin
#TC981 - Upload Referral Resume Successfully
def test_UploadRederralResume
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::JOB_BOARD_INTERNAL_URL
  test = [{"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
          {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
          {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
          {"displayed" => JobBoardJobDetail::REFERREL_EMAIL_XPATH},
          {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => $EMAIL},
          {"click" => JobBoardJobDetail::JOB_BOARD_CONTINUE_BUTTON_XPATH},
          {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
          {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "NameTest"},
          {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "LastNameTest"},
          {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL, "text" => "correo.test@email.com"},
          {"upload" => JobBoardJobDetail::PROSPECT_RESUME_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
          {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::THANK_YOU_REFERRAL_MESSAGE_XPATH)
  }  
end
=end

=begin  
#TC982 - Upload Referral Resume Successfully, ERP Dupe Prevention = Attach Only
def test_UploadReferralResumeAtachOnly
   Common.login(Common::USER_EMAIL, Common::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
           {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
           {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
           {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test)
   $browser.get HomePage::JOB_BOARD_INTERNAL_URL
   test2 = [{"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
            {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
            {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
            {"displayed" => JobBoardJobDetail::REFERREL_EMAIL_XPATH},
            {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => $EMAIL},
            {"click" => JobBoardJobDetail::JOB_BOARD_CONTINUE_BUTTON_XPATH},
            {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
            {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "NameTest"},
            {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "LastNameTest"},
            {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL, "text" => "correo.test@email.com"},
            {"upload" => JobBoardJobDetail::PROSPECT_RESUME_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
            {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::THANK_YOU_REFERRAL_MESSAGE_XPATH)
  }    
end
=end

=begin  
#TC983 - Upload Referral Resume Successfully, ERP Dupe Prevention = Parse Fields.  (pending)
def test_UploadReferralResumeParseFields
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
           {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
           {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
           {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test)
   $browser.get HomePage::JOB_BOARD_INTERNAL_URL
   test2 = [{"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
            {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
            {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_REFER_CANDIDATE_XPATH},
            {"displayed" => JobBoardJobDetail::REFERREL_EMAIL_XPATH},
            {"set_text" => JobBoardJobDetail::REFERREL_EMAIL_XPATH, "text" => $EMAIL},
            {"click" => JobBoardJobDetail::JOB_BOARD_CONTINUE_BUTTON_XPATH},
            {"displayed" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH},
            {"set_text" => JobBoardJobDetail::PROSPECT_FIRST_NAME_XPATH, "text" => "NameTest"},
            {"set_text" => JobBoardJobDetail::PROSPECT_LAST_NAME_XPATH, "text" => "LastNameTest"},
            {"set_text" => JobBoardJobDetail::PROSPECT_EMAIL, "text" => "correo.test@email.com"},
            {"upload" => JobBoardJobDetail::PROSPECT_RESUME_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
            {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
  Common.main(test2)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::THANK_YOU_REFERRAL_MESSAGE_XPATH)
  }  
end
=end


=begin
#TC984 - Add Resume with the Add Resume Tool, Attach Only
def test_ResumToolAttachOly
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get HomePage::HOME_TAB_LINK_URL
  test2 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test3 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  } 
end
=end



=begin
#TC985 - Add Resume with the Add Resume Tool, Parse Fields
def test_addResumeToolParseFields
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test = [{"displyed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get HomePage::HOME_TAB_LINK_URL
  test2 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test3 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }   
end
=end


#TC986 - Add resume , De-Duplication in a Private Sharing Model, New Candidate
def test_addResumePrivateSharingModel
  #Preconditions
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
          {"checked" => SetupEditPage::ENFORCE_SHARING_CHECKBOX_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get SetupEditPage::SHARING_SETTINGS_URL
  test2 = [{"displayed" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"click" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"set_text" => SetupEditPage::CONTACT_PICKLIST_XPATH, "text" => "Private"},
           {"click" => SetupEditPage::SHARING_SETTINGS_SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::HOME_TAB_LINK_URL
  test3 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
  Common.main(test3)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test4 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }  
end











=begin
#TC991 - Contact Update Resume Successfully, Attach Onlydef 
def test_contactUpdateResumeAttachOnly
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test2 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test3 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  } 
end
=end

=begin
#TC992 - Contact Update Resume Successfully, Parse Fields
def test_contactUpdateResumeParseFields
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test2 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test3 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }   
end
=end

#TC987 - Add resume , De-Duplication in a Private Sharing Model, Duplicate candidate not shared
def test_addResumeNotShared
  #Preconditions
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
          {"checked" => SetupEditPage::ENFORCE_SHARING_CHECKBOX_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get SetupEditPage::SHARING_SETTINGS_URL
  test2 = [{"displayed" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"click" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"set_text" => SetupEditPage::CONTACT_PICKLIST_XPATH, "text" => "Private"},
           {"click" => SetupEditPage::SHARING_SETTINGS_SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::HOME_TAB_LINK_URL
  test3 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
  Common.main(test3)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test4 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.pdf"},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }  
end



=begin
#TC993 - Contact Update Resume Validation
def test_contactUpdateResumeValidation
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"set_text" => SetupEditPage::ADD_RESUME_ALLOWED_FILETYPES_XPATH, "text" => "txt, pdf, doc, docx"},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test2 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test2)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test3 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => "/Users/admin/Desktop/document.png"},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  assert $wait.until{
    $browser.find_element(:xpath, AddResumePopUpPage::ADD_RESUME_POPUP_ERROR_MESSAGE_XPATH).displayed?
  }  
end
=end
=begin
#TC994 - State and Country Picklists feature, USA with State and Country picklists - Resume Tools
def test_picklistUSAResumeTools
   Common.login(Common::USER_EMAIL, Common::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"checked" => SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test)
     
  
end
=end

=begin
 #TC106 - Enable Resume Attached to contact record
  def test_EnableResumeAttachContactRecord
    randomName = SecureRandom.hex(4)
  
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    
    Common.CreateRequisitionPostJob(randomName, true)
    
    # Mark the field "Attach to Applications" = TRUE
    CustomSettings.AttachToApplications(true)
    
    CustomSettings.BoardSetupInit
    CustomSettings.DefineEEOQuestions(false, false, false, false, false)
    
    
    # 1. Go to Board Setup tab
    $browser.get(HomePage::JOB_BOARD_URL)
     
    # Login
    test = [
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},  
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_USER_TEXT},
      {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => JobBoardLoginPage::JOB_BOARD_PASSWORD_TEXT}, 
      {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGOUT_LINK_XPATH}  
    ]
    Common.main(test)
    # 8. Select a Job title
    $browser.find_element(:xpath => JobBoardHomePage::JOB_BOARD_JOB_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]").click
    test = [
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
    # 9. Click Apply for [job title] position    
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
    # 10. Click Continue
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_RETURN_JOBSEARCH_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH}
    ]
    Common.main(test)
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
    ]
    Common.main(test)
    
    # 13. Go to Contact record
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + JobBoardLoginPage::JOB_BOARD_USER_NAME_TEXT + "')]]").click
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_APP_LIST_XPATH}
    ]
    Common.main(test) 
    
    # 14. Click on record ID of newly created Application
    $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomName + "')]]//..//..//..//td[7]//a").click
    test = [
      {"displayed" => ApplicationsDetailPage::APP_DETAIL_RESUME_UPLOADED_XPATH}
    ]
    Common.main(test) 
    
    # Resume should be attached to contact record as well as application record
    assert_equal("true", $browser.find_element(:xpath => ApplicationsDetailPage::APP_DETAIL_RESUME_UPLOADED_XPATH).text)
 
    Common.DeleteRequisition(randomName)
    
  end
  
 
  #TC107 - Enable contact jcard view
  def test_EnableContactJCardView 
   
    #PRECONDITIONS
    #Login
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
   
    CustomSettings.EnableJCardForContact(true)
   
    $browser.get(HomePage::CONTACTS_TAB_LINK_URL)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_BTN_GO_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_HOME_FIRST_ENTRY_GO_XPATH},
      {"click" => ContactsHomePage::CONTACT_HOME_FIRST_ENTRY_GO_XPATH},
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_NAME_XPATH}
    ]
    Common.main(test)
    sleep(3)
    
    $browser.switch_to.frame(ContactDetailPage::CONTACT_DETAIL_RESUME_IFRAME_ID)
    assert $wait.until{
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_JCARD_XPATH).displayed?
    }
   CustomSettings.EnableJCardForContact(false)
  end
=end
  

end