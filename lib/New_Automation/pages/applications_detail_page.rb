class ApplicationsDetailPage
  
  FORWARD_APPLICATIONS_BUTTON_ID = ".//*[@value='Forward Application']"
  CREATE_PDF_BUTTON_XPATH = "(.//*[@id='topButtonRow']//*[@class='btn'])[5]"
  PDF_POP_UP_WINDOWS_ELEMENT_XPATH = ".//*[@class='pdfViewer']"
  APPLICATIONS_DETAIL_JOB_TEXT_XPATH = "(.//*[@class='detailList'])[1]//tr[3]/td[2]"

  
  #PRESCREENS SECTION
  APPLICATIONS_DETAIL_PRESCREEN_1_XPATH = "(.//*[@class='list'])[11]//tr[2]"
  APPLICATIONS_DETAIL_PRESCREEN_2_XPATH = "(.//*[@class='list'])[11]//tr[3]"
  APPLICATIONS_DETAIL_PRESCREEN_3_XPATH = "(.//*[@class='list'])[11]//tr[4]"
  APPLICATIONS_DETAIL_PRESCREEN_4_XPATH = "(.//*[@class='list'])[11]//tr[5]"
end