class BoardSetupDetailPage
  
  BOARD_DETAIL_EDIT_BUTTON_XPATH = ".//*[@name='edit']"
  BOARD_DETAIL_DELETE_BUTTON_XPATH = ".//*[@id='topButtonRow']/input[2]"
  BOARD_DETAIL_CLONE_BUTTON_XPATH = ".//*[@id='topButtonRow']/input[3]"
  BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH = ".//*[@id='topButtonRow']/input[4]"
  BOARD_DETAIL_NEW_JOB_ORDER_ASSOCIATION_BUTTON_XPATH = ".//*[@class='bPageBlock brandSecondaryBrd secondaryPalette']/div[1]//*[@class='btn']"  
  BOARD_DETAIL_FIRSTRECORD_XPATH = ".//*[@id='bodyCell']/div[3]/div[1]/div/div[2]/table/tbody/tr[2]/th/a"
  BOARD_DETAIL_NOTES_ATTACH_LIST_XPATH = "(.//*[@class='bPageBlock brandSecondaryBrd secondaryPalette'])[2]/div[2]//tbody"
  
  #SEARCH URL BUILDER STEPS
  BOARD_DETAIL_SEARCH_URL_NEXT_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id34']/input[1]"
  BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id151']/div[2]/table/tbody/tr[3]/td/a"
  BOARD_DETAIL_SEARCH_URL_SEARCH_URL_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id151']/div[2]/table/tbody/tr[2]/td/a"
  BOARD_DETAIL_SEARCH_URL_KEYWORD_1_INPUT_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id134:j_id135:j_id137']/input"
  BOARD_DETAIL_SEARCH_URL_SAVE_CLOSE_XPATH = ".//*[@value='Save & Close']"
  BOARD_DETAIL_SEARCH_URL_NAME_XPATH = ".//*[@name='j_id0:frm:j_id33:j_id151:j_id152:j_id156']"
  BOARD_DETAIL_SEARCH_URL_CHOOSE_BOARD_XPATH = "(.//select)[1]"
  BOARD_DETAIL_SEARCH_URL_ERROR_OUTPUT_XPATH = ".//*[@class='messageText']"
  BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_BOARD = "Error:\nChoose Board: Validation Error: Value is required."
  BOARD_DETAIL_SEARCH_URL_ERROR_TEXT_NAME = "Error:\nSearch URL Name: Validation Error: Value is required."
end