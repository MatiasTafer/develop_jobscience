require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require './New_Automation/tests/test_basic.rb'
require './New_Automation/tests/common.rb'
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
require './New_Automation/tests/custom_settings.rb'
require './New_Automation/pages/accounts/accounts_home_page.rb'
require './New_Automation/pages/accounts/accounts_new_edit_page.rb'
require './New_Automation/pages/accounts/accounts_detail_page.rb'
require './New_Automation/pages/search/skill_detail_page.rb'
require './New_Automation/pages/short_lists/short_list_home_page.rb'
require './New_Automation/pages/short_lists/short_list_new_edit_page.rb'
require './New_Automation/pages/short_lists/short_list_detail_page.rb'
require './New_Automation/pages/requisitions/requisitions_home_page.rb'
require './New_Automation/pages/requisitions/requisitions_new_and_edit.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'
require './New_Automation/pages/search/search_results_page.rb'
require './New_Automation/pages/search/education_history_new_page.rb'
require './New_Automation/pages/search/employment_history_new_page.rb'

class TestActions < TestBasic

  #TC263 - Add to List (New) on Skill section in Search
  def test_SearchSkillAddToNewList
    randomContact = "0" + SecureRandom.hex(4)
    randomSL = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one skill asociated
    AddSkillToContact(randomContact, SearchResultsPage::SEARCH_DATA_SKILL_ARCH_TEXT )
    
    sleep(20) ### Must have time for asociate record with contact
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
   
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search one skill.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => SearchResultsPage::SEARCH_DATA_SKILL_ARCH_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Skills"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_SKILLS_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    sleep(2)
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../..//input").click
    
    # 5. Click on "Add to List"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_ADD_TO_LIST_XPATH).click 
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Enter a value in the fields: "Name (required) an "Description" (optional). 
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NEW_NAME_INPUT_XPATH, "text" => randomSL},
    # 7. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH).text)
 
    test = [ 
    # 8. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 9. Click on Short List tab
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 10. Click on name of short list created
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    #assert $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]").click
    assert Common.click_and_load(ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]")
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    

  end
 
#TC264 - Add to List (Existing) on Skill section in Search
  def test_SearchSkillAddToExistingList
    randomContact = "0" + SecureRandom.hex(4)
    randomSL = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    home_url = $browser.current_url
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one skill asociated
    AddSkillToContact(randomContact, SearchResultsPage::SEARCH_DATA_SKILL_ARCH_TEXT )
    
    $browser.get(home_url)
    #At least one short list must exist 
    Common.CreateShortList(randomSL)
        
    sleep(15) ### Must have time for asociate record with contact
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
   
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search one skill.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => SearchResultsPage::SEARCH_DATA_SKILL_ARCH_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Skills"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_SKILLS_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    sleep(2)
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../..//input").click
    
    # 5. Click on "Add to List"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_ADD_TO_LIST_XPATH).click
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Enter a value in the field "Short List". 
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH, "text" => randomSL},
    # 7. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH).text)
 
    test = [ 
    # 8. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 9. Click on Short List tab
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 10. Click on name of short list created
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]").click
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    
   
  end


  #TC265 - Add to List (New) on "Education History" section in Search
  def test_SearchEducationAddToNewList
    randomContact = SecureRandom.hex(4)
    randomSL = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one education history record asociated
    recordEdu = AddEducationRecordToContact(randomContact, EducationHistoryNewPage::EDU_HISTORY_DATA_SCHOOL_NAME_TEXT)
    
    sleep(20) ### Must have time for asociate record with contact
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
   
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search education history record.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => EducationHistoryNewPage::EDU_HISTORY_DATA_SCHOOL_NAME_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Education History"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_EDU_HISTORY_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    Common.set_text(SearchResultsPage::SEARCH_RESULT_FILTER_CONTACT_XPATH, randomContact)
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    Common.click(SearchResultsPage::SEACRH_RESULT_APPLY_FILTERS_XPATH)
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + recordEdu + "')]]/../..//input").displayed?
    }
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + recordEdu + "')]]/../..//input").click
    
    # 5. Click on "Add to List"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_ADD_TO_LIST_XPATH).click
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Enter a value in the fields: "Name (required) an "Description" (optional). 
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NEW_NAME_INPUT_XPATH, "text" => randomSL},
    # 7. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH).text)
 
    test = [ 
    # 8. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 9. Click on Short List tab
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 10. Click on name of short list created
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]").click
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    sleep(2)
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    

  end

