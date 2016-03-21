class BoardSetupDetailPage
  

  BOARD_DETAIL_EDIT_BUTTON_XPATH = ".//*[@name='edit']"
  BOARD_DETAIL_DELETE_BUTTON_XPATH = ".//*[@name='del']"
  BOARD_DETAIL_CLONE_BUTTON_XPATH = ".//*[@name='clone']"
  BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH = ".//*[@title='Search URL Builder']"
  BOARD_DETAIL_NEW_JOB_ORDER_ASSOCIATION_BUTTON_XPATH = ".//*[@value='New Job Order Job Board Association']"
  BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH = ".//h3[text()='Notes & Attachments']/ancestor::div[1]/following-sibling::*[1]//tbody"
  BOARD_DETAIL_NOTES_ATTACH_LIST_TITLE_URL_XPATH = ".//h3[text()='Notes & Attachments']/ancestor::div[1]/following-sibling::*[1]//a[text()[contains(., 'Search Url:')]]"
  BOARD_DETAIL_SEARCH_URL_XPATH = ".//*[@class='detailList']/child::tbody/child::tr[5]/child::td[2]/child::a[1]"

  #SEARCH URL BUILDER STEPS
  URL_BUILDER_URL_XPATH = "https://ts2.na17.visual.force.com/apex/ScontrolAMSREplace?scontrolCaching=1&id=a0Go00000080Tcp"
  BOARD_DETAIL_SEARCH_URL_NEXT_XPATH = ".//*[@title='Next']"
  BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH = ".//*[text()[contains(.,'RSS URL')]]/../following-sibling::*//a"
  BOARD_DETAIL_SEARCH_URL_SEARCH_URL_XPATH = ".//label[text()[contains(.,'Search URL')]]/../following-sibling::*//a"
    # Step 1
  BOARD_DETAIL_SEARCH_URL_CHOOSE_BOARD_XPATH = ".//*[text()[contains(.,'Choose Board')]]/../following-sibling::*//select"
  CHOOSE_SOURCE_XPATH = ".//*[text()[contains(.,'Choose Source')]]/../following-sibling::*//span/input"
    # Step 3
  BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH = ".//*[text()[contains(., 'Keyword 1')]]/../following-sibling::*//input"
    # Step 4
  BOARD_DETAIL_SEARCH_URL_NAME_XPATH = ".//label[text()[contains(.,'Search URL Name')]]/../following-sibling::*//input"
  BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH = ".//*[@value='Save & Close']"
  
  NEXT_BUTTON_XPATH = ".//*[@value='Next']"
  
  BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH = ".//*[@class='messageText']"
  BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_BOARD = "Error:\nChoose Board: Validation Error: Value is required."
  BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_NAME = "Error:\nSearch URL Name: Validation Error: Value is required."

end