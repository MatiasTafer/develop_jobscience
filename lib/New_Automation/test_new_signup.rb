require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/new_signup_page.rb'



class NewSignup < TestBasic
 
#SUCCESSFULLY NEW SIGN UP (TC1565)

  def test_SuccessfullySignup
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 2 
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select "haven't decided yet" checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 4
    #The adding photo method is needed, but provisionally we are using the "Skip I'll do it later" link.
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #"Skip I'll do it later" link click
    $browser.find_element(:xpath => NewSignupPage::SKIP_DO_IT_LATER_BUTTON_XPATH).click
    
    #STEP 5
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #Clear URL textbox and set a new URL.
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
    }
    
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys Common.generate_url
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
    }
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP LAST
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    #Complete fields 
    $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).send_keys Common.generate_email(NewSignupPage::GENERATE_EMAIL)
    $browser.find_element(:xpath => NewSignupPage::PASSWORD_TEXTBOX_XPATH).send_keys NewSignupPage::PASSWORD_TEXT
    Common.wait_to_load
    
    #Check they are completed
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::OK2_XPATH).displayed?
    }
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #FINISH
    #Check the finish page is displayed
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::GET_STARTED_BUTTON_XPATH).displayed?
    }
  end

  #SIGN UP WITHOUT SPECIFYING YOUR FIRST OR LAST NAME (TC1566)
  def test_NoFirstorLastName
    
    #STEP 1 
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::NAME_ONLY
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    Common.wait_to_load
    
    #Check that "Next" button is displayed disabled, and the message error is displayed properly
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NAME_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NAME_ERROR_XPATH ).text == NewSignupPage::NAME_ERROR_TEXT
    }
  end

  #SIGN UP WITHOUT CHOOSING IF YOU'RE BRIDE OR GROOM (TC1567)
  def test_NoChossingBrideGroom
    
    #STEP 1 
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #Check that "Next" button is displayed disable.
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
    }
  end

  #SIGN UP USING ONLY YOUR PARTNER'S FIRST OR LAST NAME (TC1568)
  def test_NoPartnerFirstorLastName
    
    #STEP 1
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1") 
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::NAME_ONLY
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    Common.wait_to_load
    
    #Check that "Next" button is displayed disable, and the message error is displayed properly
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NAME_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NAME_ERROR_XPATH).text == NewSignupPage::NAME_ERROR_TEXT
    }
  end

  #SIGN UP WITHOUT CHOOSING IF YOUR PARTNER IS BRIDE OR GROOM (TC1569)
  def test_NoPartnerWeddingDate
    
    #STEP 1 
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::NAME_ONLY
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #Check that "Next" button is displayed disable, and the message error is displayed properly
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
    }
  end

  
  #SIGN UP WITHOUT SPECIFYING WEDDING DATE OR CHOOSING "HAVEN'T DECIDED YET" (TC1570)

  #This test will check that if no wedding date is selected and the ckeckbox "Haven't decided yet" isn't checked, the "Next" button will be disable.
  #Also checks that if you enter an invalid value in date field, the "Next" button continue disabled and an error message is displayed.

  def test_NoWeddingDate
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Check if date field is empty and if "HAVEN'T DECIDED YET" checkbox is unchecked; if so checks that the "Next" button is disable
    if $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).attribute("checked").nil? && $browser.find_element(:xpath => NewSignupPage::DATE_TEXTBOX_XPATH).text == ""
       assert $wait.until{
          $browser.find_element(:xpath => NewSignupPage::STEP_TWO_DISABLE_NEXT_BUTTON_XPATH).displayed?
        }  
    end 
    
    #Enters a wrong value at date field
    $browser.find_element(:xpath => NewSignupPage::DATE_TEXTBOX_XPATH).send_keys NewSignupPage::WRONG_DATE
    
    #Click on div to shoot the error message
    $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH ).click
    Common.wait_to_load
    
    #Check the error message and the "Next" button disable
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::DATE_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::DATE_ERROR_XPATH).text == NewSignupPage::DATE_ERROR_TEXT
    }
  end
  
  #SELECT GUESTS "SKIP, I'LL DO IT LATER" (TC1571)
  def test_SkipDoLater
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    assert $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
  end
 