#TC266 - Add to List (Existing) on "Education History" section in Search
  def test_SearchEducationAddToExistingList
    randomContact = SecureRandom.hex(4)
    randomSL = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    home_url = $browser.current_url
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one education history record asociated
    recordEdu = AddEducationRecordToContact(randomContact, EducationHistoryNewPage::EDU_HISTORY_DATA_SCHOOL_NAME_TEXT)
    
    #At least one short list must exist 
    Common.CreateShortList(randomSL)
    $browser.get(home_url)
    
    sleep(15) ### Must have time for asociate record with contact
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
   
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search education history record.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => EducationHistoryNewPage::EDU_HISTORY_DATA_SCHOOL_NAME_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH}
      ] 
    Common.main(test)
    sleep(2)
    test = [
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Education History"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_EDU_HISTORY_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    Common.set_text(SearchResultsPage::SEARCH_RESULT_FILTER_CONTACT_XPATH, randomContact)
    Common.click(SearchResultsPage::SEACRH_RESULT_APPLY_FILTERS_XPATH)
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + recordEdu + "')]]/../..//input").displayed?
    }
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + recordEdu + "')]]/../..//input").click
    
    # 5. Click on "Add to List"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_ADD_TO_LIST_XPATH).click
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Enter a value in the field "Short List". 
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH, "text" => randomSL},
    # 7. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH).text)
 
    test = [ 
    # 8. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 9. Click on Short List tab
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 10. Click on name of short list created
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]").click
   
   sleep(3)
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
    
   
  end


  #TC267 - Add to List (New) on "Employment History" section in Search
  def test_SearchEmploymentAddToNewList
    randomContact = SecureRandom.hex(4)
    randomSL = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one employment history record asociated
    AddEmploymentRecordToContact(randomContact, EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_EMPLOYER_NAME_TEXT, EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_JOB_TITLE_TEXT)
    
    sleep(20) ### Must have time for asociate record with contact
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
   
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search education history record.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_EMPLOYER_NAME_TEXT + " " + EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_JOB_TITLE_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Employment History"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_EMP_HISTORY_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    Common.set_text(SearchResultsPage::SEARCH_RESULT_FILTER_CONTACT_XPATH, randomContact)
    Common.click(SearchResultsPage::SEACRH_RESULT_APPLY_FILTERS_XPATH)
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    
    Common.displayed(SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]")
    
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../..//input").click
    
    # 5. Click on "Add to List"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_ADD_TO_LIST_XPATH).click
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Enter a value in the fields: "Name (required) an "Description" (optional). 
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NEW_NAME_INPUT_XPATH, "text" => randomSL},
    # 7. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH).text)
 
    test = [ 
    # 8. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 9. Click on Short List tab
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 10. Click on name of short list created
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]").click
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
   
  end 

  #TC268 - Add to List (Existing) on "Employment History" section in Search
  def test_SearchEmploymentAddToExistingList
    randomContact = SecureRandom.hex(4)
    randomSL = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    home_url = $browser.current_url
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one employment history record asociated
    AddEmploymentRecordToContact(randomContact, EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_EMPLOYER_NAME_TEXT, EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_JOB_TITLE_TEXT)
    
    #At least one short list must exist 
    Common.CreateShortList(randomSL)
    $browser.get(home_url)
    
    sleep(20) ### Must have time for asociate record with contact
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
   
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search education history record.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_EMPLOYER_NAME_TEXT + " " + EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_JOB_TITLE_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Employment History"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_EMP_HISTORY_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    Common.set_text(SearchResultsPage::SEARCH_RESULT_FILTER_CONTACT_XPATH, randomContact)
    Common.click(SearchResultsPage::SEACRH_RESULT_APPLY_FILTERS_XPATH)
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../..//input").displayed?
    }
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../..//input").click
    
    # 5. Click on "Add to List"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_ADD_TO_LIST_XPATH).click
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Enter a value in the fields: "Name (required) an "Description" (optional). 
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_LIST_POPUP_NAME_INPUT_XPATH, "text" => randomSL},
    # 7. Click on "Add to Short list"   
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    assert_equal("1", $browser.find_element(:xpath => ContactsHomePage::CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH).text)
 
    test = [ 
    # 8. Click "Close"     
      {"click" => ContactsHomePage::CONTACT_LIST_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test)
    
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
    
    # 9. Click on Short List tab
    Common.goToTab(HomePage::SHORT_LIST_TAB_LINK_XPATH)
   
    # 10. Click on name of short list created
    $wait.until {
      $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH).displayed?
    }
    assert $browser.find_element(:xpath => ShortListHomePage::SHORT_LIST_RECORDS_LIST_XPATH + "//*[text()[contains(.,'" + randomSL + "')]]").click
   
    test = [
      {"displayed" => ShortListDetailPage::SL_LIST_XPATH},
    ]
    Common.main(test)
    
    assert $wait.until {
      $browser.find_element(:xpath, "//*[text()[contains(.,'" + randomContact + "')]]").displayed?
    }
   
  end

  #TC269 - Apply to jobs on Skill section by Search
  def test_SearchSkillApplyToJob
    randomContact = SecureRandom.hex(4)
    randomReq = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one skill asociated
    AddSkillToContact(randomContact, SearchResultsPage::SEARCH_DATA_SKILL_ARCH_TEXT)
    
    # Job with "Post job" = true
    Common.CreateRequisitionPostJob(randomReq, true)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    CustomSettings.EnableJCardForContact(false)
    
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
    sleep(15) ### Must have time for asociate record with contact
    
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search one skill.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => SearchResultsPage::SEARCH_DATA_SKILL_ARCH_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Skills"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_SKILLS_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    sleep(2)
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../..//input").click
    
    # 5. Click on "Apply to Job"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_APPLY_TO_JOB_XPATH).click
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Select the Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 7. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 8. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 9. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
    # 10. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
    ]  
    Common.main(test)
    
    assert_equal(randomContact.encode!('UTF-8', 'US-ASCII'), $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_SUCCESS_CANDIDATE_XPATH).text)

    test = [
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
  
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
        
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
    }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
    }  
   
  end    

  #TC270 - Apply to jobs on Education History section by Search
  def test_SearchEducationlApplyToJob
    randomContact = SecureRandom.hex(4)
    randomReq = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one education history record asociated
    recordEdu = AddEducationRecordToContact(randomContact, EducationHistoryNewPage::EDU_HISTORY_DATA_SCHOOL_NAME_TEXT)
    
    # Job with "Post job" = true
    Common.CreateRequisitionPostJob(randomReq, true)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    CustomSettings.EnableJCardForContact(false)
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
    
    sleep(15)### Must have time for asociate record with contact
    
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search education history record.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => EducationHistoryNewPage::EDU_HISTORY_DATA_SCHOOL_NAME_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Education History"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_EDU_HISTORY_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    sleep(2)
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + recordEdu + "')]]/../..//input[1]").click
    
    # 5. Click on "Apply to Job"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_APPLY_TO_JOB_XPATH).click
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Select the Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 7. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 8. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 9. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
    # 10. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
    ]  
    Common.main(test)
    
    assert_equal(randomContact.encode!('UTF-8', 'US-ASCII'), $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_SUCCESS_CANDIDATE_XPATH).text)
    # 11. Close popup
    test = [
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
  
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
        
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
    }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
    }  
   
  end 

  #TC271 - Apply to jobs on Employment History section in Search
  def test_SearchEmploymentApplyToJob
    randomContact = SecureRandom.hex(4)
    randomReq = SecureRandom.hex(4)
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(randomContact) 
    
    #At least one contact must exist 
    Common.CreateContact(randomContact, randomContact)
    
    #Contact must have one employment history record asociated
    AddEmploymentRecordToContact(randomContact, EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_EMPLOYER_NAME_TEXT, EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_JOB_TITLE_TEXT)
    
    # Job with "Post job" = true
    Common.CreateRequisitionPostJob(randomReq, true)
    
    #Enable Enhanced Apply to Job" = True
    Common.go_to_custom_settings()
    CustomSettings.EnableEnhancedApplyToJob(true)
    CustomSettings.EnableJCardForContact(false)
    
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
    
    sleep(15)### Must have time for asociate record with contact
    
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search education history record.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_EMPLOYER_NAME_TEXT + " " + EmploymentHistoryNewPage::EMPLOYMENT_HIST_DATA_JOB_TITLE_TEXT},
    # 2. Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 3. Click on left side in "Education History"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_EMP_HISTORY_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    
    Common.set_text(SearchResultsPage::SEARCH_RESULT_FILTER_CONTACT_XPATH, randomContact)
    Common.click(SearchResultsPage::SEACRH_RESULT_APPLY_FILTERS_XPATH)
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../..//input[1]").displayed?
    }
    
    # 4. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]/../..//input[1]").click
    
    # 5. Click on "Apply to Job"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_APPLY_TO_JOB_XPATH).click
    
    sleep(3)
    #A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
    # 6. Select the Job
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH},
      {"set_text" => ContactsHomePage::CONTACT_JOB_POPUP_JOB_TITLE_XPATH, "text" => randomReq},
    # 7. Click "Next" 
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_NEXT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_INVITE_XPATH},
    # 8. Click on Exception   
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_XPATH},
    # 9. Select Referral in picklist  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH},
    # 10. Click "Save"  
      {"click" => ContactsHomePage::CONTACT_JOB_POPUP_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_JOB_POPUP_TOTAL_APP_XPATH},
    ]  
    Common.main(test)
    
    
    assert_equal(randomContact.encode!('UTF-8', 'US-ASCII'), $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_SUCCESS_CANDIDATE_XPATH).text)
    # 11. Close popup
    test = [
    {"click" => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH} 
      ]
    Common.main(test)
  
    newWindow2= $browser.window_handles.first
    $browser.switch_to.window(newWindow2)
        
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + randomContact + "')]]").click
    $wait.until {
          $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH).displayed?
    }
  
    assert $wait.until {
        $browser.find_element(:xpath, ContactDetailPage::CONTACT_DETAIL_APPLICATIONS_LIST_XPATH + "//*[text()[contains(.,'" + randomReq + "')]]").displayed?
    }  
    
    
  end


