class RequisitionsDetail
  REQUISITIONS_DETAIL_NAME_XPATH = ".//*[@class='pageDescription']"
  
  #BUTTONS
  REQUISITIONS_DETAIL_BTN_EDIT_XPATH = ".//*[@title='Edit']"
  REQUISITIONS_DETAIL_BTN_CLOSE_JOB_XPATH = ".//*[@title='Close Job']"
  REQUISITIONS_DETAIL_BTN_SAVE_EDITING_XPATH = ".//*[@title='Save']"
  REQUISITIONS_DETAIL_BTN_DELETE_XPATH = ".//*[@title='Delete']"
  REQUISITIONS_DETAIL_BTN_NEW_APP_XPATH = ".//*[@name='ts2__new_application']"
  
  #FIELDS
  REQUISITIONS_DETAIL_PRIMARY_RECRUITER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[5]"
  REQUISITIONS_DETAIL_SECONDARY_RECRUITER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[6]"
  REQUISITIONS_DETAIL_HIRING_MANAGER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[7]"
  REQUISITIONS_DETAIL_EXECUTIVE_APPROVER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[8]"
  REQUISITIONS_DETAIL_QUESTION_SET_XPATH = "(.//*[@class='detailList'])[2]//tr[3]/td[4]/span/input"
  

  SITE_URL_2_XPATH = ".//*[@id='j_id0:frm:pageBlock:j_id30:tb']/tr[1]/td[5]/a"

  SITE_URL_XPATH = ".//*[@class='pbBody']//table/tbody/tr[1]/td[5]/a/span"
  
  LINK_TO_POSTING_IFRAME_XPATH = ".//iframe[@title='JobOrderJobBoardAssociations']"

  #Webpage Search Opening TC965, JS2 Projects
  FIRST_SEARCH_RESULT_LINK_XPATH = ".//*[@class='atsSearchResultsTable']/tbody/tr[1]/td[1]/a"
  
  RE_CHAR_BUTTON_XPATH = ".//*[@title='Re-Chat']"
end



