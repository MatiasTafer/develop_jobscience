class BoardSetupEditPage
  
  #PAGE HEADER
  BOARD_EDIT_SAVE_BUTTON_XPATH = ".//*[@value='Save']"
  BOARD_EDIT_CANCEL_BUTTON_XPATH = ".//*[@value='Cancel']"
  
  #GENERAL SECTION
    #REQUIRED FIELDS
  BOARD_EDIT_BOARD_SETUP_NAME_XPATH = ".//*[text()[contains(., 'Job Board Setup Name')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_BOARD_SETUP_TYPE_XPATH = ".//*[text()[contains(., 'Job Board Type')]]/../../following-sibling::*[1]//select"
  BOARD_EDIT_BOARD_SETUP_URL_XPATH = ".//*[text()[contains(., 'Site URL')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_BOARD_SETUP_ADDRESS_VALIDATION_XPATH = ".//*[text()[contains(., 'Address Validation')]]/../../following-sibling::*[1]//select"
    
    #REST OF THE FIELDS
  BOARD_EDIT_PRIMARY_XPATH = ".//*[text()[contains(., 'Primary')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_SHOW_SEARCH_ONLY_XPATH = ".//*[text()[contains(., 'Show Search Only')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_ALLOW_REGISTER_ONLY_XPATH = ".//*[text()[contains(., 'Allow Register Only')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_AUTO_ASSOCIATE_XPATH = ".//*[text()[contains(., 'Auto-Associate')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_RESUME_UPLOAD_XPATH = ".//*[text()[contains(., 'Hide Resume Upload')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_RESUME_REQUIRED_XPATH = ".//*[text()[contains(., 'Resume Required')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_RESUME_PASTE_XPATH = ".//*[text()[contains(., 'Hide Resume Paste')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_EMAIL_THIS_JOB_XPATH = ".//*[text()[contains(., 'Hide Email This Job')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_RESUME_BUILDER_XPATH = ".//*[text()[contains(., 'Hide Resume Builder')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_COVER_LETTER_XPATH = ".//*[text()[contains(., 'Hide Cover Letter')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH = ".//*[text()[contains(., 'Hide Resume Previously Uploaded')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_PHONE_XPATH = ".//*[text()[contains(., 'Hide Phone')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_ENABLE_ADDTHIS_XPATH = ".//*[text()[contains(., 'Enable AddThis')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_MOBILE_XPATH = ".//*[text()[contains(., 'Hide Mobile')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_ADDTHIS_USERNAME_XPATH = ".//*[text()[contains(., 'AddThis Username')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH = ".//*[text()[contains(., 'Hide Source Question')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HOMEPAGE_XPATH = ".//*[text()[contains(., 'HomePage')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_HIDE_CONTACT_METHOD_XPATH = ".//*[text()[contains(., 'Hide Contact Method')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_DISABLE_MOBILE_JOB_BOARD_XPATH = ".//*[text()[contains(., 'Disable Mobile Job Board')]]/../../following-sibling::*[1]//input"

  #CONFIRMATION MESSAGE SECTION
  BOARD_EDIT_CONFIRMATION_MESSAGE_XPATH = ".//h3[text()='Confirmation Message']/../following-sibling::*//textarea"
  
  #STANDARD QUESTIONS SECTION
  BOARD_EDIT_QUESTION_1_XPATH = "(.//*[text()= 'Standard Questions']/../following-sibling::*//child::td/select)[1]"
  BOARD_EDIT_QUESTION_2_XPATH = "(.//*[text()[contains(.,'Question 2')]])[1]/../following-sibling::*[1]//select"
  BOARD_EDIT_QUESTION_3_XPATH = "(.//*[text()[contains(.,'Question 3')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_QUESTION_4_XPATH = "(.//*[text()[contains(.,'Question 4')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_QUESTION_5_XPATH = "(.//*[text()[contains(.,'Question 5')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_QUESTION_6_XPATH = "(.//*[text()[contains(.,'Question 6')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_QUESTION_7_XPATH = "(.//*[text()[contains(.,'Question 7')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_QUESTION_8_XPATH = "(.//*[text()[contains(.,'Question 8')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_QUESTION_9_XPATH = "(.//*[text()[contains(.,'Question 9')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_QUESTION_10_XPATH = "(.//*[text()[contains(.,'Question 10')]])/../following-sibling::*[1]//select"

  #SEARCH & RESULTS SECTION
  BOARD_EDIT_SEARCH_CRITERIA_1_XPATH = "(.//*[text()[contains(.,'Search Criteria 1')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SEARCH_CRITERIA_2_XPATH = "(.//*[text()[contains(.,'Search Criteria 2')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SEARCH_CRITERIA_3_XPATH = "(.//*[text()[contains(.,'Search Criteria 3')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SEARCH_CRITERIA_4_XPATH = "(.//*[text()[contains(.,'Search Criteria 4')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SEARCH_CRITERIA_5_XPATH = "(.//*[text()[contains(.,'Search Criteria 5')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SEARCH_BY_KEYWORD_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[6]/td[1]/input"
  BOARD_EDIT_JOBS_PER_PAGE_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[7]/td[1]/select"
  
  BOARD_EDIT_SEARCH_RESULT_1_XPATH = "(.//*[text()[contains(.,'Search Result 1')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SEARCH_RESULT_2_XPATH = "(.//*[text()[contains(.,'Search Result 2')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SEARCH_RESULT_3_XPATH = "(.//*[text()[contains(.,'Search Result 3')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SEARCH_RESULT_4_XPATH = "(.//*[text()[contains(.,'Search Result 4')]])/../following-sibling::*[1]//select"
  
  #MOBILE JOB SEARCH SUMMARY FIELDS SECTION
  BOARD_EDIT_SUMMARIZE_1_XPATH = "(.//*[text()[contains(.,'Summarize 1')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SUMMARIZE_2_XPATH = "(.//*[text()[contains(.,'Summarize 2')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SUMMARIZE_3_XPATH = "(.//*[text()[contains(.,'Summarize 3')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SUMMARIZE_4_XPATH = "(.//*[text()[contains(.,'Summarize 4')]])/../following-sibling::*[1]//select"
  BOARD_EDIT_SUMMARIZE_5_XPATH = "(.//*[text()[contains(.,'Summarize 5')]])/../following-sibling::*[1]//select"
  
  #JOB DESCRIPTION FIELDS SECTION
  BOARD_EDIT_JOB_DESCRIPTION_1_XPATH = "(.//*[text()[contains(.,'Job Description 1')]]/../following-sibling::*[1]//select)[1]"
  BOARD_EDIT_JOB_DESCRIPTION_2_XPATH = ".//*[text()[contains(.,'Job Description 2')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_JOB_DESCRIPTION_3_XPATH = ".//*[text()[contains(.,'Job Description 3')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_JOB_DESCRIPTION_4_XPATH = ".//*[text()[contains(.,'Job Description 4')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_JOB_DESCRIPTION_5_XPATH = ".//*[text()[contains(.,'Job Description 5')]]/../following-sibling::*[1]//select"
  
  BOARD_EDIT_JOB_DESCRIPTION_6_XPATH = ".//*[text()[contains(.,'Job Description 6')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_JOB_DESCRIPTION_7_XPATH = ".//*[text()[contains(.,'Job Description 7')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_JOB_DESCRIPTION_8_XPATH = ".//*[text()[contains(.,'Job Description 8')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_JOB_DESCRIPTION_9_XPATH = ".//*[text()[contains(.,'Job Description 9')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_JOB_DESCRIPTION_10_XPATH = ".//*[text()[contains(.,'Job Description 10')]]/../following-sibling::*[1]//select"
  
  #LOCALIZATION FIELDS SECTION
  BOARD_EDIT_LOCALIZED_JOB_TITLE_XPATH = ".//*[text()[contains(.,'Localized Job Title')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_LOCALIZED_JOB_DESCRIPTION_XPATH = ".//*[text()[contains(.,'Localized Job Description')]]/../following-sibling::*[1]//select"
  
  #INDEED FEED FIELDS SECTION
  BOARD_EDIT_INDEED_FEED_COUNTRY_XPATH = ".//*[text()[contains(.,'Indeed Feed Country')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_INDEED_FEED_STATE_XPATH = ".//*[text()[contains(.,'Indeed Feed State')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_INDEED_FEED_CITY_XPATH = ".//*[text()[contains(.,'Indeed Feed City')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_INDEED_FEED_POSTAL_CODE_XPATH = ".//*[text()[contains(.,'Indeed Feed Postal Code')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_INDEED_FEED_DESCRIPTION_XPATH = ".//*[text()[contains(.,'Indeed Feed Description')]]/../following-sibling::*[1]//select"
  
  #EEO TEXT SECTION
  BOARD_EDIT_EEO_TEXT_XPATH = "(.//*[text()='EEO Text']/../following-sibling::*//div)[1]"
  BOARD_EDIT_HIDE_STANDARD_EEO_DISCLAIMER = ".//*[text()='Hide Standard EEO Disclaimer']/../../following-sibling::*//input"
  
  #EEO QUESTIONS SECTION
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH = ".//*[text()[contains(.,'Gender')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_VETERAN_XPATH = ".//*[text()[contains(.,'Veteran')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_REQUIRED_XPATH = ".//*[text()[contains(.,'EEO Fields Required')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_RACE_XPATH = ".//*[text()[contains(.,'Race')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_DISABLED_XPATH = ".//*[text()[contains(.,'Disabled')]]/../following-sibling::*[1]//input"
  
  #PRIVACY POLICY STATEMENT SECTION
  BOARD_EDIT_PRIVACY_POLICY_STATEMENT_XPATH = ".//*[text()='Privacy Policy Statement']/../following-sibling::*//textarea"
  BOARD_EDIT_DISPLAY_PRIVACY_STATEMENT_XPATH = ".//*[text()='Display Privacy Statement']/../../following-sibling::*//input"
  
  #REFERRAL PROGRAM SECTION
  BOARD_EDIT_APPLY_REFERRAL_IMMEDIATELY_XPATH = ".//*[text()[contains(.,'Apply Referral Immediately')]]/../following-sibling::*[1]//input"
  BOARD_EDIT_RESUME_SUBMISSION_ALLOWED_XPATH = ".//*[text()[contains(.,'Resume Submission Allowed')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_ENABLE_SUBMISSION_FEEDBACK_XPATH = ".//*[text()[contains(.,'Enable Submission Feedback')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_REQUIRE_SUBMISSION_FEEDBACK_XPATH = ".//*[text()[contains(.,'Require Submission Feedback')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_ENABLE_EMPLOYEE_STATUS_CHECK_XPATH = ".//*[text()[contains(.,'Enable Employee Status Check')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_ENABLE_LEAD_TRACKING_XPATH = ".//*[text()[contains(.,'Enable Lead Tracking')]]/../../following-sibling::*[1]//input"
  
  BOARD_EDIT_INTERNAL_APPLICATION_PROCESS_XPATH = ".//*[text()[contains(.,'Internal Application Process')]]/../following-sibling::*[1]//select"
  BOARD_EDIT_REFERRAL_EXPIRATION_DAYS_XPATH = ".//*[text()[contains(.,'Referral Expiration Days')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_MAX_NUMBER_OPEN_REFERRALS_XPATH = ".//*[text()[contains(.,'Max Number Open Referrals')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_MAX_NUMBER_REFERRALS_PER_CONTACT_XPATH = ".//*[text()[contains(.,'Max Number Referrals Per Contact')]]/../../following-sibling::*[1]//input"
  BOARD_EDIT_SOURCE_TRACKING_FOR_INTERNAL_REFERRAL_XPATH = ".//*[text()[contains(.,'Source Tracking for Internal Referrals')]]/../following-sibling::*[1]//span/input"
  BOARD_EDIT_EMPLOYEE_ACCOUNT_XPATH = ".//*[text()[contains(.,'Employee Account')]]/../../following-sibling::*[1]//span/input"

end