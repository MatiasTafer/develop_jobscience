class AdvancedContactSearchHomePage

  # Keyword Search Tab
  KEYWORD_TAB_XPATH = "(.//*[@class='rich-tabhdr-side-cell']/table)[1]"

  SEARCH_CANDIDATE_ONLY_CHECKBOX_XPATH = "(.//*[@type='checkbox'])[1]"
  CLEAR_K_BUTTON_XPATH = "(.//*[@value='Clear'])[1]"
  ALL_THESE_WORDS_LABEL_XPATH = "(.//*[@class='data2Col'])[1]/span" 
  SOME_THESE_WORDS_LABEL_XPATH = "//*[text()[contains(., 'some of these words:')]]/../..//input"
  ANY_THESE_UNWANTED_WORDS_LABEL_XPATH = "//*[text()[contains(., 'any of these unwanted words:')]]/../..//input"

  # Keyword Search Tab - Additional Search Criteria
  FIRST_NAME_TEXT_XPATH = "(//*[text()[contains(., 'First Name')]]/../..//input)[1]"
  LAST_NAME_TEXT_XPATH = "(//*[text()[contains(., 'Last Name')]]/../..//input)[1]"
  EMAIL_TEXT_XPATH = "((.//*[@class='detailList']//tr)[9]//input)[1]"
  LOCATION_SELECT_XPATH = "//*[text()[contains(., 'Location')]]/../..//select"
  COUNTRY_SELECT_XPATH = "//*[text()[contains(., 'Country')]]/../..//select"
  STATEPROVINCE_TEXT_XPATH = "//*[text()[contains(., 'State/Province')]]/../..//input"
  CITY_TEXT_XPATH = "(.//*[@class='dataCol col02'])[7]//input"
  ZIP_POSTAL_CODE_TEXT_XPATH = "(.//*[@class='dataCol col02'])[8]//input"
  WITHIN_SELECT_XPATH = "(.//*[@class='dataCol col02'])[9]//select"
  TITLE_TEXT_XPATH = "(//*[text()[contains(., 'Title')]]/../..)[2]//input"
  COMPANY_TEXT_XPATH = "((//*[text()[contains(., 'Company')]]/../..)//input)[2]"
  SCHOOL_TEXT_XPATH = "((//*[text()[contains(., 'School')]]/../..)//input)[2]"
  DATE_AVAILABLE_TEXT_XPATH = ".//*[@class='dateInput dateOnlyInput']//input"

  # Quick Boolean Tab
  QUICK_BOOLEAN_TAB_XPATH = "//*[text()[contains(., 'Quick Boolean')]]" 

  SEARCH_Q_BUTTON_XPATH = "(.//*[@class='pbButton']//input)[3]"
  CLEAR_Q_BUTTON_XPATH = "(.//*[@class='pbButton']//input)[4]"
  KEYWORD_TEXT_XPATH = "(//*[text()[contains(., 'Keyword')]])[3]/../..//input"

  # Skills Tab
  SKILLS_TAB_XPATH = "(//*[text()[contains(., 'Skills')]])[1]"
  SEARCH_S_BUTTON_XPATH = "(.//*[@class='pbButton']//input)[5]"
  CLEAR_S_BUTTON_XPATH = "(.//*[@class='pbButton']//input)[6]"


  MIN_YEARS1_SELECT_XPATH = "(//*[text()[contains(., 'Min Years')]]/../../../..//tr//select)[1]"
  MIN_YEARS2_SELECT_XPATH = "(//*[text()[contains(., 'Min Years')]]/../../../..//tr//select)[3]"

  MAX_YEARS1_XPATH = "(//*[text()[contains(., 'Max Years')]]/../../../..//select)[2]"
  MAX_YEARS2_XPATH = "(//*[text()[contains(., 'Max Years')]]/../../../..//select)[4]"

  RECENT1_CHECKBOX_ID = "(//*[text()[contains(., 'Recent')]]/../../../..//td)[5]//input"

  ALL_SKILLS_REQUIRED_CHECKBOX_XPATH = "(.//*[@type='checkbox'])[7]"
  TITLE_TEXT_XPATH = "(//*[text()[contains(., 'Title')]]/..)[3]/..//input"
  COMPANY_TEXT_XPATH = "(//*[text()[contains(., 'Company')]])[2]/../..//input"
  IN_WORKFORCE_FROM_SELECT_XPATH = "(//*[text()[contains(., 'In Workforce From')]]/../..//select)[1]"
  IN_WORKFORCE_TO_SELECT_XPATH = "(//*[text()[contains(., 'In Workforce From')]]/../..//select)[2]"
  IN_MANAGEMENT_FROM_SELECT_ID = "ssPg:topFm:intelSearchPb:intelComp:intelCompPg:mgmFmIf']"
  IN_MANAGEMENT_TO_SELECT_ID = "ssPg:topFm:intelSearchPb:intelComp:intelCompPg:mgmToIf"
  MINIMUM_DEGREE_SELECT_ID = "ssPg:topFm:intelSearchPb:intelComp:intelCompPg:degreeIf"
  GPA_SELECT_ID = "ssPg:topFm:intelSearchPb:intelComp:intelCompPg:gpaIf"
  LANGUAGE_SELECT_ID = "ssPg:topFm:intelSearchPb:intelComp:intelCompPg:langIf"

  # Match Tab
  MATCH_TAB_ID = "ssPg:topFm:matchTab_lbl"
  CLEAR_M_BUTTON_ID = "ssPg:topFm:matchSearchPb:matchSearchPbBtns:matchClearBtn"

  JOB_TEXT_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:jobMatchIf"
  JOB_ICON_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:jobMatchIf_lkwgt"
  JOB_MATCH_SEARCH_BUTTON_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:jobSearchBtn"

  CANDIDATE_TEXT_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:resumeMatchIf"
  CANDIDATE_ICON_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:resumeMatchIf_lkwgt"
  RESUME_MATCH_SEARCH_BUTTON_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:resumeSearchBtn"

  PROJECT_TEXT_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:projectMatchIf"
  PROJECT_ICON_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:projectMatchIf_lkwgt"
  PROJECT_MATCH_SEARCH_BUTTON_ID = "ssPg:topFm:matchSearchPb:matchComp:matchComp:projectSearchBtn"

  # Saved Tab
  SAVED_TAB_ID = "ssPg:topFm:namedTab_lbl"

  # History Tab
  HISTORY_TAB_ID = "ssPg:topFm:histTab_lbl"

end