class ContactsHomePage
  
  CONTACT_RECORD_XPATH  = ".//*[@class='dataRow even first']/child::th/child::a"
  CONTACT_HOME_PAGE_BTN_NEW = ".//*[@class='pbButton']/input"
  CONTACT_HOME_VIEW_SELECT_XPATH = ".//*[@id='fcf']"
  CONTACT_HOME_BTN_GO_XPATH = ".//*[@name='go']"
  
  #After pressing "GO" button
  CONTACT_HOME_CONTACT_LIST_XPATH = ".//*[@id='ext-gen25']"
  CONTACT_HOME_ADD_SKILL_XPATH = ".//*[@name='ts2__add_skills']"
  
  #Add Skill Pop Up Window
  CONTACT_SKILL_POPUP_FIRST_ELEMENT_XPATH = "(.//*[@class='first_level']//input)[1]"
  CONTACT_SKILL_POPUP_SECOND_ELEMENT_XPATH = "(.//*[@class='first_level']//input)[2]"
  CONTACT_SKILL_POPUP_ARROW_RIGHT_XPATH = ".//*[@class='fa fa-chevron-right']" 
  CONTACT_SKILL_POPUP_BTN_SAVE_XPATH = ".//*[@title='Save Skills']"
  CONTACT_SKILL_POPUP_BTN_SAVE_RATE_XPATH = ".//*[@value='Save & Rate Skills']"
  CONTACT_SKILL_POPUP_BTN_CLOSE_XPATH = ".//*[@value='Close']"
  CONTACT_SKILL_POPUP_SKILL_LIST_2_ELEMENT_XPATH = "(.//*[@class = 'detailList'])[2]//td[last()]//option[2]"
  CONTACT_SKILL_POPUP_RATE_SKILL_BTN_SUBMIT_XPATH = ".//*[@value='Submit']"
  CONTACT_SKILL_POPUP_RATE_SLIDER_1_XPATH = "(.//*[@class='ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all'])[1]//a"
  CONTACT_SKILL_POPUP_RATE_SLIDER_2_XPATH = "(.//*[@class='ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all'])[2]//a"

end