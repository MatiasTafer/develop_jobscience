require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative 'users.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/contacts/contacts_home_page.rb'
require './New_Automation/pages/contacts/contacts_detail_page.rb'
require './New_Automation/pages/contacts/contacts_new_edit_page.rb'
require './New_Automation/pages/offers/offers_home_page.rb'
require './New_Automation/pages/setup_page.rb'
require './New_Automation/pages/job_board/job_board_home_page.rb'
require './New_Automation/pages/job_board/job_board_job_detail.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'
require_relative 'custom_settings.rb'
require './New_Automation/pages/accounts/accounts_home_page.rb'
require './New_Automation/pages/accounts/accounts_new_edit_page.rb'
require './New_Automation/pages/accounts/accounts_detail_page.rb'
require './New_Automation/pages/search/skill_detail_page.rb'
require './New_Automation/pages/short_lists/short_list_home_page.rb'
require './New_Automation/pages/short_lists/short_list_new_edit_page.rb'
require './New_Automation/pages/short_lists/short_list_detail_page.rb'
require './New_Automation/pages/short_lists/short_list_send_email_popup.rb'
require './New_Automation/pages/short_lists/short_list_review_email_popup.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/search/search_results_page.rb'
require './New_Automation/pages/search/education_history_new_page.rb'
require './New_Automation/pages/search/employment_history_new_page.rb'
require './New_Automation/pages/forward_popup.rb'
require './New_Automation/pages/applications/applications_home_page.rb'
require './New_Automation/pages/applications/applications_detail_page.rb'
require './New_Automation/pages/submittals/submittals_home_page.rb'
require './New_Automation/pages/submittals/submittals_detail_page.rb'
require './New_Automation/pages/interviews/interviews_detail_page.rb'
require './New_Automation/pages/interviews/interviews_home_page.rb'
require './New_Automation/pages/offers/offers_home_page.rb'
require './New_Automation/pages/offers/offers_detail_page.rb'
require './New_Automation/pages/placements/placements_detail_page.rb'
require './New_Automation/pages/placements/placements_home_page.rb'

