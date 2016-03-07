class RequisitionsHomePage
  
  REQUISITIONS_PAGE_BTN_NEW_XPATH = ".//*[@name='new']"
  REQUISITIONS_PAGE_BTN_TRANSFER_JOBS_XPATH = ".//*[@title='Transfer Jobs']"
  REQUISITIONS_PAGE_BTN_CHANGE_PRIORITY_JOBS_XPATH = ".//*[@title='Change Priority']"
  REQUISITIONS_PAGE_BTN_CHANGE_STATUS_JOBS_XPATH = ".//*[@title='Change Status']"
  
  REQUISITIONS_PAGE_FIRST_ENTRY_LIST_TITLE_XPATH = "(.//*[@class='x-grid3-cell-inner x-grid3-col-NAME'])[1]/a"
  REQUISITIONS_PAGE_FIRST_ENTRY_LIST_PRIMARY_RECRUITER_TEXT_XPATH = "(.//*[@class='x-grid3-cell-inner x-grid3-col-NAME'])[1]/a/../../../td[9]//a"
  REQUISITIONS_PAGE_FIRST_ENTRY_LIST_STATUS_TEXT_XPATH = "(.//*[@class='x-grid3-cell-inner x-grid3-col-NAME'])[1]/a/../../../td[7]/div"
  REQUISITIONS_PAGE_FIRST_ENTRY_SELECT_XPATH = "(.//*[@class='x-grid3-cell-inner x-grid3-col-NAME'])[1]/a/../../../td[1]//input"
  REQUISITIONS_PAGE_FIRST_SELECT_ALL_BOX_ID = "allBox"

  REQUISITIONS_PAGE_FIRST_ENTRY_LIST_EDIT_XPATH = "((.//*[@class='x-grid3-row-table']/child::tbody/child::tr/child::td)[3]/div/a/span)[text()[contains(.,'Edit')]]"

  REQUISITIONS_PAGE_LIST_XPATH = ".//*[@class='listBody']"

  #Record Type Page
  NEW_RECORD_TYPE_DROPDOWN_XPATH = ".//*[@class='detailList']//select"
  RECORD_TYPE_REQUISITION_TEXT = "Corporate"
  CONTINUE_BUTTON_XPATH = ".//*[@name='save']"
  
end