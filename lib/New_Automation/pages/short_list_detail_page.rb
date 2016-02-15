class ShortListDetailPage
  
  SL_MENU_XPATH = ".//*[@id='JobscienceMainPanel']//*[@class='fa fa-bars']"
  SL_RECORD_XPATH = ".//*[@id='shortlistGrid']/div/ul/ul/li[1]/div[1]/div/div[2]/div"
  SL_SEND_EMAIL_MENU_XPATH = "html/body/div[4]/div[9]"
  SL_REVIEW_EMAIL_MENU_XPATH = "html/body/div[4]/div[8]"
  SL_STANDART_CHECKBOX_ID = "j_id0:frm:pbSendEmail:j_id40:j_id41:j_id43:1"
  SL_UPDATE_STATUS_OPTION_XPATH = "html/body/div[4]/div[2]"
  SELECT_STATUS_DROPDOWN_XPATH = ".//*[@id='j_id0:j_id28:j_id29:j_id32']"
  SUBMIT_BUTTON_XPATH = ".//*[@id='j_id0:j_id28:j_id29']/div[1]/input"
  CLOSE_BUTTON_XPATH = ".//*[@id='j_id0:j_id28:j_id34']/div[1]/input"
  SUBMIT_MESSAGE_XPATH = ".//*[@id='j_id0:j_id2:j_id3:j_id4:0:j_id5']/div"
  SPEED_REVIEW_ICON_XPATH = ".//*[@class='shortlist-header-tabs-item'][1]"
  CONTACT_NAME_SPEED_REVIEW_PAGE_XPATH = "(.//*[@class='jck-h1-label jck-jcard-header-label']/span)[2]"
  NAME_FIRST_CONTACT_SPEED_LIST_XPATH = "(.//*[@class='shortlist-candidate-record-list-item-row']/a)[1]"
end