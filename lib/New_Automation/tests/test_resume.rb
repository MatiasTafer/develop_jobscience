require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'


require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'custom_settings.rb'
require_relative 'users.rb'

require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb' 
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/job_board/job_board_login_page.rb'
require './New_Automation/pages/job_board/job_board_register_page.rb'  
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/resume/add_resume_popup_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'




$EMAIL =  "testrodrigo2@gmail.com"
$PASSWOR = "password123"


$DOCUMENT_PDF = "/New_Automation/files/Resumes/document.pdf"
$DOCUMENT_PNG = "/New_Automation/files/Resumes/document.png"
$ADRESS_IN_SPANISH = "/New_Automation/files/Resumes/AdressInSpanish.pdf"
$CA_ADRESS_CA = "/New_Automation/files/Resumes/CAAdressCA.pdf"
$CA_ADRESS_CANADA = "/New_Automation/files/Resumes/CAAdressCanada.pdf"
$CA_ADRESS_ONLY = "/New_Automation/files/Resumes/CAAdressOnly.pdf"
$INTERNATIONAL_ADRESS ="/New_Automation/files/Resumes/InternationalAdress.pdf"
$USA_ADRESS_ONLY = "/New_Automation/files/Resumes/USAdressOnly.pdf"
$USA_ADRESS_UNITED_STATES ="/New_Automation/files/Resumes/USAdressUnitedStates.pdf"
$USA_ADRESS_USA = "/New_Automation/files/Resumes/USAdressUSA.pdf"
$US_POST_CODE = "/New_Automation/files/Resumes/USPostalCode.pdf"



class TestResume < TestBasic


@@AdressInSpanish = File.join(Dir.pwd, $ADRESS_IN_SPANISH)
@@CAAdressCA = File.join(Dir.pwd, $CA_ADRESS_CA)
@@CAAdressCanada = File.join(Dir.pwd, $CA_ADRESS_CANADA)
@@CAAdressOnly = File.join(Dir.pwd, $CA_ADRESS_ONLY)
@@documentPdf = File.join(Dir.pwd, $DOCUMENT_PDF)
@@documentPng = File.join(Dir.pwd, $DOCUMENT_PNG)
@@internationalAdress = File.join(Dir.pwd, $INTERNATIONAL_ADRESS )
@@usaAdressOnly = File.join(Dir.pwd, $USA_ADRESS_ONLY )
@@usaAdressUnitedStates = File.join(Dir.pwd, $USA_ADRESS_UNITED_STATES)
@@usaAdressUsa = File.join(Dir.pwd, $USA_ADRESS_USA)
@@usPostalCode = File.join(Dir.pwd, $US_POST_CODE)


#TC979 - Job Board Resume, Attach Only  
def test_jobBoardResumeAttachOnly
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
    Common.main(test)    
    $wait.until {
      $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).displayed?
    } 
    $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
    test2 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
    Common.main(test2)
    $browser.get HomePage::JOB_BOARD_URL
    test3 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@documentPdf},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test3) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }          
end 

=begin

#TC978 - Job Board Register and upload Resume  
 def test_jobBoardUploadResume
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
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
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@documentPdf},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
 end 
 
#TC980 - Job Board Resume, Parse Fields 
def test_jobBoardResumeParseFields
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
    test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
    Common.main(test)     
    $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
    test2 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
    Common.main(test2)
    $browser.get HomePage::JOB_BOARD_URL
    test3 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@documentPdf},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test3) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }  
end 

#TC981 - Upload Referral Resume Successfully
def test_UploadRederralResume
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
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
          {"upload" => JobBoardJobDetail::PROSPECT_RESUME_BROWSE_XPATH, "file" => @@documentPdf},
          {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::THANK_YOU_REFERRAL_MESSAGE_XPATH)
  }  
end

