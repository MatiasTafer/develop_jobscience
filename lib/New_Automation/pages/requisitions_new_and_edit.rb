class RequisitionsNewAndEdit
  
  #FIRST STEP
  REQUISITIONS_NEW_RECORD_TYPE_ID = "p3"
  REQUISITIONS_NEW_BTN_CONTINUE_XPATH = ".//*[@id='bottomButtonRow']/input[1]"
  REQUISITIONS_NEW_BTN_CANCEL_XPATH = ".//*[@id='bottomButtonRow']/input[2]"
  
  #SECOND STEP
    #REQUIRED FIELDS
  REQUISITIONS_NEW_JOB_TITLE_ID = "Name"
  REQUISITIONS_NEW_PRIMARY_RECRUITER_TYPE_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[5]//select"
  REQUISITIONS_NEW_PRIMARY_RECRUITER_TEXT_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[5]//*[@class = 'lookupInput']/input"
  REQUISITIONS_NEW_LOCATION_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[1]/td[2]//select"
  REQUISITIONS_NEW_MIN_SALARY_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[3]/td[2]//input"
  REQUISITIONS_NEW_MAX_SALARY_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[4]/td[2]//input"
  REQUISITIONS_NEW_DEPARTAMENT_XPATH = "(.//*[@class='detailList'])[2]/tbody/tr[2]/td[4]//select"
  
    #DATE FIELDS
  REQUISITIONS_NEW_DATE_POSTED_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[1]/td[4]//input"
  REQUISITIONS_NEW_EXPIRATION_DATE_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[2]/td[4]//input"
  REQUISITIONS_NEW_DATE_CLOSED_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[4]/td[4]//input"
  REQUISITIONS_NEW_ES_XPATH = "(.//*[@class='detailList'])[1]/tbody/tr[4]/td[4]//input"
  
end