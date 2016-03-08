class BoardSetupDetailPage
  
  BOARD_DETAIL_EDIT_BUTTON_XPATH = ".//*[@name='edit']"
  BOARD_DETAIL_DELETE_BUTTON_XPATH = ".//*[@name='del']"
  BOARD_DETAIL_CLONE_BUTTON_XPATH = ".//*[@name='clone']"
  BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH = ".//*[@title='Search URL Builder']"
  BOARD_DETAIL_NEW_JOB_ORDER_ASSOCIATION_BUTTON_XPATH = ".//*[@value='New Job Order Job Board Association']"
  BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH = "(.//*[@class='bPageBlock brandSecondaryBrd secondaryPalette'])[2]/div[2]//tbody"
  
  #SEARCH URL BUILDER STEPS
  URL_BUILDER_URL_XPATH = "https://ts2.na17.visual.force.com/apex/ScontrolAMSREplace?scontrolCaching=1&id=a0Go00000080Tcp"
  BOARD_DETAIL_SEARCH_URL_NEXT_XPATH = ".//*[@title='Next']"
  BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH = ".//*[@class='detailList']//tr[last()]//a"
  BOARD_DETAIL_SEARCH_URL_SEARCH_URL_XPATH = ".//*[@class='detailList']//tr[2]//a"
  
  BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH = ".//*[@class='detailList']//tr[1]//input"
  BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH = ".//*[@value='Save & Close']"
  BOARD_DETAIL_SEARCH_URL_NAME_XPATH = ".//*[@class='requiredInput']//input"
  BOARD_DETAIL_SEARCH_URL_CHOOSE_BOARD_XPATH = "(.//select)[1]"
  BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH = ".//*[@class='messageText']"
  BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_BOARD = "Error:\nChoose Board: Validation Error: Value is required."
  BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_NAME = "Error:\nSearch URL Name: Validation Error: Value is required."

  CHOOSE_SOURCE_XPATH = ".//*[@class='lookupInput']//input"
  NEXT_BUTTON_XPATH = ".//*[@value='Next']"
  
end