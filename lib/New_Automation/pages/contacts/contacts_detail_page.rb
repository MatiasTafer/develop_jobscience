class ContactDetailPage
  
  FORWARD_CONTACT_BUTTON_XPATH = ".//*[@value='Forward Contact']"
  CONTACT_DETAIL_NAME_XPATH = "//td[text()[starts-with(., 'Name')]]/following-sibling::*[1]/div"
  CONTACT_DETAIL_SKILL_LIST_FIRST_XPATH = "(//*[text()[contains(., 'SKL')]]/../..)[1]"
  CONTACT_DETAIL_SKILL_LIST_SECOND_XPATH = "(//*[text()[contains(., 'SKL')]]/../..)[2]"
  CONTACT_DETAIL_RECORD_SKILL_LIST_FIRST_XPATH = "(//a[text()[contains(., 'SKL')]])[1]"
  CONTACT_DETAIL_RECORD_SKILL_LIST_SECOND_XPATH = "(//a[text()[contains(., 'SKL')]])[2]"
  CONTACT_DETAIL_APPLICATIONS_LIST_XPATH = "//*[text()[contains(., 'APP')]]/../../.."
  CONTACT_DETAIL_BTN_ADD_SKILL_XPATH = "(.//input[@value='Add Skills'])[1]"
  CONTACT_DETAIL_BTN_ADD_TO_LIST_XPATH = "(.//input[@value='Add to List'])[1]"
  CONTACT_DETAIL_BTN_APPLY_TO_JOB_XPATH = "(.//input[@value='Apply To Jobs'])[1]"
  CONTACT_DETAIL_BTN_NEW_EDUCATION_HIST_XPATH = ".//*[@value='New Education History']"
  CONTACT_DETAIL_BTN_NEW_EMPLOYMENT_HIST_XPATH = ".//*[@value='New Employment History']"
  CONTACT_DETAIL_BTN_NEW_UPDATE_RESUME_XPATH = "(.//*[@value='Resume Update'])[1]"
  CONTACT_DETAIL_BTN_EDIT_XPATH = ".//*[@name='edit']"
  CONTACT_DETAIL_BTN_DELETE_XPATH = ".//*[@name='del']"
  CONTACT_DETAIL_HOVER_LINKS_XPATH = ".//*[@class='listHoverLinks']"
  CONTACT_DETAIL_MAILING_ADDRESS_XPATH = "((//*[text()[contains(., 'Mailing Address')]]/following-sibling::*)//tr/td)[1]"
  CONTACT_DETAIL_MAILING_ADDRESS_IE_XPATH = "//*[text()[contains(., 'Mailing Address')]]/following-sibling::*"
  CONTACT_DETAIL_COUNTRY_XPATH = "//*[text()[contains(., 'Mailing Country Text')]]/following-sibling::*//div" 
  CONTACT_DETAIL_APP_LIST_FIRST_XPATH = "(//*[text()[contains(., 'APP')]]/../..//th/a)[1]"
  CONTACT_DETAIL_APP_LIST_SECOND_XPATH = "(//*[text()[contains(., 'APP')]]/../..//th/a)[2]"
  CONTACT_DETAIL_APP_LIST_XPATH = "//*[text()[contains(., 'APP')]]/../../../../../../.."
  CONTACT_DETAIL_JCARD_XPATH = ".//*[@class='jck-panel-header']"
  CONTACT_DETAIL_RESUME_IFRAME_ID = ".//*[@title='flash_resume']"
  CONTACT_DETAIL_APP_LIST_FIRST_APP_XPATH = "(//*[text()[contains(., 'APP')]])[1]"
  CONTACT_DETAIL_NOTES_ATTACH_LIST_XPATH = "//*[text()='Attachment']/../.."
  CONTACT_DETAIL_NOTES_ATTACH_LIST_FIRST_XPATH = "(//*[text()='Attachment']/..)[1]"
  CONTACT_DETAIL_NOTES_ATTACH_LIST_SECOND_XPATH = "(//*[text()='Attachment']/..)[2]"
  CONTACT_DETAIL_NOTES_ATTACH_LIST_THIRD_XPATH = "(//*[text()='Attachment']/..)[3]"
  CONTACT_DETAIL_NOTES_ATTACH_LIST_FOURTH_XPATH = "(//*[text()='Attachment']/..)[4]"
  CONTACT_DETAIL_NOTES_ATTACH_LIST_FIFTH_XPATH = "(//*[text()='Attachment']/..)[5]"
  CONTACT_DETAIL_EMPLOYMENT_LIST_XPATH = "//*[text()='Assessment']/../.."
  CONTACT_DETAIL_EMPLOYMENT_LIST_FIRST_NAME_XPATH = "(//*[text()[contains(., 'EMP')]])[1]"
  CONTACT_DETAIL_EDUCATION_LIST_FIRST_XPATH = "(//*[text()[contains(., 'SCH')]])[1]"
  CONTACT_DETAIL_EMPLOYMENT_TITLE_1_XPATH = "((//*[text()[contains(., 'EMP')]])[1]/../..//td)[3]"
  CONTACT_DETAIL_DEGREE_NAME_1_XPATH = "//*[text()='Education Degree Name 1']/following-sibling::*[1]/div"
  
  #CONTACT NAMES CREATED FROM PARSING RESUMES
  CONTACT_NAME_1_TEXT = "Manuel Gonzales"
  CONTACT_NAME_FROM_FILES_1_TEXT = "test2016 Manolo"
  
  
  
  
end