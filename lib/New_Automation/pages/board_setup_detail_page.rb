class BoardSetupDetailPage
  
  BOARD_DETAIL_EDIT_BUTTON_XPATH = ".//*[@name='edit']"
  BOARD_DETAIL_DELETE_BUTTON_XPATH = ".//*[@id='topButtonRow']/input[2]"
  BOARD_DETAIL_CLONE_BUTTON_XPATH = ".//*[@id='topButtonRow']/input[3]"
  BOARD_DETAIL_SEARCH_URLBUILDER_BUTTON_XPATH = ".//*[@id='topButtonRow']/input[4]"
  BOARD_DETAIL_NEW_JOB_ORDER_ASSOCIATION_BUTTON_XPATH = ".//*[@class='bPageBlock brandSecondaryBrd secondaryPalette']/div[1]//*[@class='btn']"  
  BOARD_DETAIL_FIRSTRECORD_XPATH = ".//*[@id='bodyCell']/div[3]/div[1]/div/div[2]/table/tbody/tr[2]/th/a"
  
  #SEARCH URL BUILDER STEPS
  URL_BUILDER_URL_XPATH = "https://ts2.na17.visual.force.com/apex/ScontrolAMSREplace?scontrolCaching=1&id=a0Go00000080Tcp"
  BOARD_DETAIL_SEARCH_URL_NEXT_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id34']/input[1]"
  BOARD_DETAIL_SEARCH_URL_RSS_URL_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id151']/div[2]/table/tbody/tr[3]/td/a"
  CHOOSE_SOURCE_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id39:j_id46']"
  NEXT_BUTTON_XPATH = ".//*[@value='Next']"
  SEARCH_URL_NAME_TEXT_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id151:j_id152:j_id154']/input"
  SAVE_AND_CLOSE_BUTTON_XPATH = ".//*[@id='j_id0:frm:j_id33:j_id34:bottom']/input[1]"
  
end