class BoardSetupEditPage
  
  #PAGE HEADER
  BOARD_EDIT_SAVE_BUTTON_XPATH = ".//*[@value='Save']"
  BOARD_EDIT_CANCEL_BUTTON_XPATH = ".//*[@value='Cancel']"
  
  #GENERAL SECTION
    #REQUIRED FIELDS
  BOARD_EDIT_BOARD_SETUP_NAME_XPATH = "(.//*[@class='requiredInput'])[1]//*[@type='text']"
  BOARD_EDIT_BOARD_SETUP_TYPE_XPATH = "(.//*[@class='requiredInput'])[2]/select"
  BOARD_EDIT_BOARD_SETUP_URL_XPATH = "(.//*[@class='requiredInput'])[3]//*[@type='text']"
  BOARD_EDIT_BOARD_SETUP_ADDRESS_VALIDATION_XPATH = "(.//*[@class='requiredInput'])[4]/select"
    
    #REST OF THE FIELDS
  BOARD_EDIT_PRIMARY_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[3]/td[1]//*[@type='checkbox']"
  BOARD_EDIT_SHOW_SEARCH_ONLY_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[4]/td[1]//*[@type='checkbox']"
  BOARD_EDIT_ALLOW_REGISTER_ONLY_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[5]/td[1]//*[@type='checkbox']"
  BOARD_EDIT_AUTO_ASSOCIATE_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[5]/td[2]//*[@type='checkbox']"
  BOARD_EDIT_HIDE_RESUME_UPLOAD_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[6]/td[1]//*[@type='checkbox']"
  BOARD_EDIT_RESUME_REQUIRED_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[6]/td[2]//*[@type='checkbox']"
  BOARD_EDIT_HIDE_RESUME_PASTE_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[7]/td[1]//*[@type='checkbox']"
  BOARD_EDIT_HIDE_EMAIL_THIS_JOB_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[7]/td[2]//*[@type='checkbox']"
  BOARD_EDIT_HIDE_RESUME_BUILDER_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[8]/td[1]//*[@type='checkbox']"
  BOARD_EDIT_HIDE_COVER_LETTER_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[8]/td[2]//*[@type='checkbox']"
  BOARD_EDIT_HIDE_RESUME_PREVIOUSLY_UPLOADED_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[9]/td[1]//*[@type='checkbox']"
  BOARD_EDIT_HIDE_PHONE_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[9]/td[2]//*[@type='checkbox']"
  BOARD_EDIT_ENABLE_ADDTHIS_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[10]/td[1]//*[@type='checkbox']"
  BOARD_EDIT_HIDE_MOBILE_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[10]/td[2]//*[@type='checkbox']"
  BOARD_EDIT_ADDTHIS_USERNAME_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[11]/td[1]//*[@type='text']"
  BOARD_EDIT_HIDE_SOURCE_QUESTION_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[11]/td[2]//*[@type='checkbox']"
  BOARD_EDIT_HOMEPAGE_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[12]/td[1]//*[@type='text']"
  BOARD_EDIT_HIDE_CONTACT_METHOD_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[12]/td[2]//*[@type='checkbox']"
  BOARD_EDIT_DISABLE_MOBILE_JOB_BOARD_XPATH = "((.//*[@class='detailList'])[1])/tbody/tr[13]/td[1]//*[@type='checkbox']"

  #CONFIRMATION MESSAGE SECTION
  BOARD_EDIT_CONFIRMATION_MESSAGE_XPATH = "((.//*[@class='detailList'])[2])/tbody/tr/td/textarea"
  
  #STANDARD QUESTIONS SECTION
  BOARD_EDIT_QUESTION_1_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[1]/td[1]/select"
  BOARD_EDIT_QUESTION_2_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[2]/td[1]/select"
  BOARD_EDIT_QUESTION_3_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[3]/td[1]/select"
  BOARD_EDIT_QUESTION_4_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[4]/td[1]/select"
  BOARD_EDIT_QUESTION_5_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[5]/td[1]/select"
  BOARD_EDIT_QUESTION_6_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[6]/td[1]/select"
  BOARD_EDIT_QUESTION_7_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[7]/td[1]/select"
  BOARD_EDIT_QUESTION_8_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[8]/td[1]/select"
  BOARD_EDIT_QUESTION_9_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[9]/td[1]/select"
  BOARD_EDIT_QUESTION_10_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[10]/td[1]/select"
  
  BOARD_EDIT_QUESTION_11_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[1]/td[2]/select"
  BOARD_EDIT_QUESTION_12_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[2]/td[2]/select"
  BOARD_EDIT_QUESTION_13_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[3]/td[2]/select"
  BOARD_EDIT_QUESTION_14_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[4]/td[2]/select"
  BOARD_EDIT_QUESTION_15_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[5]/td[2]/select"
  BOARD_EDIT_QUESTION_16_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[6]/td[2]/select"
  BOARD_EDIT_QUESTION_17_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[7]/td[2]/select"
  BOARD_EDIT_QUESTION_18_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[8]/td[2]/select"
  BOARD_EDIT_QUESTION_19_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[9]/td[2]/select"
  BOARD_EDIT_QUESTION_20_XPATH = "((.//*[@class='detailList'])[3])/tbody/tr[10]/td[2]/select"

  #SEARCH & RESULTS SECTION
  BOARD_EDIT_SEARCH_CRITERIA_1_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[1]/td[1]/select"
  BOARD_EDIT_SEARCH_CRITERIA_2_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[2]/td[1]/select"
  BOARD_EDIT_SEARCH_CRITERIA_3_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[3]/td[1]/select"
  BOARD_EDIT_SEARCH_CRITERIA_4_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[4]/td[1]/select"
  BOARD_EDIT_SEARCH_CRITERIA_5_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[5]/td[1]/select"
  BOARD_EDIT_SEARCH_BY_KEYWORD_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[6]/td[1]/input"
  BOARD_EDIT_JOBS_PER_PAGE_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[7]/td[1]/select"
  
  BOARD_EDIT_SEARCH_RESULT_1_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[1]/td[2]/select"
  BOARD_EDIT_SEARCH_RESULT_2_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[2]/td[2]/select"
  BOARD_EDIT_SEARCH_RESULT_3_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[3]/td[2]/select"
  BOARD_EDIT_SEARCH_RESULT_4_XPATH = "((.//*[@class='detailList'])[4])/tbody/tr[4]/td[2]/select"
  
  #MOBILE JOB SEARCH SUMMARY FIELDS SECTION
  BOARD_EDIT_SUMMARIZE_1_XPATH = "((.//*[@class='detailList'])[5])/tbody/tr[1]/td[1]/select"
  BOARD_EDIT_SUMMARIZE_2_XPATH = "((.//*[@class='detailList'])[5])/tbody/tr[2]/td[1]/select"
  BOARD_EDIT_SUMMARIZE_3_XPATH = "((.//*[@class='detailList'])[5])/tbody/tr[3]/td[1]/select"
  BOARD_EDIT_SUMMARIZE_4_XPATH = "((.//*[@class='detailList'])[5])/tbody/tr[4]/td[1]/select"
  BOARD_EDIT_SUMMARIZE_5_XPATH = "((.//*[@class='detailList'])[5])/tbody/tr[5]/td[1]/select"
  
  #JOB DESCRIPTION FIELDS SECTION
  BOARD_EDIT_JOB_DESCRIPTION_1_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[1]/td[1]/select"
  BOARD_EDIT_JOB_DESCRIPTION_2_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[2]/td[1]/select"
  BOARD_EDIT_JOB_DESCRIPTION_3_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[3]/td[1]/select"
  BOARD_EDIT_JOB_DESCRIPTION_4_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[4]/td[1]/select"
  BOARD_EDIT_JOB_DESCRIPTION_5_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[5]/td[1]/select"
  
  BOARD_EDIT_JOB_DESCRIPTION_6_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[1]/td[2]/select"
  BOARD_EDIT_JOB_DESCRIPTION_7_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[2]/td[2]/select"
  BOARD_EDIT_JOB_DESCRIPTION_8_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[3]/td[2]/select"
  BOARD_EDIT_JOB_DESCRIPTION_9_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[4]/td[2]/select"
  BOARD_EDIT_JOB_DESCRIPTION_10_XPATH = "((.//*[@class='detailList'])[6])/tbody/tr[5]/td[2]/select"
  
  #LOCALIZATION FIELDS SECTION
  BOARD_EDIT_LOCALIZED_JOB_TITLE_XPATH = "((.//*[@class='detailList'])[7])/tbody/tr[1]/td[1]/select"
  BOARD_EDIT_LOCALIZED_JOB_DESCRIPTION_XPATH = "((.//*[@class='detailList'])[7])/tbody/tr[1]/td[2]/select"
  
  #INDEED FEED FIELDS SECTION
  BOARD_EDIT_INDEED_FEED_COUNTRY_XPATH = "((.//*[@class='detailList'])[8])/tbody/tr[1]/td[1]/select"
  BOARD_EDIT_INDEED_FEED_STATE_XPATH = "((.//*[@class='detailList'])[8])/tbody/tr[2]/td[1]/select"
  BOARD_EDIT_INDEED_FEED_CITY_XPATH = "((.//*[@class='detailList'])[8])/tbody/tr[3]/td[1]/select"
  BOARD_EDIT_INDEED_FEED_POSTAL_CODE_XPATH = "((.//*[@class='detailList'])[8])/tbody/tr[4]/td[1]/select"
  BOARD_EDIT_INDEED_FEED_DESCRIPTION_XPATH = "((.//*[@class='detailList'])[8])/tbody/tr[1]/td[2]/select"
  
  #EEO TEXT SECTION
  BOARD_EDIT_EEO_TEXT_XPATH = "((.//*[@class='detailList'])[9]//div)[1]"
  BOARD_EDIT_HIDE_STANDARD_EEO_DISCLAIMER = "((.//*[@class='detailList'])[9])/tbody/tr[3]/td/input"
  
  #EEO QUESTIONS SECTION
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_GENDER_XPATH = "((.//*[@class='detailList'])[10])/tbody/tr[2]/td[1]/input"
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_VETERAN_XPATH = "((.//*[@class='detailList'])[10])/tbody/tr[3]/td[1]/input"
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_REQUIRED_XPATH = "((.//*[@class='detailList'])[10])/tbody/tr[4]/td[1]/input"
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_RACE_XPATH = "((.//*[@class='detailList'])[10])/tbody/tr[2]/td[2]/input"
  BOARD_EDIT_EEO_QUESTION_CHECKBOX_DISABLED_XPATH = "((.//*[@class='detailList'])[10])/tbody/tr[3]/td[2]/input"
  
  #PRIVACY POLICY STATEMENT SECTION
  BOARD_EDIT_PRIVACY_POLICY_STATEMENT_XPATH = "((.//*[@class='detailList'])[11])/tbody/tr[1]/td/textarea"
  BOARD_EDIT_DISPLAY_PRIVACY_STATEMENT_XPATH = "((.//*[@class='detailList'])[11])/tbody/tr[2]/td/input"
  
  #REFERRAL PROGRAM SECTION
  BOARD_EDIT_APPLY_REFERRAL_IMMEDIATELY_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[1]/td[1]/input"
  BOARD_EDIT_RESUME_SUBMISSION_ALLOWED_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[2]/td[1]/input"
  BOARD_EDIT_ENABLE_SUBMISSION_FEEDBACK_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[3]/td[1]/input"
  BOARD_EDIT_REQUIRE_SUBMISSION_FEEDBACK_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[4]/td[1]/input"
  BOARD_EDIT_ENABLE_EMPLOYEE_STATUS_CHECK_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[5]/td[1]/input"
  BOARD_EDIT_ENABLE_LEAD_TRACKING_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[6]/td[1]/input"
  
  BOARD_EDIT_INTERNAL_APPLICATION_PROCESS_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[1]/td[2]/select"
  BOARD_EDIT_REFERRAL_EXPIRATION_DAYS_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[2]/td[2]/input"
  BOARD_EDIT_MAX_NUMBER_OPEN_REFERRALS_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[3]/td[2]/input"
  BOARD_EDIT_MAX_NUMBER_REFERRALS_PER_CONTACT_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[4]/td[2]/input"
  BOARD_EDIT_SOURCE_TRACKING_FOR_INTERNAL_REFERRAL_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[5]/td[2]/span/input"
  BOARD_EDIT_EMPLOYEE_ACCOUNT_XPATH = "((.//*[@class='detailList'])[12])/tbody/tr[6]/td[2]/span/input"

end