#TC982 - Upload Referral Resume Successfully, ERP Dupe Prevention = Attach Only
def test_UploadReferralResumeAtachOnly
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test2 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test2)
   $browser.get HomePage::JOB_BOARD_INTERNAL_URL
   test3 = [{"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
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
            {"upload" => JobBoardJobDetail::PROSPECT_RESUME_BROWSE_XPATH, "file" => @@documentPdf},
            {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
  Common.main(test3)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::THANK_YOU_REFERRAL_MESSAGE_XPATH)
  }    
end
 
#TC983 - Upload Referral Resume Successfully, ERP Dupe Prevention = Parse Fields.  (pending)
def test_UploadReferralResumeParseFields
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test2 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test2)
   $browser.get HomePage::JOB_BOARD_INTERNAL_URL
   test3 = [{"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
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
            {"upload" => JobBoardJobDetail::PROSPECT_RESUME_BROWSE_XPATH, "file" => @@documentPdf},
            {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
  Common.main(test3)
  assert $wait.until {
    $browser.find_element(:xpath, JobBoardJobDetail::THANK_YOU_REFERRAL_MESSAGE_XPATH)
  }  
end

#TC984 - Add Resume with the Add Resume Tool, Attach Only
def test_ResumToolAttachOly
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test2 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test2)
  $browser.get HomePage::HOME_TAB_LINK_XPATH
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  } 
end

#TC985 - Add Resume with the Add Resume Tool, Parse Fields
def test_addResumeToolParseFields
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test2 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test2)
  $browser.get HomePage::HOME_TAB_LINK_XPATH
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }   
end

#TC986 - Add resume , De-Duplication in a Private Sharing Model, New Candidate
def test_addResumePrivateSharingModel
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
  $browser.get SetupEditPage::SHARING_SETTINGS_URL
  test2 = [{"displayed" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"click" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"set_text" => SetupEditPage::CONTACT_PICKLIST_XPATH, "text" => "Private"},
           {"click" => SetupEditPage::SHARING_SETTINGS_SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::HOME_TAB_LINK_XPATH
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }  
end

#TC991 - Contact Update Resume Successfully, Attach Onlydef 
def test_contactUpdateResumeAttachOnly
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  } 
end

#TC992 - Contact Update Resume Successfully, Parse Fields
def test_contactUpdateResumeParseFields
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }   
end

#TC987 - Add resume , De-Duplication in a Private Sharing Model, Duplicate candidate not shared
def test_addResumeNotShared
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
  $browser.get SetupEditPage::SHARING_SETTINGS_URL
  test2 = [{"displayed" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"click" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"set_text" => SetupEditPage::CONTACT_PICKLIST_XPATH, "text" => "Private"},
           {"click" => SetupEditPage::SHARING_SETTINGS_SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::HOME_TAB_LINK_XPATH
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }  
end

#TC988 - Add resume , De-Duplication in a Private Sharing Model, Duplicate candidate One shared others not
def test_addResumeOneShared
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
  $browser.get SetupEditPage::SHARING_SETTINGS_URL
  test2 = [{"displayed" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"click" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"set_text" => SetupEditPage::CONTACT_PICKLIST_XPATH, "text" => "Private"},
           {"click" => SetupEditPage::SHARING_SETTINGS_SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::HOME_TAB_LINK_XPATH
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }   
end

#TC993 - Contact Update Resume Validation
def test_contactUpdateResumeValidation
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPng},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  assert $wait.until{
    $browser.find_element(:xpath, AddResumePopUpPage::ADD_RESUME_POPUP_ERROR_MESSAGE_XPATH).displayed?
  }  
end

#TC994 - State and Country Picklists feature, USA with State and Country picklists - Resume Tools
def test_picklistUSAResumeTools
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test2 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressOnly},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test2)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")
   $browser.get HomePage::HOME_TAB_LINK_XPATH
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
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressUsa},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test4)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_COUNTRY_XPATH).text, "US")
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test7 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test7)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test8 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressUsa},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test8)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_COUNTRY_XPATH).text, "US")
end

#TC995 - State and Country Picklists feature, Canada with State and Country picklists - Resume Tools
def test_pickListCanadaResumeTools
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test2 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressOnly},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test2)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
   $browser.get HomePage::HOME_TAB_LINK_XPATH
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
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressCA},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test4)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_COUNTRY_XPATH).text, "CA")
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test7 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test7)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test8 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressCanada},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test8)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_COUNTRY_XPATH).text, "CA")  
end

