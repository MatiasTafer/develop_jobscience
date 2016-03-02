class ApplicationsDetailPage
  
  FORWARD_APPLICATIONS_BUTTON_ID = ".//*[@value='Forward Application']"
  CREATE_PDF_BUTTON_XPATH = "(.//*[@id='topButtonRow']//*[@class='btn'])[5]"
  REVERT_STAGE_BTN_XPATH = ".//*[@id='topButtonRow']/input[7]"
  PDF_POP_UP_WINDOWS_ELEMENT_XPATH = ".//*[@class='pdfViewer']"
  APPLICATIONS_DETAIL_JOB_TEXT_XPATH = "(.//*[@class='detailList'])[1]//tr[3]/td[2]"
  APP_DETAIL_RESUME_UPLOADED_XPATH = "((.//*[@class='detailList'])[1]//tr[8]//div)[1]"
  APP_DETAIL_MOVE_LINK_XPATH = "(.//*[@class='detailList'])[1]//tr[4]/td[4]//a[1]"
  APP_DETAIL_OVERALL_STAGE_XPATH = "(.//*[@class='detailList'])[1]//tr[10]/td[4]/div"
    
  #PRESCREENS SECTION
  APPLICATIONS_DETAIL_PRESCREEN_1_XPATH = "(.//*[@class='list'])[11]//tr[2]"
  APPLICATIONS_DETAIL_PRESCREEN_2_XPATH = "(.//*[@class='list'])[11]//tr[3]"
  APPLICATIONS_DETAIL_PRESCREEN_3_XPATH = "(.//*[@class='list'])[11]//tr[4]"
  APPLICATIONS_DETAIL_PRESCREEN_4_XPATH = "(.//*[@class='list'])[11]//tr[5]"
  
  #MOVE POP UP
  MOVE_POPUP_BTN_CANCEL_XPATH = ".//*[@value='Cancel']"
  MOVE_POPUP_SUBMITTAL_STAGE_XPATH = ".//*[@id='j_id0:frm:j_id45:pbsMain:j_id53:1:j_id55']"
  
  #REVERT STAGE POP UP
  REVERT_STAGE_BTN_NEXT_XPATH = ".//*[@title='Next']"
  REVERT_STAGE_RADIO_XPATH = ".//*[@type='radio']"
  REVERT_STAGE_SEND_EMAIL_BOX_XPATH = ".//*[@type='checkbox']"
  REVERT_STAGE_SUCCES_MSG_XPATH = ".//*[@class='messageCell']"
  REVERT_STAGE_BTN_CLOSE_XPATH = ".//*[@title='Close']"
end