=begin
  #CANCEL SELECTED PHOTO (TC1572)
  #PENDING METHOD
  def test_CancelPhoto
  end
=end


  #SELECT PHOTO "SKIP, I'LL DO IT LATER"(TC1573)
  def test_PhotoSkipIllDoItLater
     #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
  end

  #SIGN UP LEAVING THE REGISTRY URL BLANK(TC1574)
  def test_UrlFieldBlank
    
     #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).text == NewSignupPage::URL_ERROR_TEXT
    }
  end


  #SIGN UP USING A URL ALREADY USED(TC1575)
  def test_AlreadyUsedUrl
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys NewSignupPage::URL_PREVIOUSLY_USED
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).text == NewSignupPage::URL_PREVIOUSLY_USED_TEXT
    }
  end


  #CHECK "PREVIOUS" BUTTONS(TC1576)
  def test_CheckPreviousButtons
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    #Clean URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
    }
    
    #Complete the URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys Common.generate_url
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).enabled?
    }
    
    #Click on "Next" button
    
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    #Start clicking the "previous" buttons 
    $browser.find_element(:xpath => NewSignupPage::PREVIOUS_STEP_BUTTON_XPATH).click
    $wait.until{
       $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath => NewSignupPage::PREVIOUS_STEP_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    $browser.find_element(:xpath => NewSignupPage::PREVIOUS_STEP_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
    }
    $browser.find_element(:xpath => NewSignupPage::PREVIOUS_STEP_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    $browser.find_element(:xpath => NewSignupPage::PREVIOUS_STEP_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
    }
  end
  
  
  #SIGN UP WITH AN INVALID EMAIL ADDRESS(@ MISSING) (TC1577)
  def test_InvalidEmail
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    #Clean URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
    }
    
    #Complete the URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys Common.generate_url
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).enabled?
    }
    
    #Click on "Next" button  
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    #Complete Email field with a @ missing email and the password field
    $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).send_keys NewSignupPage::INVALID_EMAIL
    $browser.find_element(:xpath => NewSignupPage::PASSWORD_TEXTBOX_XPATH).send_keys NewSignupPage::PASSWORD_TEXT
    Common.wait_to_load
    
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).text == NewSignupPage::EMAIL_ERROR_TEXT
    }
  end 


  #CREATE AN ACCOUNT WITH AN INCORRECT EMAIL ADDRESS(DOT MISSING) (TC1578)
  def test_DotMissingEmail
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    #Clean URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
    }
    
    #Complete the URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys Common.generate_url
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).enabled?
    }
    
    #Click on "Next" button  
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    #Complete Email field with a dot missing email and the password field
    $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).send_keys NewSignupPage::DOT_MISSING_EMAIL
    $browser.find_element(:xpath => NewSignupPage::PASSWORD_TEXTBOX_XPATH).send_keys NewSignupPage::PASSWORD_TEXT
    Common.wait_to_load
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).text == NewSignupPage::EMAIL_ERROR_TEXT
    }
  end 

  #CREATE AN ACCOUNT WITH AN EMAIL ADDRESS ALREADY USED BY ZOLA ACCOUNT (TC1579)
  def test_EmailAlreadyUsed
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    #Clean URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
    }
    
    #Complete the URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys Common.generate_url
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).enabled?
    }
    
    #Click on "Next" button  
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    #Complete Email field with an already used email address and the password field
    $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).send_keys Common::USER1_EMAIL
    $browser.find_element(:xpath => NewSignupPage::PASSWORD_TEXTBOX_XPATH).send_keys NewSignupPage::PASSWORD_TEXT
    Common.wait_to_load
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).text == NewSignupPage::ALREADY_USEDEMAIL_ERROR_TEXT
    }
  end 

  
  #CREATE AN ACCOUNT WITH AN INVALID PASSWORD (TC1580)
  def test_InvalidPassword
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    #Clean URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
    }
    
    #Complete the URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys Common.generate_url
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).enabled?
    }
    
    #Click on "Next" button  
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).send_keys Common.generate_email(NewSignupPage::GENERATE_EMAIL)
    
    #Here the wrong date is passed as a wrong(short) password
    $browser.find_element(:xpath => NewSignupPage::PASSWORD_TEXTBOX_XPATH).send_keys NewSignupPage::WRONG_DATE
    
    #Click on this page div to make the error message get fired
    $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).click
    Common.wait_to_load
    
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).text == NewSignupPage::PASSWORD_ERROR_TEXT
    }
  end 


  #CREATE AN ACCOUNT LEAVING THE EMAIL BLANK (TC1581)
  def test_EmailBlank
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    #Clean URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
    }
    
    #Complete the URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys Common.generate_url
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).enabled?
    }
    
    #Click on "Next" button  
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    Common.wait_to_load
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    #Complete the email field to clean then so the error message is fired
    $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).send_keys Common.generate_email(NewSignupPage::GENERATE_EMAIL)
    
    $browser.find_element(:xpath => NewSignupPage::PASSWORD_TEXTBOX_XPATH).send_keys NewSignupPage::PASSWORD_TEXT
    
    #Clean the email field  
    $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).clear
    Common.wait_to_load
    
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).text == NewSignupPage::EMAIL_ERROR_TEXT
    }
  end 



  #CREATE AN ACCOUNT LEAVING THE PASSWORD BLANK (TC1582)
  def test_PasswordBlank
    
    #STEP 1
    #$browser.find_element(:id => HomePage::SIGNUP_LINK_ID).click
    #THIS IS TEMPORARY UNTIL NEW SIGNUP IS NOT RELEASED ON STAGE
    $browser.get("https://qa.zola.com/signup/step1")
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT
    }
    
    #Complete all fields 
    $browser.find_element(:xpath => NewSignupPage::YOUR_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::FIRST_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::YOUR_WEDDING_ROL_XPATH).click
    $browser.find_element(:xpath => NewSignupPage::PARTNER_FIRST_LAST_NAME_XPATH).send_keys NewSignupPage::PARTNER_NAME_TEXT
    $browser.find_element(:xpath => NewSignupPage::PARTNER_WEDDING_ROL_XPATH).click
    
    #Click "NEXT" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
     
    #STEP 2
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).displayed?
    }
    
    #Select the checkbox
    $browser.find_element(:xpath => NewSignupPage::HAVENT_DECIDE_WEDDING_DATE_XPATH).click
    
    #Click "Next" button
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    #STEP 3
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).text == NewSignupPage::THIRD_STEP_PAGE_DIV_TEXT
    }
    
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::THIRD_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:id => NewSignupPage::COUPLE_PHOTO_ID).displayed?
    }
    
    #STEP 4 
    #Click on "Skip, I'll do it later" link.
    $browser.find_element(:xpath => NewSignupPage::FOURTH_SKIP_LINK).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).displayed?
    }
    
    #STEP 5
    #Clean URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).clear
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::URL_ERROR_XPATH).displayed?
    }
    
    #Complete the URL field
    $browser.find_element(:xpath => NewSignupPage::URL_TEXTBOX_XPATH).send_keys Common.generate_url
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::OK_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).enabled?
    }
    
    #Click on "Next" button.
    $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).displayed?
    }
    
    $browser.find_element(:xpath => NewSignupPage::EMAIL_TEXTBOX_XPATH).send_keys Common.generate_email(NewSignupPage::GENERATE_EMAIL)
   
    $browser.find_element(:xpath => NewSignupPage::PASSWORD_TEXTBOX_XPATH).send_keys NewSignupPage::PASSWORD_TEXT
    
    #Clean the password field and click on the page div to make the error fired
    $browser.find_element(:xpath => NewSignupPage::PASSWORD_TEXTBOX_XPATH).clear
    $browser.find_element(:xpath => NewSignupPage::PAGE_DIV_XPATH).click
    
    assert $wait.until{
      $browser.find_element(:xpath => NewSignupPage::NEXT_STEP_BUTTON_DISABLE_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).displayed?
      $browser.find_element(:xpath => NewSignupPage::EMAIL_ERROR_XPATH).text == NewSignupPage::PASSWORD_ERROR_TEXT
    }
  end
end
  