=begin 
          PENDING AUTOMATION - Error ocurr on the process, It was indicated to leave it in Pending Automation state 
               
  #TC272 - Add to Skill on Education History section in Search
  def test_SearchEducationlAddSkills
    
    #PRECONDITIONS
    #Login
    Common.login(Users::USER_EMAIL, Users::PASSWORD)
    
    #At least one account must exist
    Common.CreateAccount(ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT) 
    
    #At least one contact must exist 
    Common.CreateContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, ContactNewEditPage::CONTACT_NEW_DATA_ACCOUNT_NAME_TEXT)
    
    #Contact must have one education history record asociated
    AddEducationRecordToContact(ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT, EducationHistoryNewPage::EDU_HISTORY_DATA_SCHOOL_NAME_TEXT)
            
    Common.goToTab(HomePage::HOME_TAB_LINK_XPATH)
    
    sleep(15)
    
    test = [
      {"displayed" => HomePage::SEARCH_BAR_XPATH},
    # 1. Fill field "Search" textbox for search education history record.  
      {"set_text" => HomePage::SEARCH_BAR_XPATH, "text" => EducationHistoryNewPage::EDU_HISTORY_DATA_SCHOOL_NAME_TEXT},
    # Click on "Search"  
      {"click" => HomePage::SEARCH_BUTTON_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH},
    # 2. Click on left side in "Education History"  
      {"click" => SearchResultsPage::SEARCH_RESULTS_BAR_EDU_HISTORY_XPATH},
      {"displayed" => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH}
    ] 
    Common.main(test)
    
    $wait.until {
      $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULTS_RESULT_LIST_XPATH).displayed?
    }
    sleep(2)
    # 3. Select one or more contact doing click on checkbox on column "Action".
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_RESULT_LIST_FIRST_CHECKBOX_XPATH).click
    
    # 4. Click on "Add Skills"
    $browser.find_element(:xpath => SearchResultsPage::SEARCH_RESULT_ADD_SKILLS_XPATH).click
    
    sleep(3)
    # A pop up window will be disaplyed
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    sleep(2)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
    # 5. Select one or more "skill to add" (doing click on checkbox)  
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_SECOND_ELEMENT_XPATH},
    # 6. Click on right arrow  
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_LIST_2_ELEMENT_XPATH},
    # 7. Click on "Save Skills"  
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH}
      ]
    Common.main(test)
    
    assert_equal("Success:\nSkills Added Successfully", $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_SUCCESS_MESSAGE_XPATH).text)
    # 8. Close popup
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH).click
    $browser.switch_to.window($browser.window_handles.first)
    
    # 9. Refresh page and scroll to Skills related list on contact record
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + ContactNewEditPage::CONTACT_NEW_DATA_LAST_NAME_TEXT + "')]]").click
    $wait.until {
       $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
     }
     
    assert $wait.until {
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH).displayed? 
      $browser.find_element(:xpath => ContactDetailPage::CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH).displayed?   
  
    }
    
   
  end
  
  ##Also is Pending Automation
  TC273 - Add to Skill on Employment History section in Search   
