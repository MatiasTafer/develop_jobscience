class ApplicationsDetailPage
  
  FORWARD_APPLICATIONS_BUTTON_XPATH = ".//*[@value='Forward Application']"
  CREATE_PDF_BUTTON_XPATH = "(.//*[@value='Create PDF'])"
  REVERT_STAGE_BTN_XPATH = ".//*[@value='Revert Stage']"
  PDF_POP_UP_WINDOWS_ELEMENT_XPATH = ".//*[@class='pdfViewer']"
  APPLICATIONS_DETAIL_JOB_TEXT_XPATH = ".//*[text()='Job']/following-sibling::*[1]//a"
  APP_DETAIL_RESUME_UPLOADED_XPATH = ".//*[text()='Resume Uploaded']/following-sibling::*[1]//div"
  APP_DETAIL_MOVE_LINK_XPATH = ".//*[@alt='Move']"
  APP_DETAIL_OVERALL_STAGE_XPATH = ".//*[text()='Overall Stage']/../following-sibling::*[1]//div"
  
  #FIELDS
  APP_DETAIL_APP_STATUS_XPATH = ".//*[text()='App Status']/../following-sibling::*[1]//div"
  APP_DETAIL_STATUS_XPATH = ".//*[text()='Status']/../following-sibling::*[1]//div"

  APP_DETAIL_APPLY_EXCEPTION_CHECKED_XPATH = ".//*[text()='Apply Exception']/following-sibling::*[1]//*[@title='Checked']"
  APP_DETAIL_APPLY_EXCEPTION_NOT_CHECKED_XPATH = ".//*[text()='Apply Exception']/following-sibling::*[1]//*[@title='Not Checked']"
  APP_DETAIL_EXCEPTION_REASON_XPATH = ".//*[text()='Exception Reason']/following-sibling::*[1]//div"
  APP_DETAIL_EXCEPTION_REASON_OTHER_XPATH = ".//*[text()='Exception Reason Other']/following-sibling::*[1]//div"
  
  #PRESCREENS SECTION
  APPLICATIONS_DETAIL_PRESCREEN_1_XPATH = ".//*[text()='Prescreen Name']/../../tr[2]"
  APPLICATIONS_DETAIL_PRESCREEN_2_XPATH = ".//*[text()='Prescreen Name']/../../tr[3]"
  APPLICATIONS_DETAIL_PRESCREEN_3_XPATH = ".//*[text()='Prescreen Name']/../../tr[4]"
  APPLICATIONS_DETAIL_PRESCREEN_4_XPATH = ".//*[text()='Prescreen Name']/../../tr[5]"

  #MOVE POP UP
  MOVE_POPUP_BTN_CANCEL_XPATH = ".//*[@value='Cancel']"
  MOVE_POPUP_BTN_CLOSE_XPATH = ".//*[@value='Close']"
  MOVE_POPUP_SUBMITTAL_STAGE_XPATH = ".//a[@title='Submittal']"
  MOVE_POPUP_SUBMITTAL_STAGE_SUB_XPATH = "(.//a[text()[contains(., 'Awaiting')]])[1]"
  MOVE_POPUP_CS1_STAGE_XPATH = ".//*[@title='CS1'][2]"
  
  #REVERT STAGE POP UP
  REVERT_STAGE_BTN_NEXT_XPATH = ".//*[@title='Next']"
  REVERT_STAGE_RADIO_XPATH = ".//*[@type='radio']"
  REVERT_STAGE_RADIO_2_XPATH = "(.//*[@type='radio'])[2]"
  REVERT_STAGE_SEND_EMAIL_BOX_XPATH = ".//*[@type='checkbox']"
  REVERT_STAGE_SUCCES_MSG_XPATH = ".//*[@class='messageCell']"
  REVERT_STAGE_BTN_CLOSE_XPATH = ".//*[@title='Close']"
  REVERT_STAGE_SUCCESS_MSG_XPATH = ".//*[@class='messageCell']/div"
  REVERT_STAGE_SUCCESS_MSG_TEXT = "Stage has been reverted successfully"
  REVERT_STAGE_CANNOT_REVERT_MSG_TEXT = "Warning:\nThe Application selected cannot be Reverted as it is in the Application Stage. There is no stage it can be reverted to."
  
end