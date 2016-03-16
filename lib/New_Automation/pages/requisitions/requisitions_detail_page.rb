class RequisitionsDetail
  REQUISITIONS_DETAIL_NAME_XPATH = ".//*[@class='pageDescription']"
  
  #BUTTONS
  REQUISITIONS_DETAIL_BTN_EDIT_XPATH = ".//*[@title='Edit']"
  REQUISITIONS_DETAIL_BTN_CLOSE_JOB_XPATH = ".//*[@title='Close Job']"
  REQUISITIONS_DETAIL_BTN_SAVE_EDITING_XPATH = ".//*[@title='Save']"
  REQUISITIONS_DETAIL_BTN_DELETE_XPATH = ".//*[@title='Delete']"
  REQUISITIONS_DETAIL_BTN_NEW_APP_XPATH = ".//*[@title='New Application']"
  REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH = ".//*[@title='Rollover Contacts']"
  
  #FIELDS
  REQUISITIONS_DETAIL_PRIMARY_RECRUITER_XPATH = ".//*[text()='Primary Recruiter']/following-sibling::*[1]"
  REQUISITIONS_DETAIL_SECONDARY_RECRUITER_XPATH = ".//*[text()='Secondary Recruiter']/following-sibling::*[1]"
  REQUISITIONS_DETAIL_HIRING_MANAGER_XPATH = ".//*[text()='Hiring Manager']/following-sibling::*[1]"
  REQUISITIONS_DETAIL_EXECUTIVE_APPROVER_XPATH = ".//*[text()='Executive Approver']/following-sibling::*[1]"
  REQUISITIONS_DETAIL_QUESTION_SET_XPATH = ".//*[text()='Question Set']/following-sibling::*[1]"
  
  REQUISITIONS_DETAIL_APP_LIST_XPATH = ".//th[text()='Application']/ancestor::tbody[1]"
  REQUISITIONS_DETAIL_FIRST_APP_LIST_XPATH = ".//th[text()='Application']/../following-sibling::*[1]//*[contains(.,'APP')]//a"
  REQUISITIONS_DETAIL_SECOND_APP_LIST_XPATH = ".//th[text()='Application']/../following-sibling::*[2]//*[contains(.,'APP')]//a"
  
  SITE_URL_XPATH = ".//*[text()='Careers']/../../following-sibling::*//span[contains(.,'http')]"
  
  LINK_TO_POSTING_IFRAME_XPATH = ".//iframe[@title='JobOrderJobBoardAssociations']"

  #Webpage Search Opening TC965, JS2 Projects
  FIRST_SEARCH_RESULT_LINK_XPATH = ".//*[text()[contains(.,'Job Title')]]/ancestor::table/tbody//tr[1]//a"
  

  #ROLLOVER CONTACTS POP UP WINDOW
  
  REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH = ".//*[text()[contains(.,'Job')]]/following-sibling::*[1]//span/input"
  REQUISITIONS_ROLLOVER_POPUP_BTN_ROLLOVER_XPATH = ".//*[@value='Rollover']"
  REQUISITIONS_ROLLOVER_POPUP_BTN_CANCEL_XPATH = ".//*[@value='Cancel']"
  REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH = ".//*[@class='messageCell']/div"
  REQUISITIONS_ROLLOVER_POPUP_MSG_WARNING_TEXT = "The Job Order you selected does not have the same Question Set as the Job Order you are performing Rollover action from. Click the Invite to Apply button if you would like to apply contacts to the Job."
  REQUISITIONS_ROLLOVER_POPUP_MSG_SUCCESS_TEXT = "The Rollover Process has been completed. Applications Rolled Over: 2."
  REQUISITIONS_ROLLOVER_POPUP_BTN_OK_XPATH = ".//*[@value='OK']"


  RE_CHAR_BUTTON_XPATH = ".//*[@title='Re-Chat']"

end



