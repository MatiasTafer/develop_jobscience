class ShortListDetailPage
  
  SL_MENU_XPATH = ".//*[@class='fa fa-bars']"
  SL_RECORD_XPATH = ".//*[text()='Name']/ancestor::table[1]/following-sibling::*[1]//li[1]//*[@action='selectShortlistCandidate']"
  SL_SEND_EMAIL_MENU_XPATH = ".//*[text()='Send Email']"
  SL_REVIEW_EMAIL_MENU_XPATH = ".//div[text()[contains(.,'Review Email')]]"
  SL_UPDATE_STATUS_OPTION_XPATH = ".//div[text()[contains(.,'Update Status')]]"
  SL_REMOVE_CONTACT_XPATH = ".//div[text()[contains(.,'Remove Contacts')]]"
  
  #Update Status Pop-Up window
  SELECT_STATUS_DROPDOWN_XPATH = ".//select"
  SUBMIT_BUTTON_XPATH = ".//*[@value='Submit']"
  CLOSE_BUTTON_XPATH = ".//*[@value='Close']"
  SUBMIT_MESSAGE_XPATH = ".//*[@class='message confirmM3']"
  
  SPEED_REVIEW_ICON_XPATH = ".//*[@class='shortlist-header-tabs-item'][1]"
  CONTACT_NAME_SPEED_REVIEW_PAGE_XPATH = "(.//*[@class='jck-h1-label jck-jcard-header-label']/span)[2]"
  NAME_FIRST_CONTACT_SPEED_LIST_XPATH = "(.//*[text()='Name']/ancestor::table[1]/following-sibling::*[1]//li[1]//a)[1]"
  ADD_CONTACT_ICON_XPATH = ".//*[@action='addShortlistContact']/i[1]"
  DELETE_SHORT_LIST_ICON_XPATH = ".//*[@id='shortlistTitleLabel']/i[2]"

  SL_LIST_XPATH = ".//*[@class='wk-list-body']"
  SL_DELETE_LIST_XPATH = ".//*[@action='confirmRemoveShortlist']"

  CONFIRM_DELETE_SHORT_LIST_BUTTON_XPATH = "(.//*[text()[contains(.,'Yes***')]])[2]"
  CONFIRM_DELETE_CONTACT_BUTTON_XPATH = "(.//*[text()[contains(.,'No***')]])[2]"
  
  SEARCH_BUTTON_XPATH = ".//*[@class='web-sourcing-footer']/div"      
  
  CHECKBOX_ELEMENT_XPATH = ".//*[contains(@class, 'shortlist-candidate-record-list-item-selector')]"                   
  
end
                  