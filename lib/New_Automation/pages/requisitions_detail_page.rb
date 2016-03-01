class RequisitionsDetail
  REQUISITIONS_DETAIL_NAME_XPATH = ".//*[@class='pageDescription']"
  
  #BUTTONS
  REQUISITIONS_DETAIL_BTN_EDIT_XPATH = ".//*[@title='Edit']"
  REQUISITIONS_DETAIL_BTN_CLOSE_JOB_XPATH = ".//*[@title='Close Job']"
  REQUISITIONS_DETAIL_BTN_SAVE_EDITING_XPATH = ".//*[@title='Save']"
  REQUISITIONS_DETAIL_BTN_DELETE_XPATH = ".//*[@title='Delete']"
  REQUISITIONS_DETAIL_BTN_NEW_APP_XPATH = ".//*[@name='ts2__new_application']"
  REQUISITIONS_DETAIL_BTN_ROLLOVER_CONTACTS_XPATH = ".//*[@name='ts2__rollover_contacts']"
  
  #FIELDS
  REQUISITIONS_DETAIL_PRIMARY_RECRUITER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[5]"
  REQUISITIONS_DETAIL_SECONDARY_RECRUITER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[6]"
  REQUISITIONS_DETAIL_HIRING_MANAGER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[7]"
  REQUISITIONS_DETAIL_EXECUTIVE_APPROVER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[8]"
  REQUISITIONS_DETAIL_QUESTION_SET_XPATH = "(.//*[@class='detailList'])[2]//tr[3]/td[4]/span/input"
  
  REQUISITIONS_DETAIL_APP_LIST_XPATH = "(.//*[@class='list'])[2]/tbody"
  REQUISITIONS_DETAIL_FIRST_APP_LIST_XPATH = "(.//*[@class='list'])[2]/tbody/tr[2]/th[1]/a"
  REQUISITIONS_DETAIL_SECOND_APP_LIST_XPATH = "(.//*[@class='list'])[2]/tbody/tr[3]/th[1]/a"
  
  SITE_URL_2_XPATH = ".//*[@id='j_id0:frm:pageBlock:j_id30:tb']/tr[1]/td[5]/a"

  SITE_URL_XPATH = ".//*[@class='pbBody']//table/tbody/tr[1]/td[5]/a/span"
  
  LINK_TO_POSTING_IFRAME_XPATH = ".//iframe[@title='JobOrderJobBoardAssociations']"

  #Webpage Search Opening TC965, JS2 Projects
  FIRST_SEARCH_RESULT_LINK_XPATH = ".//*[@class='atsSearchResultsTable']/tbody/tr[1]/td[1]/a"
  
  #ROLLOVER CONTACTS POP UP WINDOW
  
  REQUISITIONS_ROLLOVER_POPUP_JOB_INPUT_XPATH = ".//*[@id='j_id0:frm:j_id49:j_id66']"
  REQUISITIONS_ROLLOVER_POPUP_BTN_ROLLOVER_XPATH = ".//*[@id='j_id0:frm:j_id49:pbbsMainButtons:j_id83']"
  REQUISITIONS_ROLLOVER_POPUP_BTN_CANCEL_XPATH = ".//*[@name='j_id0:frm:j_id49:pbbsMainButtons:j_id86']"
  REQUISITIONS_ROLLOVER_POPUP_MSG_CELL_XPATH = ".//*[@class='messageCell']/div"
  REQUISITIONS_ROLLOVER_POPUP_MSG_WARNING_TEXT = "The Job Order you selected does not have the same Question Set as the Job Order you are performing Rollover action from. Click the Invite to Apply button if you would like to apply contacts to the Job."
  REQUISITIONS_ROLLOVER_POPUP_MSG_SUCCESS_TEXT = "The Rollover Process has been completed. Applications Rolled Over: 2."
  
end