#TC996 - State and Country Picklists feature, International with State and Country picklists - Resume Tools
def test_PickListInternationalResumeTool
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test2 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@internationalAdress},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test2)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text.delete!("\n").delete(' ').delete(','), "8ArdaghRdLimerickIE")     
end

#TC997 - State and Country Picklists feature, validation with State and Country picklists - Resume Tools
def test_ValidationCountryPicklist
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"checked" => SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test2 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test2)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test4 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usPostalCode},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test4)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text, "")
end

#TC998 - State and Country Picklists feature, non-English language with State and Country picklists - Resume Tools
def test_nonEnglishPickList
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"checked" => SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test3 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test3)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test2 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test2)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test4 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@AdressInSpanish},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test4)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text, "")
end

#TC1004 - State and Country Picklists feature, USA with State and Country picklists - Resume Update feature
def test_resumUpdateCountryPickList
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressOnly},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")  
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test4 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test4)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test7 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressUsa},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test7)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test8 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test8)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test9 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressUnitedStates},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test9)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US") 
end

#TC1005 - State and Country Picklists feature, Canada with State and Country picklists - Resume Update feature
def test_resumeUpdateCountryPicklistCanada
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressOnly},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")  
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test4 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test4)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test7 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressCA},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test7)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test8 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test8)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test9 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressCanada},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test9)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
end

#TC1006 - State and Country Picklists feature, International with State and Country picklists - Resume Update feature  
def test_resumeUpdateInternational
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@internationalAdress},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "8ArdaghRdLimerickIE")  
end

#TC1007 - State and Country Picklists feature, validation with State and Country picklists - Resume Update feature
def test_stateContryPicklistUpdateResumeValidation
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"checked" => SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
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
   test4 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usPostalCode},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test4)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text, "")
end

#TC1008 - State and Country Picklists feature, non-English language with State and Country picklists - Resume Update feature
def test_nonEnglishUpdateResum
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"checked" => SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
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
   test4 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@AdressInSpanish},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test4)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text, "")  
end


#TC1014 - State and Country Picklists feature, USA with State and Country picklists - Job Board
def test_updateResumePickListJobBoard
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@usaAdressOnly},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
    $browser.get HomePage::JOB_BOARD_URL
    test3 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@usaAdressUnitedStates},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test3) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    } 
    $browser.get HomePage::JOB_BOARD_URL
    test4 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@usaAdressUsa},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test4) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    } 
end


#TC1015 - State and Country Picklists feature, Canada with State and Country picklists - Job Board
def test_updateResumePickListJobBoardCanada
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@CAAdressOnly},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
    $browser.get HomePage::JOB_BOARD_URL
    test3 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@CAAdressCanada},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test3) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    } 
    $browser.get HomePage::JOB_BOARD_URL
    test4 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@CAAdressCA},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test4) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    } 
end

#TC1016 - State and Country Picklists feature, International with State and Country picklists - Job Board
def test_updateResumePickListJobBoardIntenational
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)

    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@internationalAdress},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
end

#TC1017 - State and Country Picklists feature, validation with State and Country picklists - Job Board
def test_validationResumePickList
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@usPostalCode},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
end

#TC1018 - State and Country Picklists feature, non-English language with State and Country picklists - Job Board
def test_updateResumeJobBoardNoEnglish
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@AdressInSpanish},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }  
end

#TC1019 - State and Country Picklists feature, USA without State and Country picklists - Job Board
def test_USAUpdateResumePicklistDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@usaAdressOnly},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
    $browser.get HomePage::JOB_BOARD_URL
    test3 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@usaAdressUnitedStates},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test3) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    } 
    $browser.get HomePage::JOB_BOARD_URL
    test4 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@usaAdressUsa},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test4) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }   
end

#TC1020 - State and Country Picklists feature, Canada without State and Country picklists - Job Board
def test_CanadaUpdateResumePickListDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@CAAdressOnly},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
    $browser.get HomePage::JOB_BOARD_URL
    test3 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@CAAdressCanada},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test3) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    } 
    $browser.get HomePage::JOB_BOARD_URL
    test4 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@CAAdressCA},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test4) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }  
