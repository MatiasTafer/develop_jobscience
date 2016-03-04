class ForwardPopup
  
  # Forward pop-up
  TO_ICON_ID = "j_id0:j_id1:j_id2:frm:pbSendEmail:j_id39:j_id48:j_id52_lkwgt"
  TO_TEXT_XPATH = ".//*[@id='j_id0:j_id1:j_id2:frm:pbSendEmail:j_id39:j_id48:j_id52']"
  SUBJECT_TEXT_XPATH = ".//*[@id='j_id0:j_id1:j_id2:frm:pbSendEmail:j_id39:j_id77:j_id79']/input"
  
  CONTACT_TO_TEXT_XPATH = ".//*[@id='j_id0:j_id21:j_id22:frm:pbSendEmail:j_id59:j_id68:j_id72']"
  CONTACT_SUBJECT_TEXT_XPATH = ".//*[@id='j_id0:j_id21:j_id22:frm:pbSendEmail:j_id59:j_id97:j_id99']/input"
  
  ATTACHMENTS_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id1:j_id2:frm:pbSendEmail:j_id88:j_id89:0:j_id90']/input"
  CONTACT_ATTACHMENTS_CHECKBOX_XPATH = ".//*[@id='j_id0:j_id21:j_id22:frm:pbSendEmail:j_id108:j_id109:0:j_id110']/input"
  
  SEND_BUTTON_XPATH = ".//*[@value='Send']"
  CLOSE_BUTTON_XPATH = ".//*[@value='Close']"
  CANCEL_BUTTON_XPATH = ".//*[@value='Cancel']"
  SELECT_TEMPLATE_BUTTON_ID = "j_id0:j_id1:j_id2:frm:pbSendEmail:pbbsMainButtons:bottom"
  SELECT_TEMPLATE_BUTTON_XPATH = ".//*[@id='j_id0:j_id1:j_id2:frm:pbSendEmail:pbbsMainButtons:bottom']/input[2]"
  CONTACT_SELECT_TEMPLATE_BUTTON_XPATH = ".//*[@id='j_id0:j_id21:j_id22:frm:pbSendEmail:pbbsMainButtons:bottom']/input[2]"
  
  TEMPLATE_RECORD_ID = "j_id0:frm:fcf_Templates:j_id7:0:j_id10"
  FIRST_ELEMENT_SELECT_TEMPLATE_XPATH = ".//*[@id='j_id0:frm:fcf_Templates:j_id7:0:j_id10']"
  
  BCC_TEXT_XPATH = ".//*[@id='j_id0:j_id1:j_id2:frm:pbSendEmail:j_id39:j_id69:ctrBcc']"
  BCC_EMAIL_CANDIDATE_XPATH = ".//*[@id='j_id0:frm:j_id31:j_id53:j_id58:ecndBCC']"
end