=end
 
############ CUSTOM METHODS ###############

  def AddSkillToContact(contact, skill)
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    begin
      $browser.switch_to.alert.accept 
     rescue 
     end
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + contact + "')]]")
    
    # 3. Click on "Add skills"
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
      {"click" => ContactDetailPage::CONTACT_DETAIL_BTN_ADD_SKILL_XPATH},
    ]
    Common.main(test)
    sleep(6)
    
    newWindow= $browser.window_handles.last
    $browser.switch_to.window(newWindow)
    
    test = [
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH},
      ]
    Common.main(test)
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_LIST_XPATH + "//*[text()[contains(.,'" + skill + "')]]/..//input").click
    sleep(1)
    
    test = [
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH}
    ]
    Common.main(test)
    
    #sleep(2)
    assert $wait.until {
       $browser.find_element(:xpath => ContactsHomePage::CONTACT_SKILL_POPUP_SKILL_LIST_1_ELEMENT_XPATH).text == skill  
     }
    test = [
      {"click" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_SAVE_XPATH},
      {"displayed" => ContactsHomePage::CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH}
    ]
    Common.main(test) 
    $browser.find_element(:xpath => ContactsHomePage::CONTACT_JOB_POPUP_BTN_CLOSE_XPATH).click
    $browser.switch_to.window($browser.window_handles.first)
  end
  
  def AddEducationRecordToContact(contact, school)
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    begin
      $browser.switch_to.alert.accept 
    rescue 
    end
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + contact + "')]]")
    
    # 3. Click on "New Eductation History"
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_EDUCATION_HIST_XPATH},
      {"click_and_load" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_EDUCATION_HIST_XPATH},
      {"displayed" => EducationHistoryNewPage::EDU_HISTORY_NEW_NAME_XPATH},
      {"set_text" => EducationHistoryNewPage::EDU_HISTORY_NEW_NAME_XPATH, "text" => school},
      {"click_and_load" => EducationHistoryNewPage::EDU_HISTORY_NEW_BTN_SAVE}
    ]
    Common.main(test) 
    begin
      $browser.switch_to.alert.accept 
    rescue 
    end
    test = [ 
      {"displayed" => EducationHistoryNewPage::EDU_HISTORY_DETAIL_BTN_EDIT_XPATH}
    ]
    Common.main(test)
    return $browser.find_element(:xpath => EducationHistoryNewPage::EDU_HISTORY_DETAIL_SCHOOL_RECORD_XPATH).text
  end
  
  def AddEmploymentRecordToContact(contact, employment, job)
    # 1. Click on "Contacts". 
    Common.goToTab(HomePage::CONTACTS_TAB_LINK_XPATH)
    begin
      $browser.switch_to.alert.accept 
     rescue 
     end
    # 2. In Name column click on a specific contact name
    test = [
      {"displayed" => ContactsHomePage::CONTACT_HOME_VIEW_SELECT_XPATH},
    ]
    Common.main(test)
    
    Common.click_and_load(ContactsHomePage::CONTACT_HOME_LIST_XPATH + "//*[text()[contains(.,'" + contact + "')]]")
    
    # 3. Click on "New Employment History"
    test = [
      {"displayed" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_EMPLOYMENT_HIST_XPATH},
      {"click_and_load" => ContactDetailPage::CONTACT_DETAIL_BTN_NEW_EMPLOYMENT_HIST_XPATH},
      {"displayed" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_EMPLOYER_NAME_XPATH},
      {"displayed" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_JOB_TITLE_XPATH},
      {"set_text" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_EMPLOYER_NAME_XPATH, "text" => employment},
      {"set_text" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_JOB_TITLE_XPATH, "text" => job},
      {"click_and_load" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_BTN_SAVE},
      {"displayed" => EmploymentHistoryNewPage::EMPLOYMENT_HIST_BTN_EDIT}
    ]
    Common.main(test)
    
  end
  
   
  
  
  
end