class TestEmailActions < TestBasic
#=begin
  def test_email_actions_tc1072 #1
    # Application / Forward Application
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 1 - Click on "Applications" Tab
    Common.goToTab(HomePage::APPLICATIONS_TAB_LINK_XPATH)
    test = [
      # 2 - Click on any Application
      {"displayed" => ApplicationsHomePage::FIRST_APPLICATION_RECORD_LIST_XPATH},
      {"click" => ApplicationsHomePage::FIRST_APPLICATION_RECORD_LIST_XPATH},
      # 3 - Click on "Forward Application"
      {"displayed" => ApplicationsDetailPage::FORWARD_APPLICATIONS_BUTTON_XPATH},
      {"click" => ApplicationsDetailPage::FORWARD_APPLICATIONS_BUTTON_XPATH},
      # 4 - Click on any look-up from field "Additional To:", "CC:" or "BCC:"
      {"change_window" => ""},
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      # 5 - Select some contacts from the list of Recipients on left side and send them to the 3 fields in the right side
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      # 8 - Type any text into the Subject and Message fields
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "TEST"},
      # 9 - Select attachments
      
      # 10 - Click on "Send"
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
    
  end
 

  def test_email_actions_tc1073 #2
    # Application / Forward Application, with Template
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Steps
    # 1 - Click on "Applications" Tab
    Common.goToTab(HomePage::APPLICATIONS_TAB_LINK_XPATH)
    test = [
      # 2 - Click on any Application
      {"displayed" => ApplicationsHomePage::FIRST_APPLICATION_RECORD_LIST_XPATH},
      {"click" => ApplicationsHomePage::FIRST_APPLICATION_RECORD_LIST_XPATH},
      # 3 - Click on "Forward Application"
      {"displayed" => ApplicationsDetailPage::FORWARD_APPLICATIONS_BUTTON_XPATH},
      {"click" => ApplicationsDetailPage::FORWARD_APPLICATIONS_BUTTON_XPATH},
      # 4 - Click on any look-up from field "Additional To:", "CC:" or "BCC:"
      {"change_window" => ""},
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      # 5 - Select some contacts from the list of Recipients on left side and send them to the 3 fields in the right side
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      # 8 - Type any text into the Subject and Message fields
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "TEST"},
      # 9 - Select attachments
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"change_window" => ""},
      
      # 10 - Click on "Send"
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
   
  end


  def test_email_actions_tc1074 #3
    # Application / Forward Application, with Template and Attachment
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 1 - Click on "Applications" Tab
    Common.goToTab(HomePage::APPLICATIONS_TAB_LINK_XPATH)
    test = [
      # 2 - Click on any Application
      {"displayed" => ApplicationsHomePage::LABEL_APPLICATION_XPATH},
      {"click" => ApplicationsHomePage::LABEL_APPLICATION_XPATH},
      {"ssleep" => ""},
      {"displayed" => ApplicationsHomePage::FIRST_APPLICATION_RECORD_LIST_XPATH},
      {"click" => ApplicationsHomePage::FIRST_APPLICATION_RECORD_LIST_XPATH},
      
      # 3 - Click on "Forward Application"
      {"displayed" => ApplicationsDetailPage::FORWARD_APPLICATIONS_BUTTON_XPATH},
      {"click" => ApplicationsDetailPage::FORWARD_APPLICATIONS_BUTTON_XPATH},
      # 4 - Click on any look-up from field "Additional To:", "CC:" or "BCC:"
      {"change_window" => ""},
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      # 5 - Select a template
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      # 8 - Type any text into the Subject and Message fields
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "TEST"},
      # 6 - Check an Attachment
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      # 9 - Select attachments
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"change_window" => ""},
      
      # 10 - Click on "Send"
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  

  def test_email_actions_tc1075 #4
    # Application / Forward Application, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 1 - Click on "Applications" Tab
    Common.goToTab(HomePage::APPLICATIONS_TAB_LINK_XPATH)
    test = [
      # 2 - Click on any Application
      #{"displayed" => ApplicationsHomePage::LABEL_APPLICATION_XPATH},
      #{"click" => ApplicationsHomePage::LABEL_APPLICATION_XPATH},
      #{"ssleep" => ""},
      {"displayed" => ApplicationsHomePage::FIRST_APPLICATION_RECORD_LIST_XPATH},
      {"click" => ApplicationsHomePage::FIRST_APPLICATION_RECORD_LIST_XPATH},
      
      # 3 - Click on "Forward Application"
      {"displayed" => ApplicationsDetailPage::FORWARD_APPLICATIONS_BUTTON_XPATH},
      {"click" => ApplicationsDetailPage::FORWARD_APPLICATIONS_BUTTON_XPATH},
      # 4 - Leave all the fields blank      
      {"change_window" => ""},
      # 5 - Click on "Send"
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      # 5 - Select a template
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      # 8 - Type any text into the Subject and Message fields
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "1234567"},
      
      # 10 - Click on "Send"
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
  
  def test_email_actions_tc1076 #5
    # Submittal / Forward Submittal
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 1 - Click on "Submittals" Tab
    Common.goToTab(HomePage::SUBMITTALS_TAB_LINK_XPATH)
    test = [
      # Click on any Submittal
      {"displayed" => SubmittalsHomePage::FIRST_SUBMITTALS_RECORD_LIST_XPATH},
      {"click" => SubmittalsHomePage::FIRST_SUBMITTALS_RECORD_LIST_XPATH},
      # Click on "Forward Submittal"
      {"displayed" => SubmittalsDetailPage::FORWARD_SUBMITTALS_BUTTON_XPATH},
      {"click" => SubmittalsDetailPage::FORWARD_SUBMITTALS_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      # Select a contact in the To field
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      # Type any text into the Subject and Message fields
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      # Select attachments
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      # Click on "Send"
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1077 #6
    # Submittal / Forward Submittal, with Template 
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 1 - Click on "Submittals" Tab
    Common.goToTab(HomePage::SUBMITTALS_TAB_LINK_XPATH)
    test = [
      # Click on any Submittal
      {"displayed" => SubmittalsHomePage::FIRST_SUBMITTALS_RECORD_LIST_XPATH},
      {"click" => SubmittalsHomePage::FIRST_SUBMITTALS_RECORD_LIST_XPATH},
      # Click on "Forward Submittal"
      {"displayed" => SubmittalsDetailPage::FORWARD_SUBMITTALS_BUTTON_XPATH},
      {"click" => SubmittalsDetailPage::FORWARD_SUBMITTALS_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
#=end
  def test_email_actions_tc1078 #7
    # Submittal / Forward Submittal, with Template & Attachment
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 1 - Click on "Submittals" Tab
    Common.goToTab(HomePage::SUBMITTALS_TAB_LINK_XPATH)
    test = [
      # Click on any Submittal
      {"displayed" => SubmittalsHomePage::FIRST_SUBMITTALS_RECORD_LIST_XPATH},
      {"click" => SubmittalsHomePage::FIRST_SUBMITTALS_RECORD_LIST_XPATH},
      # Click on "Forward Submittal"
      {"displayed" => SubmittalsDetailPage::FORWARD_SUBMITTALS_BUTTON_XPATH},
      {"click" => SubmittalsDetailPage::FORWARD_SUBMITTALS_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end


  
  def test_email_actions_tc1079 #8
    # Submittal / Forward Submittal, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 1 - Click on "Submittals" Tab
    Common.goToTab(HomePage::SUBMITTALS_TAB_LINK_XPATH)
    test = [
      # Click on any Submittal
      {"displayed" => SubmittalsHomePage::FIRST_SUBMITTALS_RECORD_LIST_XPATH},
      {"click" => SubmittalsHomePage::FIRST_SUBMITTALS_RECORD_LIST_XPATH},
      # Click on "Forward Submittal"
      {"displayed" => SubmittalsDetailPage::FORWARD_SUBMITTALS_BUTTON_XPATH},
      {"click" => SubmittalsDetailPage::FORWARD_SUBMITTALS_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must select the Contact')]]"},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "1234"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
  
  def test_email_actions_tc1080 #9
    # Interview / Forward Interview 
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Interviews" Tab
    Common.goToTab(HomePage::INTERVIEW_TAB_LINK_XPATH)
    test = [
      # Click on any Interview
      {"displayed" => InterviewsHomePage::INTERVIEW_RECORD_XPATH},
      {"click" => InterviewsHomePage::INTERVIEW_RECORD_XPATH},
      # Click on "Forward Interview"
      {"displayed" => InterviewsDetailPage::FORWARD_INTERVIEW_BUTTON_XPATH},
      {"click" => InterviewsDetailPage::FORWARD_INTERVIEW_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      # 5 - Select some contacts from the list of Recipients on left side and send them to the 3 fields in the right side
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      # 8 - Type any text into the Subject and Message fields
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "TEST"},
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      # 9 - Select attachments
      
      # 10 - Click on "Send"
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1081 #10
    # Interview / Forward Interview, with Template
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Interviews" Tab
    Common.goToTab(HomePage::INTERVIEW_TAB_LINK_XPATH)
    test = [
      # Click on any Interview
      {"displayed" => InterviewsHomePage::INTERVIEW_RECORD_XPATH},
      {"click" => InterviewsHomePage::INTERVIEW_RECORD_XPATH},
      # Click on "Forward Interview"
      {"displayed" => InterviewsDetailPage::FORWARD_INTERVIEW_BUTTON_XPATH},
      {"click" => InterviewsDetailPage::FORWARD_INTERVIEW_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1082 #11
    # Interview / Forward Interview, with Template & Attachments
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Interviews" Tab
    Common.goToTab(HomePage::INTERVIEW_TAB_LINK_XPATH)
    test = [
      # Click on any Interview
      {"displayed" => InterviewsHomePage::INTERVIEW_RECORD_XPATH},
      {"click" => InterviewsHomePage::INTERVIEW_RECORD_XPATH},
      # Click on "Forward Interview"
      {"displayed" => InterviewsDetailPage::FORWARD_INTERVIEW_BUTTON_XPATH},
      {"click" => InterviewsDetailPage::FORWARD_INTERVIEW_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
 

  def test_email_actions_tc1083 #12
    # Interview / Forward Interview, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Interviews" Tab
    Common.goToTab(HomePage::INTERVIEW_TAB_LINK_XPATH)
    test = [
      # Click on any Interview
      {"displayed" => InterviewsHomePage::INTERVIEW_RECORD_XPATH},
      {"click" => InterviewsHomePage::INTERVIEW_RECORD_XPATH},
      # Click on "Forward Interview"
      {"displayed" => InterviewsDetailPage::FORWARD_INTERVIEW_BUTTON_XPATH},
      {"click" => InterviewsDetailPage::FORWARD_INTERVIEW_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must select the Contact')]]"},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "1234"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
   
  def test_email_actions_tc1084 #13
    # Offer / Forward Offer 
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Offers" Tab
    Common.goToTab(HomePage::OFFERS_TAB_LINK_XPATH)
    test = [
      # Click on any Offer
      {"displayed" => OffersHomePage::OFFERS_RECORD_XPATH},
      {"click" => OffersHomePage::OFFERS_RECORD_XPATH},
      # Click on "Forward Interview"
      {"displayed" => OffersDetailPage::FORWARD_OFFER_BUTTON_XPATH},
      {"click" => OffersDetailPage::FORWARD_OFFER_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      # 5 - Select some contacts from the list of Recipients on left side and send them to the 3 fields in the right side
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      # 8 - Type any text into the Subject and Message fields
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "TEST"},
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      # 9 - Select attachments
      
      # 10 - Click on "Send"
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
#=end
  def test_email_actions_tc1085 #14
    # Offer / Forward Offer, with Template
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Offers" Tab
    Common.goToTab(HomePage::OFFERS_TAB_LINK_XPATH)
    test = [
      # Click on any Offer
      {"displayed" => OffersHomePage::OFFERS_RECORD_XPATH},
      {"click" => OffersHomePage::OFFERS_RECORD_XPATH},
      # Click on "Forward Interview"
      {"displayed" => OffersDetailPage::FORWARD_OFFER_BUTTON_XPATH},
      {"click" => OffersDetailPage::FORWARD_OFFER_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
  


  def test_email_actions_tc1086 #15
    # Offer / Forward Offer, with Template & Attachments
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Offers" Tab
    Common.goToTab(HomePage::OFFERS_TAB_LINK_XPATH)
    test = [
      # Click on any Offer
      {"displayed" => OffersHomePage::OFFERS_RECORD_XPATH},
      {"click" => OffersHomePage::OFFERS_RECORD_XPATH},
      # Click on "Forward Interview"
      {"displayed" => OffersDetailPage::FORWARD_OFFER_BUTTON_XPATH},
      {"click" => OffersDetailPage::FORWARD_OFFER_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
  
#=end
  
  def test_email_actions_tc1087 #16
    # Offer / Forward Offer, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Offers" Tab
    Common.goToTab(HomePage::OFFERS_TAB_LINK_XPATH)
    test = [
      # Click on any Offer
      {"displayed" => OffersHomePage::OFFERS_RECORD_XPATH},
      {"click" => OffersHomePage::OFFERS_RECORD_XPATH},
      # Click on "Forward Interview"
      {"displayed" => OffersDetailPage::FORWARD_OFFER_BUTTON_XPATH},
      {"click" => OffersDetailPage::FORWARD_OFFER_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must select the Contact')]]"},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "1234"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1088 #17   
    # Placement / Forward Placement 
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Offers" Tab
    Common.goToTab(HomePage::PLACEMENT_TAB_LINK_XPATH)
    test = [
      # Click on "Placements" Tab
      {"displayed" => PlacementsDetailPage::PLACEMENT_RECORD_XPATH},
      {"click" => PlacementsDetailPage::PLACEMENT_RECORD_XPATH},
      # Click on any Placement
      {"displayed" => PlacementsHomePage::FORWARD_PLACEMENT_BUTTON_XPATH},
      {"click" => PlacementsHomePage::FORWARD_PLACEMENT_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must select the Contact')]]"},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  


  def test_email_actions_tc1089 #18
    # Placement / Forward Placement, with Template
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Offers" Tab
    Common.goToTab(HomePage::PLACEMENT_TAB_LINK_XPATH)
    test = [
      # Click on "Placements" Tab
      {"displayed" => PlacementsDetailPage::PLACEMENT_RECORD_XPATH},
      {"click" => PlacementsDetailPage::PLACEMENT_RECORD_XPATH},
      # Click on any Placement
      {"displayed" => PlacementsHomePage::FORWARD_PLACEMENT_BUTTON_XPATH},
      {"click" => PlacementsHomePage::FORWARD_PLACEMENT_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1090 #19
    # Placement / Forward Placement, with Template & Attachment
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Offers" Tab
    Common.goToTab(HomePage::PLACEMENT_TAB_LINK_XPATH)
    test = [
      # Click on "Placements" Tab
      {"displayed" => PlacementsDetailPage::PLACEMENT_RECORD_XPATH},
      {"click" => PlacementsDetailPage::PLACEMENT_RECORD_XPATH},
      # Click on any Placement
      {"displayed" => PlacementsHomePage::FORWARD_PLACEMENT_BUTTON_XPATH},
      {"click" => PlacementsHomePage::FORWARD_PLACEMENT_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
 
 


  def test_email_actions_tc1091 #20
    # Placement / Forward Placement, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # Click on "Offers" Tab
    Common.goToTab(HomePage::PLACEMENT_TAB_LINK_XPATH)
    test = [
      # Click on "Placements" Tab
      {"displayed" => PlacementsDetailPage::PLACEMENT_RECORD_XPATH},
      {"click" => PlacementsDetailPage::PLACEMENT_RECORD_XPATH},
      # Click on any Placement
      {"displayed" => PlacementsHomePage::FORWARD_PLACEMENT_BUTTON_XPATH},
      {"click" => PlacementsHomePage::FORWARD_PLACEMENT_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must select the Contact')]]"},
      
      {"displayed" => ForwardPopup::TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "2020"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
#=end
  
  def test_email_actions_tc1092 #21
    # Contact / Forward Contact 
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ContactsHomePage::CONTACT_LIST_RECORD_XPATH},
      {"click" => ContactsHomePage::CONTACT_LIST_RECORD_XPATH},
      # 
      {"displayed" => ContactDetailPage::FORWARD_CONTACT_BUTTON_XPATH},
      {"click" => ContactDetailPage::FORWARD_CONTACT_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed_if_exist" => ForwardPopup::SKIP_TO_EMAIL},
      {"click_if_exist" => ForwardPopup::SKIP_TO_EMAIL},
      
      {"displayed" => ForwardPopup::CONTACT_TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::CONTACT_TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::CONTACT_SUBJECT_TEXT_XPATH, "text" => "2020"},
      {"click" => ForwardPopup::CONTACT_SUBJECT_TEXT_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
  
  def test_email_actions_tc1093 #22
    # Contact / Forward Contact, with Template 
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ContactsHomePage::CONTACT_LIST_RECORD_XPATH},
      {"click" => ContactsHomePage::CONTACT_LIST_RECORD_XPATH},
      # 
      {"resume_update" => ""},
      
      {"displayed" => ContactDetailPage::FORWARD_CONTACT_BUTTON_XPATH},
      {"click" => ContactDetailPage::FORWARD_CONTACT_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed_if_exist" => ForwardPopup::SKIP_TO_EMAIL},
      {"click_if_exist" => ForwardPopup::SKIP_TO_EMAIL},
      
      {"displayed" => ForwardPopup::CONTACT_TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::CONTACT_TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::CONTACT_SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::CONTACT_SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::CONTACT_SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"displayed" => ".//*[@id='j_id0:j_id1:j_id2:frm:pbSendEmail:pbsCompleted:j_id94:j_id95:j_id97'][text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  


  def test_email_actions_tc1094 #23
    # Contact / Forward Contact, with Template & Attachment
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ContactsHomePage::CONTACT_LIST_RECORD_XPATH},
      {"click" => ContactsHomePage::CONTACT_LIST_RECORD_XPATH},
      # 
      {"resume_update" => ""},
      # 
      {"displayed" => ContactDetailPage::FORWARD_CONTACT_BUTTON_XPATH},
      {"click" => ContactDetailPage::FORWARD_CONTACT_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed_if_exist" => ForwardPopup::SKIP_TO_EMAIL},
      {"click_if_exist" => ForwardPopup::SKIP_TO_EMAIL},
      
      {"displayed" => ForwardPopup::CONTACT_TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::CONTACT_TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::CONTACT_SUBJECT_TEXT_XPATH, "text" => "2020"},
      
      {"checked" => ForwardPopup::ATTACHMENTS_CHECKBOX_XPATH},
      {"displayed" => ForwardPopup::CONTACT_SELECT_TEMPLATE_BUTTON_XPATH},
      {"click" => ForwardPopup::CONTACT_SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      # Select a contact in the To field
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  
  

  
  def test_email_actions_tc1095 #24
    # Contact / Forward Contact, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    # 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ContactsHomePage::CONTACT_LIST_RECORD_XPATH},
      {"click" => ContactsHomePage::CONTACT_LIST_RECORD_XPATH},
      # 
      {"resume_update" => ""},
      # 
      {"displayed" => ContactDetailPage::FORWARD_CONTACT_BUTTON_XPATH},
      {"click" => ContactDetailPage::FORWARD_CONTACT_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed_if_exist" => ForwardPopup::SKIP_TO_EMAIL},
      {"click_if_exist" => ForwardPopup::SKIP_TO_EMAIL},
            
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must select the Contact')]]"},
      
      {"displayed" => ForwardPopup::CONTACT_TO_TEXT_XPATH},
      {"set_text" => ForwardPopup::CONTACT_TO_TEXT_XPATH, "text" => "John Smith"},
      {"set_text" => ForwardPopup::CONTACT_SUBJECT_TEXT_XPATH, "text" => "2020"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      
      {"change_window" => ""},
    ]
    Common.main(test)
  end
  

  
  
  def test_email_actions_tc1096 #25
    # Short List / Send E-mail 
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Enable Review Email= true
    Common.go_to_short_list(edit=true)
    test = [
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_SEND_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_SEND_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      {"displayed" => ShortListSendEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListSendEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Your emails have been queued for sending.')]]"},
    ]
    Common.main(test)
  end
  

  def test_email_actions_tc1097 #26
    # Short List / Send E-mail, with Template
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Enable Review Email= true
    Common.go_to_short_list(edit=true)
    test = [
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_SEND_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_SEND_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      {"displayed" => ShortListSendEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListSendEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      #{"checked" => ShortListSendEmailPopup::RECORD_ATTACHMENT_XPATH},
      {"click" => ShortListSendEmailPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Your emails have been queued for sending.')]]"},
     
    ]
    Common.main(test)
  end
 
 


  
  def test_email_actions_tc1098 #27
    # Short List / Send E-mail, with Template & Attachment
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_short_list(edit=true)
    test = [
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_SEND_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_SEND_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      {"displayed" => ShortListSendEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListSendEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      #{"checked" => ShortListSendEmailPopup::RECORD_ATTACHMENT_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
     
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListSendEmailPopup::SEND_BUTTON_XPATH},
      {"click" => ShortListSendEmailPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Your emails have been queued for sending.')]]"},
     
    ]
    Common.main(test)
  end
  


  
  def test_email_actions_tc1099 #28
    # Short List / Send E-mail, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_short_list(edit=true)
    test = [
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    # 
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_SEND_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_SEND_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListSendEmailPopup::SEND_BUTTON_XPATH},
      {"click" => ShortListSendEmailPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must enter the Subject')]]"},
     
    ]
    Common.main(test)
  end




  
  
  def test_email_actions_tc1100 #29 
    # Short List / Review Email - Standard, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    # Custom Settings -> Short List -> Enable Review Email= true
    Common.go_to_short_list(edit=true)
    test = [
      # 
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH},
    ]
    Common.main(test)
    # Steps
    # 
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Review E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      # Check "Standard" box
      {"displayed" => ShortListReviewEmailPopup::STANDART_CHECKBOX_XPATH},
      {"checked" => ShortListReviewEmailPopup::STANDART_CHECKBOX_XPATH},
      # Click on "Send Email"
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must enter the Subject')]]"},
      {"set_text" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH, "text" => "00eb46d1"},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "00eb46d1"},
      
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must enter the Subject')]]"},
      #
    ]
    Common.main(test)
  end
 
#=end

  
  def test_email_actions_tc1101 #30    *
    # Short List / Review Email - Staffing, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    # Custom Settings -> Short List -> Review Mode = 3
    Common.go_to_short_list(edit=true)
    test = [
      # 
      {"displayed" => SetupEditPage::REVIEW_MODE_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"checked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_SHORT_LIST_XPATH},
    ]
    Common.main(test)
    # Steps
    # 
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::ADD_CANDIDATE_BUTTON_XPATH},
      {"click" => ShortListReviewEmailPopup::ADD_CANDIDATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"set_text" => ShortListReviewEmailPopup::CONTACT_ADD_CANDIDATE_XPATH, "text" => "maggie simpson"},
      {"click" => ShortListReviewEmailPopup::ADD_TO_REVIEW_XPATH},
      
      {"change_window" => ""},
      #{"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::ADD_CANDIDATE_BUTTON_XPATH},
      {"click" => ShortListReviewEmailPopup::ADD_CANDIDATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"set_text" => ShortListReviewEmailPopup::CONTACT_ADD_CANDIDATE_XPATH, "text" => "maggie simpson"},
      {"click" => ShortListReviewEmailPopup::ADD_TO_REVIEW_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test)
    
  end
  


  
  def test_email_actions_tc1102 #31       *
    # Short List / Review Email - Standard, External & Internal
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    # Custom Settings -> Short List -> Review Mode = 3
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "EXTERNAL"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    # 
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test)
    
    Common.go_to_short_list(edit=true)
    test = [
      
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH, "text" => "test"},
      # 
      {"set_text" => ShortListReviewEmailPopup::TO_USER_TEXT_XPATH, "text" => "Naomi Kihara"},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test)
    
    
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "Both"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH},
      {"set_text_exist" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH, "text" => "test"},
      # 
      {"set_text_exist" => ShortListReviewEmailPopup::TO_USER_TEXT_XPATH, "text" => "Naomi Kihara"},
      {"set_text" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH, "text" => "maggie simpson"},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test)
    
  end
 
#=begin

  
  def test_email_actions_tc1103 #32    *
    # Short List / Review Email - External & Internal, Internal with Template
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "EXTERNAL"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    # 
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text_exist" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"set_text" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH, "text" => "maggie simpson"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"displayed" => ShortListDetailPage::CLOSE_BUTTON_XPATH},
      {"click" => ShortListDetailPage::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
    Common.goToTab(HomePage::HOME_TAB_ID)
    Common.go_to_short_list(edit=true)
    test = [
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH, "text" => "test"},
      # 
      {"set_text_exist" => ShortListReviewEmailPopup::TO_USER_TEXT_XPATH, "text" => "Naomi Kihara"},
      {"set_text" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH, "text" => "maggie simpson"},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test)
    
    
    Common.go_to_short_list(edit=true)
    test = [
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "Both"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH, "text" => "test"},
      # 
      {"set_text" => ShortListReviewEmailPopup::TO_USER_TEXT_XPATH, "text" => "Naomi Kihara"},
      {"set_text" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH, "text" => "maggie simpson"},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test)
    
  end
  


#=begin
  

  def test_email_actions_tc1104 #33    *
    # Short List / Review Email - Standard, External & Internal with Template & Attachment
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    Common.go_to_short_list(edit=true)
    test = [
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "EXTERNAL"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    # 
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test)
    
    Common.go_to_short_list(edit=true)
    test = [
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH, "text" => "test"},
      # 
      {"set_text" => ShortListReviewEmailPopup::TO_USER_TEXT_XPATH, "text" => "Naomi Kihara"},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test)
    
    
    Common.go_to_short_list(edit=true)
    test = [
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "Both"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH, "text" => "test"},
      # 
      {"set_text" => ShortListReviewEmailPopup::TO_USER_TEXT_XPATH, "text" => "Naomi Kihara"},
      {"set_text" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH, "text" => "maggie simpson"},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
    ]
    Common.main(test) 
    
  end
  
  
 
  
  def test_email_actions_tc1105 #34  
    # Applications / Send Email
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # Steps
    # 
    Common.goToTab(HomePage::APPLICATIONS_TAB_LINK_XPATH)
    test = [
      # APP-010616-04441, .//span[text()[contains(.,'APP-010616-04441')]] 6d620642
      
      # Click on "Send E-mail" on the menu
      {"displayed" => ApplicationsHomePage::FIRST_APPLICATION_CHECKBOX_XPATH},
      {"click" => ApplicationsHomePage::FIRST_APPLICATION_CHECKBOX_XPATH},
      
      {"click" => ApplicationsHomePage::SEND_MAIL_MASS_BUTTON_XPATH},
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1106 #35  
    # Applications / Send Email, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    Common.goToTab(HomePage::APPLICATIONS_TAB_LINK_XPATH)
    test = [
      # Click on "Send E-mail" on the menu
      {"displayed" => ApplicationsHomePage::FIRST_APPLICATION_CHECKBOX_XPATH},
      {"click" => ApplicationsHomePage::FIRST_APPLICATION_CHECKBOX_XPATH},
      
      {"click" => ApplicationsHomePage::SEND_MAIL_MASS_BUTTON_XPATH},
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must enter the Subject')]]"},
      {"click" => ForwardPopup::CANCEL_BUTTON_XPATH},
      #{"change_window" => ""},
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1107 #36   *
    # Submittals / Send Email
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    Common.goToTab(HomePage::SUBMITTALS_TAB_LINK_XPATH)
    test = [
      #
      {"displayed" => SubmittalsHomePage::SEND_EMAIL_XPATH},
      {"click" => SubmittalsHomePage::SEND_EMAIL_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::BCC_EMAIL_CANDIDATE_XPATH},
      {"set_text" => ForwardPopup::BCC_EMAIL_CANDIDATE_XPATH, "text" => ""},
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
     
      #{"change_window" => ""},
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  


  
  def test_email_actions_tc1108 #37    *
    # Submittals / Send Email, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    Common.goToTab(HomePage::SUBMITTALS_TAB_LINK_XPATH)
    test = [
      #
      {"displayed" => ".//*[@id='a0go0000003k7Gk_00No0000008HtlV']/a[1]/img"},
      {"click" => ".//*[@id='a0go0000003k7Gk_00No0000008HtlV']/a[1]/img"},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::BCC_EMAIL_CANDIDATE_XPATH},
      {"set_text" => ForwardPopup::BCC_EMAIL_CANDIDATE_XPATH, "text" => "1234"},
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"set_text" => ForwardPopup::BCC_EMAIL_CANDIDATE_XPATH, "text" => ""},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      #{"change_window" => ""},
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  


  
  def test_email_actions_tc1109 #38  
    # Interviews / Send Email
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    Common.goToTab(HomePage::INTERVIEW_TAB_LINK_XPATH)
    test = [
      #
      {"displayed" => InterviewsHomePage::CHECKBOX_FIRST_RECORD_XPATH},
      {"click" => InterviewsHomePage::CHECKBOX_FIRST_RECORD_XPATH},
      {"click" => InterviewsHomePage::MASS_EMAIL_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  
  

  
  def test_email_actions_tc1110 #39 
    # Interviews / Send Email, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    Common.goToTab(HomePage::INTERVIEW_TAB_LINK_XPATH)
    test = [
      #
      {"displayed" => InterviewsHomePage::CHECKBOX_FIRST_RECORD_XPATH},
      {"click" => InterviewsHomePage::CHECKBOX_FIRST_RECORD_XPATH},
      {"click" => InterviewsHomePage::MASS_EMAIL_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must enter the Subject')]]"},
      {"click" => ForwardPopup::CANCEL_BUTTON_XPATH},
      
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1111 #40 
    # Offers / Send Email
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "1"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"checked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    
    # Steps
    Common.goToTab(HomePage::OFFERS_TAB_LINK_XPATH)
    test = [
      #
      {"displayed" => OffersHomePage::GO_BUTTON_XPATH},
      {"click" => OffersHomePage::GO_BUTTON_XPATH},
      
      {"displayed" => OffersHomePage::CHECKBOX_FIRST_RECORD_XPATH},
      {"click" => OffersHomePage::CHECKBOX_FIRST_RECORD_XPATH},
      {"click" => OffersHomePage::MASS_EMAIL_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      #{"displayed_if_exist" => ForwardPopup::BCC_TEXT_XPATH},
      #{"set_text" => ForwardPopup::BCC_TEXT_XPATH, "text" => " "},
      {"displayed" => ForwardPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  
  

  
  def test_email_actions_tc1112 #41 
    # Offers / Send Email, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Preconditions
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "1"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"checked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    
    # Steps
    Common.goToTab(HomePage::OFFERS_TAB_LINK_XPATH)
    test = [
      #
      {"displayed" => OffersHomePage::GO_BUTTON_XPATH},
      {"click" => OffersHomePage::GO_BUTTON_XPATH},
      
      {"displayed" => OffersHomePage::CHECKBOX_FIRST_RECORD_XPATH},
      {"click" => OffersHomePage::CHECKBOX_FIRST_RECORD_XPATH},
      {"click" => OffersHomePage::MASS_EMAIL_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must enter the Subject')]]"},
      #{"displayed" => ForwardPopup::BCC_TEXT_XPATH},
      #{"set_text" => ForwardPopup::BCC_TEXT_XPATH, "text" => ""},
      {"displayed" => ForwardPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      
      {"displayed" => ForwardPopup::CLOSE_BUTTON_XPATH},
      {"click" => ForwardPopup::CLOSE_BUTTON_XPATH},
      
      {"change_window" => ""},
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  
  

  
  def test_email_actions_tc1113 #42 
    # Placements / Send Email
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    Common.goToTab(HomePage::PLACEMENT_TAB_LINK_XPATH)
    test = [
      #
      {"displayed" => PlacementsHomePage::GO_BUTTON_XPATH},
      {"click" => PlacementsHomePage::GO_BUTTON_XPATH},
      {"displayed" => PlacementsHomePage::SECOND_RECORD_XPATH},
      {"click" => PlacementsHomePage::SECOND_RECORD_XPATH},
      {"click" => PlacementsHomePage::SEND_MAIL_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  

  
  def test_email_actions_tc1114 #43 
    # Placements / Send Email, Validation
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
   
    # Steps
    Common.goToTab(HomePage::PLACEMENT_TAB_LINK_XPATH)
    test = [
      #
      {"displayed" => PlacementsHomePage::GO_BUTTON_XPATH},
      {"click" => PlacementsHomePage::GO_BUTTON_XPATH},
      {"displayed" => PlacementsHomePage::SECOND_RECORD_XPATH},
      {"click" => PlacementsHomePage::SECOND_RECORD_XPATH},
      {"click" => PlacementsHomePage::SEND_MAIL_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::SEND_BUTTON_XPATH},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'You must enter the Subject')]]"},
      {"set_text" => ForwardPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ForwardPopup::SEND_BUTTON_XPATH},
      {"displayed" => ".//*[text()[contains(.,'Email(s) have been sent successfully.')]]"},
      
      {"change_window" => ""},
      #
    ]
    Common.main(test)
  end
  


  
  def test_email_actions_tc1138 #44 
    # Send Review email with internal mode, review mode 1
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # PRECONDITIONS
    # MassMail custom setting must be DISABLED
    Common.go_to_massmail_service(edit=true)
    test = [
      #
      {"displayed" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"unchecked" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # 
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "1"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH, "text" => "test"},
      # 
      {"set_text" => ShortListReviewEmailPopup::TO_USER_TEXT_XPATH, "text" => "Naomi Kihara"},
      #{"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
  end
  
  
  def test_email_actions_tc1139 #45    
    # Send Review email, internal mode, review mode 2
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # PRECONDITIONS
    # MassMail custom setting must be DISABLED
    #Common.go_to_massmail_service(edit=true)
    test = [
      #
      {"displayed" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"unchecked" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    #Common.main(test)
    # 
    #Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::CHECKBOX_ENABLE_JOBSCIENCE_UI_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "2"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    #Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::ADD_CANDIDATE_BUTTON_XPATH},
      {"click" => ShortListReviewEmailPopup::ADD_CANDIDATE_BUTTON_XPATH},
      
      {"change_frame" => ""},
      {"change_window" => ""},
      
      {"set_text" => ShortListReviewEmailPopup::CONTACT_ADD_CANDIDATE_XPATH, "text" => "maggie simpson"},
      {"click" => ShortListReviewEmailPopup::ADD_TO_REVIEW_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      #{"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
  end

#=begin

  def test_email_actions_tc1140 #46 
    # Send Review email, internal mode, review mode 3, default staffing = FALSE
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # PRECONDITIONS
    # MassMail custom setting must be DISABLED
    Common.go_to_massmail_service(edit=true)
    test = [
      #
      {"displayed" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"unchecked" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # 
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_REVIEW_EMAIL_XPATH, "text" => "test"},
      # 
      {"set_text" => ShortListReviewEmailPopup::TO_USER_TEXT_XPATH, "text" => "Naomi Kihara"},
      #{"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
  end
  


  
  def test_email_actions_tc1141 #47 
    # Send Review email, internal mode, review mode 3, default staffing = TRUE
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # PRECONDITIONS
    # MassMail custom setting must be DISABLED
    Common.go_to_massmail_service(edit=true)
    test = [
      #
      {"displayed" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"unchecked" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # 
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "INTERNAL"},
      {"checked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      #{"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
  end
  



  def test_email_actions_tc1142 #48 
    # Send Review email with external mode, review mode 1
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # PRECONDITIONS
    # MassMail custom setting must be DISABLED
    Common.go_to_massmail_service(edit=true)
    test = [
      #
      {"displayed" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"unchecked" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # 
    Common.go_to_short_list(edit=true)
    test = [
      #
      
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "1"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "EXTERNAL"},
      {"checked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH, "text" => "maggie simpson"},
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      #{"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
  end
  
  

  
  def test_email_actions_tc1143 #49 
    # Send Review email, external mode, review mode 2
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # PRECONDITIONS
    # MassMail custom setting must be DISABLED
    Common.go_to_massmail_service(edit=true)
    test = [
      #
      {"displayed" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"unchecked" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # 
    Common.go_to_short_list(edit=true)
    test = [
      #
      
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "2"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "EXTERNAL"},
      {"checked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      
      {"displayed" => ShortListReviewEmailPopup::ADD_CANDIDATE_BUTTON_XPATH},
      {"click" => ShortListReviewEmailPopup::ADD_CANDIDATE_BUTTON_XPATH},
      
      {"change_window" => ""},
      
      {"set_text" => ShortListReviewEmailPopup::CONTACT_ADD_CANDIDATE_XPATH, "text" => "maggie simpson"},
      {"click" => ShortListReviewEmailPopup::ADD_TO_REVIEW_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
  end
  
  

  
  def test_email_actions_tc1144 #50 
    # Send Review email, external mode, review mode 3, default staffing = FALSE
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # PRECONDITIONS
    # MassMail custom setting must be DISABLED
    Common.go_to_massmail_service(edit=true)
    test = [
      #
      {"displayed" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"unchecked" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # 
    Common.go_to_short_list(edit=true)
    test = [
      #
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "EXTERNAL"},
      {"unchecked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::TO_CONTACT_TEXT_XPATH, "text" => "maggie simpson"},
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
  end
  
  

  
  def test_email_actions_tc1145 #51 
    # Send Review email, external mode 3, default staffing = TRUE
    # Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    # PRECONDITIONS
    # MassMail custom setting must be DISABLED
    Common.go_to_massmail_service(edit=true)
    test = [
      #
      {"displayed" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"unchecked" => SetupEditPage::ENABLE_MASS_MAIL_CHECKBOX_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # 
    Common.go_to_short_list(edit=true)
    test = [
      #
      
      # REVIEW EMAIL SEND OPTIONS = INTERNAL
      {"displayed" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"checked" => SetupEditPage::ENABLE_REVIEW_EMAIL_CHECKBOX_XPATH},
      {"set_text" => SetupEditPage::REVIEW_MODE_XPATH, "text" => "3"},
      {"set_text" => SetupEditPage::ENABLE_EMAIL_SEND_OPTIONS_XPATH, "text" => "EXTERNAL"},
      {"checked" => SetupEditPage::DEFAULT_STAFFING_REVIEW_XPATH},
      {"click" => SetupEditPage::SAVE_BUTTON_XPATH},
    ]
    Common.main(test)
    # Steps
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
    test = [
      # 
      {"displayed" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      {"click" => ShortListHomePage::FIRST_RECORD_CHECKBOX_XPATH},
      
      {"displayed" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      {"click" => ShortListDetailPage::CHECKBOX_ELEMENT_XPATH},
      # Click on "Send E-mail" on the menu
      {"displayed" => ShortListDetailPage::SL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_MENU_XPATH},
      {"displayed" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      {"click" => ShortListDetailPage::SL_REVIEW_EMAIL_MENU_XPATH},
      #
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH},
      {"set_text" => ShortListReviewEmailPopup::SUBJECT_TEXT_XPATH, "text" => "test"},
      {"click" => ShortListSendEmailPopup::SELECT_TEMPLATE_BUTTON_XPATH},
      # 
      {"change_window" => ""},
      
      {"displayed" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      {"click" => ForwardPopup::FIRST_ELEMENT_SELECT_TEMPLATE_XPATH},
      
      {"change_window" => ""},
      {"change_frame" => ""},
      
      {"displayed" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      {"checked" => ShortListReviewEmailPopup::ATTACHMENT_CHECKBOX_XPATH},
      {"click" => ShortListReviewEmailPopup::SEND_EMAIL_BUTTON_XPATH},
      
      {"change_frame" => ""},
      
    ]
    Common.main(test)
    
  end
  
#=end
end