end

#TC1021 - State and Country Picklists feature, International without State and Country picklists - Job Board
def test_InternationalUpdateResumeDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@internationalAdress},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
end

#TC1022 - State and Country Picklists feature, validation without State and Country picklists - Job Board
def test_PostCodeResumeUpdateDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@usPostalCode},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
end


#TC1023 - State and Country Picklists feature, non-English language without State and Country picklists - Job Board
def test_noEnglishResumeUpdateDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@AdressInSpanish},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }
end

#TC999 - State and Country Picklists feature, USA without State and Country picklists - Resume Tools
def test_USAResumeUpdateDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressOnly},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")  
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test4 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test4)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test7 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressUsa},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test7)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test8 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test8)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test9 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressUnitedStates},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test9)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")
end


#TC1000 - State and Country Picklists feature, Canada without State and Country picklists - Resume Tools
def test_UpdateResumeCanadaDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressOnly},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")  
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test4 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test4)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test7 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressCA},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test7)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test8 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test8)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test9 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressCanada},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test9)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
end

#TC1001 - State and Country Picklists feature, International without State and Country picklists - Resume Tools
def test_resumeToolInternationalDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test2 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@internationalAdress},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test2)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text.delete!("\n").delete(' ').delete(','), "8ArdaghRdLimerickIE") 
end


#TC1002 - State and Country Picklists feature, validation without State and Country picklists - Resume Tools
def test_ValidationResumeToolUpdateResume
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)
   $wait.until { 
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).displayed?   
   } 
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"checked" => SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test4 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usPostalCode},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test4)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text, "")
end


#TC1003 - State and Country Picklists feature, non-English language without State and Country picklists - Resume Tools
def test_noEnglishResumeUpdateDisablePicklist
   Common.login(Users::USER_EMAIL, Users::PASSWORD)
   $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"checked" => SetupEditPage::OVERWRITE_ADDRESS_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test3 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test3)
   $browser.get HomePage::HOME_TAB_LINK_XPATH
   test2 = [{"displayed" => HomePage::ADD_RESUMES_XPATH},
           {"click" => HomePage::ADD_RESUMES_XPATH}]
   Common.main(test2)
   $wait.until{
     windowsNumer = $browser.window_handles.size
     windowsNumer > 1
   }
   newWindow= $browser.window_handles[1]
   $browser.switch_to.window(newWindow)
   test4 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
            {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@AdressInSpanish},
            {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
   Common.main(test4)
   newWindow= $browser.window_handles[0]
   $browser.switch_to.window(newWindow)
   assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).displayed?
   } 
   assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text, "") 
end



#TC1009 - State and Country Picklists feature Disabled, USA without State and Country picklists - Resume Update feature
def test_ResumeUpdateFeaturePicklistDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressOnly},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")  
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test4 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test4)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test7 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressUsa},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test7)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test8 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test8)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test9 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usaAdressUnitedStates},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test9)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "61MeetinghouseRoadWindhamNH03087US")
end


#TC1010 - State and Country Picklists feature Disabled, Canada without State and Country picklists - Resume Update feature
def test_UpdateResumeContactTabPcikListDisable
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressOnly},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")  
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test4 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test4)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test7 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressCA},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test7)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
  $browser.get HomePage::ALL_CONTACTS_TAB_LINK
  test8 = [{"displayed" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"click" => ContactsHomePage::FIRST_CONTACT_ALL_CONTACT_TAB_XPATH},
          {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH},
          {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH}]
  Common.main(test8)
  $wait.until{
    windowsNumer = $browser.window_handles.size
    windowsNumer > 1
  }
  newWindow= $browser.window_handles[1]
  $browser.switch_to.window(newWindow)
  test9 = [{"displayed" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH},
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@CAAdressCanada},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test9)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "10­123MainstMontrealQCH3Z2Y7CA")
end

