class ShortListSendEmailPopup
  
  ADDITIONAL_TO_TEXT_XPATH = "(.//*[@class='detailList'])[1]//tr[1]//div"
  ADDITIONAL_TO_ICON_XPATH = "(.//*[@class='detailList'])[1]//tr[1]//a"
  CC_TEXT_XPATH = "(.//*[@class='detailList'])[1]//tr[2]//div"
  CC_ICON_XPATH = "(.//*[@class='detailList'])[1]//tr[2]//a"
  SUBJECT_TEXT_XPATH = "(.//*[@class='detailList'])[1]//tr[4]//input"
  RECORD_ATTACHMENT_XPATH = "(.//*[@type='checkbox'])[1]"
  SEND_BUTTON_XPATH = ".//*[@value='Send']"
  SELECT_TEMPLATE_BUTTON_XPATH = ".//*[@value='Select Template***']"
  CLOSE_SEND_EMAIL_XPATH = ".//*[@class='fa fa-close']"
  BCC_TEXT_XPATH = "(.//*[@class='detailList'])[1]//tr[3]//textarea"
  
end