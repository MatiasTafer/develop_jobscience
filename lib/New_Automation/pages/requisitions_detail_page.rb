class RequisitionsDetail
  #BUTTONS
  REQUISITIONS_DETAIL_BTN_CLOSE_JOB_XPATH = ".//*[@title='Close Job']"
  REQUISITIONS_DETAIL_BTN_SAVE_EDITING_XPATH = ".//*[@title='Save']"
  #FIELDS
  REQUISITIONS_DETAIL_PRIMARY_RECRUITER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[5]"
  REQUISITIONS_DETAIL_SECONDARY_RECRUITER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[6]"
  REQUISITIONS_DETAIL_HIRING_MANAGER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[7]"
  REQUISITIONS_DETAIL_EXECUTIVE_APPROVER_XPATH = "(.//*[@class='dataCol inlineEditWrite'])[8]"
  
  SITE_URL_XPATH = ".//*[@class='list']/tbody/tr[1]/td[5]/a"
  
end