class AddContactPopUp
  
  CONTACT_NAME_TEXTBOX_XPATH = ".//*[@class='lookupInput']/input"
  ADD_TO_SHORT_LIST_BUTTON_XPATH = ".//*[@title='Add to Short List']"
  CLOSE_BUTTON_XPATH = ".//*[@title='Close']"
  
  CONTACT_NAME_TEXT = "Alberto Ferla"
  
  SUCCESS_MESSAGE_XPATH = ".//*[@class='message confirmM3']"
  SUCCESS_MESSAGE_TEXT_XPATH = ".//*[@class='messageCell']/div"
  
  SUCCESS_MESSAGE_TEXT = "Contacts Added Successfully"
  
  ERROR_MESSAGE_XPATH = ".//*[@class='message errorM3']"
  ERROR_MESSAGE_TEXT_XPATH = ".//*[@class='messageCell']/div"
  
  ERROR_MESSAGE_TEXT = "Error:\nContact: You must enter a value"
  
end