#TC1011 - State and Country Picklists feature Disabled, International without State and Country picklists - Resume Update feature
def test_InternationalResumeUpdateContactTabDisbalePickList
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@internationalAdress},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).text.delete!("\n").delete(' ').delete(','), "8ArdaghRdLimerickIE")  
end

#TC1012 - State and Country Picklists feature Disabled, validation without State and Country picklists - Resume Update feature
def test_validationPicklistDisableConatacResumeUpdateFeature
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@usPostalCode},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test3)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
      $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_XPATH).displayed?
  } 
  assert_equal($browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH).text, "")  
end




#TC1024 - Previously Uploaded Resumes - False
def test_PreviouslyUploadResume
#Preconditions
Common.login(Users::USER_EMAIL, Users::PASSWORD)
CustomSettings.JobBoardLogin(true)
$browser.get SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL
test = [{"displayed" => SetupEditPage::HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
        {"unchecked" => SetupEditPage::HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
        {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
Common.main(test)
$browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
test2 = [{"displayed" => SetupEditPage::ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH},
         {"checked" => SetupEditPage::ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH},
         {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
Common.main(test2)
#Steps
$browser.get HomePage::JOB_BOARD_URL
    test3 = [
      # Steps
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $EMAIL},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWOR},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      # 6. Click on a job title
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_PREVIOUSLY_UPLOADED_RADIO_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_PREVIOUSLY_UPLOADED_RADIO_XPATH}]
      Common.main(test3)
      $wait.until{
        $browser.find_element(:xpath, JobBoardJobDetail::SELECT_RESUME_DROPDOWN_XPATH).displayed?
      }
      $browser.find_element(:xpath, JobBoardJobDetail::SELECT_RESUME_DROPDOWN_XPATH).send_keys "2/29/2016 12:01 PM - Resume_testro_testro_JB_Non-parsed.pdf"
     
     
test4 = [{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         
       #9. Fill the field...
     {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
Common.main(test4)      
assert $wait.until{
  $browser.find_element(:xpath, ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]").displayed?     
  }
            
end

#TC1025 - Previously Uploaded Resumes, with Attach to Applications = false
def test_UploadResumeAttachAppFalse
#Preconditions
Common.login(Users::USER_EMAIL, Users::PASSWORD)
CustomSettings.JobBoardLogin(true)
$browser.get SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL
test = [{"displayed" => SetupEditPage::HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
        {"unchecked" => SetupEditPage::HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
        {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
Common.main(test)
$browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
test2 = [{"displayed" => SetupEditPage::ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH},
         {"unchecked" => SetupEditPage::ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH},
         {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
Common.main(test2)
#Steps
$browser.get HomePage::JOB_BOARD_URL
    test3 = [
      # Steps
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $EMAIL},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWOR},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      # 6. Click on a job title
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_PREVIOUSLY_UPLOADED_RADIO_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_PREVIOUSLY_UPLOADED_RADIO_XPATH}]
      Common.main(test3)
      $wait.until{
        $browser.find_element(:xpath, JobBoardJobDetail::SELECT_RESUME_DROPDOWN_XPATH).displayed?
      }
      $browser.find_element(:xpath, JobBoardJobDetail::SELECT_RESUME_DROPDOWN_XPATH).send_keys "2/29/2016 12:01 PM - Resume_testro_testro_JB_Non-parsed.pdf"
     
test4 = [{"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
         
       #9. Fill the field...
     {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
Common.main(test4)      
assert $wait.until{
  $browser.find_element(:xpath, ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]").displayed?     
  } 
end



#TC1150 - Previously Uploaded Resumes - True
def test_PreviouslyUploadedResumeTrue
Common.login(Users::USER_EMAIL, Users::PASSWORD)
CustomSettings.JobBoardLogin(true)
$browser.get SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL
test = [{"displayed" => SetupEditPage::HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
        {"checked" => SetupEditPage::HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH},
        {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
Common.main(test)
$browser.get SetupEditPage::CONFIG_SETUP_EDIT_PAGE_URL
test2 = [{"displayed" => SetupEditPage::ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH},
         {"unchecked" => SetupEditPage::ATTACH_TO_APPLICATIONS_CHECKBOX_XPATH},
         {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
Common.main(test2)
#Steps
$browser.get HomePage::JOB_BOARD_URL
    test3 = [
      # Steps
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $EMAIL},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWOR},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      # 6. Click on a job title
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH}]
Common.main(test3)
assert Common.not_displayed(JobBoardJobDetail::JOB_BOARD_APPLY_PREVIOUSLY_UPLOADED_RADIO_XPATH)
end


#TC1026 - Resume Days Valid 
def test_ResumeDaysValid
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  CustomSettings.JobBoardLogin(true)
  $browser.get SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL
  test = [{"displayed" => SetupEditPage::RESUME_REQUIRE_CHECKBOX_XPATH},
          {"checked" =>  SetupEditPage::RESUME_REQUIRE_CHECKBOX_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test2 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"displayed" => SetupEditPage::RESUME_DAYS_VALID_TEXT_XPATH},
          {"set_text" => SetupEditPage::RESUME_DAYS_VALID_TEXT_XPATH, "text" => "N"},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
    test3 = [
      # Steps
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $EMAIL},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWOR},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      # 6. Click on a job title
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_BROWSE_XPATH},
      {"upload" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_BROWSE_XPATH, "file" => @@documentPdf},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      # 9. Fill the field...
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
      Common.main(test3)        
      assert $wait.until{ 
          $browser.find_element(:xpath, ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]") .displayed?   
      }  
end

#TC989 - Add resume , De-Duplication in a Private Sharing Model, Duplicate candidate One shared
def test_addResumeOneShared
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"unchecked" => SetupEditPage::ENFORCE_SHARING_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
  $browser.get SetupEditPage::SHARING_SETTINGS_URL
  test2 = [{"displayed" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"click" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"set_text" => SetupEditPage::CONTACT_PICKLIST_XPATH, "text" => "Private"},
           {"click" => SetupEditPage::SHARING_SETTINGS_SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::HOME_TAB_LINK_XPATH
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  } 
end

#TC1013 - State and Country Picklists feature Disabled, non-English language without State and Country picklists - Resume Update feature
def test_updateResumeJobBoardNoEnglishDisabled
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
    CustomSettings.JobBoardLogin(true)
    $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Attach Only"},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
    $browser.get HomePage::JOB_BOARD_URL
    test2 =[{"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
            {"displayed" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_USERNAME_XPATH, "text" => $EMAIL},
            {"set_text" => JobBoardLoginPage::JOB_BOARD_LOGIN_PASSWORD_XPATH, "text" => $PASSWOR},
            {"click" => JobBoardLoginPage::JOB_BOARD_LOGIN_BTN_LOGIN_XPATH},
            {"displayed" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"click" => JobBoardHomePage::JOB_BOARD_UPDATE_YOUR_RESUME_XPATH},
            {"upload" => JobBoardJobDetail::BROWSE_BUTTON_XPATH, "file" => @@AdressInSpanish},
            {"click" => JobBoardJobDetail::CONTINUE_BUTTON_XPATH}]    
    Common.main(test2) 
    assert $wait.until {
      $browser.find_element(:xpath, JobBoardJobDetail::SUCCESS_UPLOADED_RESUEM_XPATH).displayed?
    }  
end

#TC1028 - Resume Days Valid, Validation Blank
def test_ResumeDaysValidationBlank
   #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  CustomSettings.JobBoardLogin(true)
  $browser.get SetupEditPage::JOB_BOARD_SETUP_EDIT_PAGE_URL
  test = [{"displayed" => SetupEditPage::RESUME_REQUIRE_CHECKBOX_XPATH},
          {"checked" =>  SetupEditPage::RESUME_REQUIRE_CHECKBOX_XPATH},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
  test2 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
          {"displayed" => SetupEditPage::RESUME_DAYS_VALID_TEXT_XPATH},
          {"set_text" => SetupEditPage::RESUME_DAYS_VALID_TEXT_XPATH, "text" => "N"},
          {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::JOB_BOARD_URL
    test3 = [
      # Steps
      
      # LOGIN
      {"displayed" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      # 6. Click on "Login"
      {"click" => JobBoardHomePage::JOB_BOARD_LOGIN_LINK_XPATH},
      {"displayed" => LoginPage::USERNAME_TEXT_XPATH},
      # 7. Fill the required fields: "Username" and "Password".
      {"set_text" => LoginPage::USERNAME_TEXT_XPATH, "text" => $EMAIL},
      {"set_text" => LoginPage::PASSWORD_TEXT_XPATH, "text" => $PASSWOR},
      # 8. Click in "Login".
      {"click" => LoginPage::LOGIN_BUTTON_XPATH},
      {"displayed" => ".//*[@id='js-loggedin-legend'][text()[contains(.,'Logged in as')]]"},
      # END LOGIN
      
      # 6. Click on a job title
      {"displayed" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_SEARCH_BUTTON_XPATH},
      {"displayed" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      {"click" => JobBoardHomePage::JOB_BOARD_FIRST_ELEMENT_LIST_XPATH},
      # 7. Click on green link "Apply for the ..." depending of the job selected.
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_LINK_XPATH},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_BROWSE_XPATH},
      {"upload" => JobBoardJobDetail::JOB_BOARD_APPLY_UPLOAD_RESUME_BROWSE_XPATH, "file" => @@documentPdf},
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_CONTINUE_XPATH},
      # 9. Fill the field...
      {"displayed" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_GRADUATE_COLLEGE_XPATH, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SALES_BACKGROUND, "text" => "Y"},
      {"set_text_exist" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_YEARS_EXPERIENCE_XPATH, "text" => "1"},
      
      {"click" => JobBoardJobDetail::JOB_BOARD_APPLY_JOB_SUBMIT_XPATH}]
      Common.main(test3)        
      assert $wait.until{ 
          $browser.find_element(:xpath, ".//*[@id='atsApplicationSubmittedMain'][text()[contains(.,'Your application for')]]") .displayed?   
      }  
end


 #TC106 - Enable Resume Attached to contact record
  def test_EnableResumeAttachContactRecord
    randomName = SecureRandom.hex(4)
  
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
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
    
    $browser.get(HomePage::CONTACTS_TAB_LINK_XPATH)
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
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    CustomSettings.EnableJCardForContact(true)
   
    $browser.get(HomePage::CONTACTS_TAB_LINK_XPATH)
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

#TC990 - Add resume , De-Duplication in a Private Sharing Model, Duplicate candidate No shared
def test_addResumeNoshared
  #Preconditions
  Common.login(Users::USER_EMAIL, Users::PASSWORD)
  $browser.get SetupEditPage::PARSE_SETTINGS_EDIT_URL
   test5 = [{"displayed" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH},
            {"click" => SetupEditPage::PARSE_SETTINGS_EDIT_BUTTON_XPATH}]
   Common.main(test5)     
   $browser.find_element(:xpath, SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH).clear   
   test6 = [{"set_text" => SetupEditPage::JOB_BOARD_DUPE_PREVENTION_XPATH, "text" => "Parse Fields"},
            {"unchecked" => SetupEditPage::ENFORCE_SHARING_CHECKBOX_XPATH},
            {"click" => SetupEditPage::SAVE_BUTTON_XPATH}]
   Common.main(test6)
  $browser.get SetupEditPage::SHARING_SETTINGS_URL
  test2 = [{"displayed" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"click" => SetupEditPage::EDIT_SHARING_SETTINGS_BUTTON_XPATH},
           {"set_text" => SetupEditPage::CONTACT_PICKLIST_XPATH, "text" => "Private"},
           {"click" => SetupEditPage::SHARING_SETTINGS_SAVE_BUTTON_XPATH}]
  Common.main(test2)
  #Steps
  $browser.get HomePage::HOME_TAB_LINK_XPATH
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
           {"upload" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_BROWSE_XPATH, "file" => @@documentPdf},
           {"click" => AddResumePopUpPage::ADD_RESUME_POPUP_BTN_ADD_RESUEM_XPATH}]
  Common.main(test4)
  newWindow= $browser.window_handles[0]
  $browser.switch_to.window(newWindow)
  assert $wait.until{
    $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH).displayed?
  }  
end
=end


end