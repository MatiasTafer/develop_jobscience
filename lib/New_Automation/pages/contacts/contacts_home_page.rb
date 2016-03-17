class ContactsHomePage
  

  FIRST_CHECKBOX_OF_FIRST_CONTACT_XPATH = "(.//*[@class='checkbox'])[1]"
  SECOND_CHECKBOX_OF_SECOND_CONTACT_XPATH = "(.//*[@class='checkbox'])[2]"
  FIRST_CONTACT_ALL_CONTACT_TAB_XPATH = "(//*[text()='Del'])[2]/../../../../td[4]//a"
  ADD_TO_LIST_BUTTON_XPATH = ".//*[@value='Add to List']"
  CONTACT_HOME_PAGE_BTN_NEW = ".//*[@name='new']"
  CONTACT_HOME_VIEW_SELECT_XPATH = ".//*[@title='View:']"
  CONTACT_HOME_BTN_GO_XPATH = ".//*[@name='go']"
  CONTACT_HOME_LIST_XPATH = ".//*[@class='list']"
  
  #After pressing "GO" button
  CONTACT_HOME_CONTACT_LIST_XPATH = "(//*[text()='Del'])[2]/../../../../../../../../.."
  CONTACT_HOME_ADD_SKILL_XPATH = ".//*[@value='Add Skills']"
  CONTACT_HOME_ADD_LIST_XPATH = ".//*[@value='Add to List']"
  CONTACT_HOME_ADD_TAGS_XPATH = ".//*[@value='Add Tags']"
  CONTACT_HOME_APPLY_TO_JOB_XPATH = ".//*[@value='Apply To Jobs']"
  CONTACT_HOME_FIRST_VIEW_OPTION_XPATH = "(.//*[@title='View:']/option)[1]"
  CONTACT_HOME_FIRST_ENTRY_GO_XPATH = "(//*[text()='Del'])[1]/../../../../td[4]//a"
  
   
  #Add Skill Pop Up Window
  CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH = "(.//*[@type='checkbox'])[1]"
  CONTACT_SKILL_POPUP_SECOND_ELEMENT_XPATH = "(.//*[@type='checkbox'])[2]"
  CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH = ".//*[@class='fa fa-chevron-right']"    
  CONTACT_SKILL_POPUP_BTN_SAVE_XPATH = ".//*[@title='Save Skills']"
  CONTACT_SKILL_POPUP_BTN_SAVE_RATE_XPATH = ".//*[@value='Save & Rate Skills']"
  CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH = ".//*[@value='Close']"
  CONTACT_SKILL_POPUP_BTN_CANCEL_XPATH = ".//*[@value='Cancel']"
  CONTACT_SKILL_POPUP_SKILL_LIST_1_ELEMENT_XPATH = "(//*[text()='Selected Skills']/..//option)[1]"
  CONTACT_SKILL_POPUP_SKILL_LIST_2_ELEMENT_XPATH = "(//*[text()='Selected Skills']/..//option)[2]"
  CONTACT_SKILL_POPUP_RATE_SKILL_BTN_SUBMIT_XPATH = ".//*[@value='Submit']"
  CONTACT_SKILL_POPUP_RATE_SLIDER_1_XPATH = "(//*[text()='Rate']/../../../..//tbody//tr)[1]/td[2]//div/a"
  CONTACT_SKILL_POPUP_RATE_SLIDER_2_XPATH = "(//*[text()='Rate']/../../../..//tbody//tr)[2]/td[2]//div/a"
  CONTACT_SKILL_POPUP_ERROR_OUTPUT_XPATH = ".//*[@class='messageText']//h4"
  CONTACT_SKILL_POPUP_ERROR_OUTPUT_2_XPATH = ".//*[@class='message errorM3']//div"
  CONTACT_SKILL_POPUP_ERROR_MESSAGE_2_TEXT = "Error:\nPlease select at least one skill."
  CONTACT_SKILL_POPUP_ERROR_MESSAGE_TEXT = 'You currently have multiple contacts selected. You cannot rate multiple candidates at once. Please select "Save Skills" or "Cancel"'
  CONTACT_SKILL_POPUP_SUCCESS_MESSAGE_XPATH = ".//*[@class='messageText']"
  CONTACT_SKILL_POPUP_SKILL_RATED_MSG_XPATH = ".//*[@style='margin-top: -5px; padding-left: 23px; font: bold 110% arial;']"
  CONTACT_SKILL_POPUP_SKILL_LIST_XPATH = ".//*[@class='m-parent m-last']"
  
  #Add to Short List Pop Up Window
  CONTACT_LIST_POPUP_NAME_INPUT_XPATH = "((//*[text()[contains(., 'Short List')]])[3]/../following-sibling::*//input)[7]"  
  CONTACT_LIST_POPUP_NEW_NAME_INPUT_XPATH = "(//*[text()[contains(., 'Name')]]/..)[2]/following-sibling::*//input"
  CONTACT_LIST_POPUP_NEW_DESCRIPTION_INPUT_XPATH = "//*[text()[contains(., 'Description')]]/../..//textarea"
  CONTACT_LIST_POPUP_BTN_ADD_SHORT_LIST_XPATH = ".//*[@value='Add to Short List']"
  CONTACT_LIST_POPUP_BTN_CLOSE_XPATH = ".//*[@value='Close']"
  CONTACT_LIST_POPUP_NUMBER_ADDED_XPATH = "//*[text()='Total Contacts Added']/../..//span"

  
  #Apply to Job Pop Up Window
  CONTACT_JOB_POPUP_JOB_TITLE_XPATH = "//*[text()[contains(., 'Job Title')]]/../following-sibling::*//span/input"
  CONTACT_JOB_POPUP_BTN_APPLY_XPATH = ".//*[@value='Apply To Position']"
  CONTACT_JOB_POPUP_TOTAL_APP_XPATH = "//*[text()='Total Applications Count on Job']/../following-sibling::*//span"
  CONTACT_JOB_POPUP_BTN_CLOSE_XPATH = ".//*[@title='Close']"
  CONTACT_JOB_POPUP_BTN_CANCEL_XPATH = ".//*[@title='Cancel']"
  CONTACT_JOB_POPUP_BTN_NEXT_XPATH = ".//*[@title='Next']"
  
  CONTACT_JOB_POPUP_BTN_GOTO_JOB_XPATH = ".//*[@title='Go To Job']"
  
  CONTACT_JOB_POPUP_RADIO_INVITE_XPATH = "(.//*[@type='radio'])[1]"
  CONTACT_JOB_POPUP_RADIO_AGENCY_XPATH = "(.//*[@type='radio'])[2]"
  CONTACT_JOB_POPUP_RADIO_EXCEP_XPATH = "(.//*[@type='radio'])[3]"
  
  CONTACT_JOB_POPUP_SAVE_XPATH = ".//*[@value='Save']"
  CONTACT_JOB_POPUP_INVITE_ERROR_XPATH = ".//*[@class='messageText']"
  
  CONTACT_JOB_POPUP_ERROR_OUTPUT_XPATH = ".//*[@class='message errorM3']//div"
  CONTACT_JOB_POPUP_ERROR_TEXT = "Error:\nJob Title: You must enter a value"
  
    #Invite to apply
    CONTACT_JOB_POPUP_APPLY_MSG_XPATH = "//*[text()='Message']/../..//textarea"
    
    #Agency
    CONTACT_JOB_POPUP_AGENCY_XPATH = "//*[text()='Agency']/../following-sibling::*//span/input"
    CONTACT_JOB_POPUP_AGENCY_EEO_XPATH = "//*[text()='Request EEO']/../following-sibling::*//input"
    
    #Exception
    CONTACT_JOB_POPUP_REASON_XPATH = "//*[text()='Reason']/../following-sibling::*//select"
    CONTACT_JOB_POPUP_REASON_OTHER_OPTION_XPATH = "//*[text()='Other']"
    CONTACT_JOB_POPUP_REASON_OTHER_XPATH = "//label[text()[contains(., 'Reason Other')]]/../following-sibling::*/textarea"
    CONTACT_JOB_POPUP_SUCCESS_APP_XPATH = "//label[text()[contains(., 'APP')]]"
    CONTACT_JOB_POPUP_SUCCESS_CANDIDATE_XPATH = "//label[text()[contains(., 'APP')]]/../..//td//span"
     
  #Add Tags Pop Up window
  CONTACT_TAGS_POPUP_PUBLIC_TAGS_XPATH = "//*[text()[contains(., 'Public Tags')]]/../following-sibling::*/select"   
  CONTACT_TAGS_POPUP_PUBLIC_TAGS_FIRST_OPTION_XPATH = "//*[text()[contains(., 'Public Tags')]]/../following-sibling::*/select//option[2]"
  CONTACT_TAGS_POPUP_PERSONAL_TAGS_XPATH = "//*[text()[contains(., 'Personal Tags')]]/../following-sibling::*//select"
  CONTACT_TAGS_POPUP_PERSONAL_TAGS_FIRST_OPTION_XPATH = "//*[text()[contains(., 'Personal Tags')]]/../following-sibling::*//select//option[2]"
  CONTACT_TAGS_POPUP_NEW_TAG_XPATH = "(//*[text()[contains(., 'New Tag')]])[2]/../following-sibling::*//input"
  
  
  CONTACT_TAGS_POPUP_TYPE_XPATH = "(//*[text()[contains(., 'Type')]]/..)[2]/following-sibling::*//select"
  CONTACT_TAGS_POPUP_BTN_ADD_TAGS_XPATH = ".//*[@value='Add Tags']"
  CONTACT_TAGS_POPUP_BTN_CANCEL_XPATH = ".//*[@title='Cancel']"
  CONTACT_TAGS_POPUP_BTN_CLOSE_XPATH = ".//*[@title='Close']"
  CONTACT_TAGS_POPUP_SUCCESS_OUTPUT_XPATH = ".//*[@class='messageCell']/div"
  CONTACT_TAGS_POPUP_SUCCESS_TEXT = "Tags Added Successfully"
  CONTACT_TAGS_POPUP_TOTAL_TAGS_XPATH = "//*[text()[contains(., 'Total Tags Added')]]/../following-sibling::*//span"
  CONTACT_TAGS_POPUP_ERROR_CELL_XPATH = ".//*[@class='messageCell']/div"
  CONTACT_TAGS_POPUP_ERROR_TAGS_TEXT = "Error:\nNo tags selected"
  
end