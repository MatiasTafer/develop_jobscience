class NewSignupPage
  
  
    #GENERAL
      #Next Step Button
        NEXT_STEP_BUTTON_XPATH = ".//*[@class='btn btn-primary']"
        NEXT_STEP_BUTTON_DISABLE_XPATH = "(.//*[@disabled='disabled'])[1]"
        STEP_TWO_DISABLE_NEXT_BUTTON_XPATH = ".//*[@class='btn btn-primary'][@disabled='disabled']"
        PAGE_DIV_XPATH = ".//*[@class='col-xs-12 page-header']/h1"
        OK_XPATH = "(.//*[@class='glyphicon glyphicon-ok form-control-feedback'])[1]"
        OK2_XPATH = "(.//*[@class='glyphicon glyphicon-ok form-control-feedback'])[2]"
        PREVIOUS_STEP_BUTTON_XPATH = ".//*[@class='btn btn-secondary']"
   
            
      #Texts And Divs To Proof Existence
        #STEP 1  
        FIRST_STEP_PAGE_DIV_TEXT = "We're getting married!"
        
        #STEP 3 
        THIRD_STEP_PAGE_DIV_TEXT = "We're inviting approximately"
        
        #Error Messages
          #STEP 1 
          NAME_ERROR_XPATH = ".//*[@class='help-block error-block']"
          NAME_ERROR_TEXT = "Please provide a first and last name."
          #STEP 2 
          DATE_ERROR_XPATH = ".//*[@class='help-block error-block']"
          DATE_ERROR_TEXT = "Please enter a valid date."
          #STEP 5
          URL_ERROR_XPATH = ".//*[@class='help-block error-block']"
          URL_ERROR_TEXT = "Please choose a url for your wedding"
          URL_PREVIOUSLY_USED_TEXT = "That url is already taken. Sorry!"
          #STEP LAST
          EMAIL_ERROR_XPATH = ".//*[@class='help-block error-block']"
          EMAIL_ERROR_TEXT = "Please enter a valid email address."
          ALREADY_USEDEMAIL_ERROR_TEXT = "That email address is taken."
          PASSWORD_ERROR_TEXT = "Password must be at least 8 characters long."
  
      #Fields And Buttons
        #STEP 1 
        YOUR_FIRST_LAST_NAME_XPATH = ".//*[@name='registrantName']"
        YOUR_WEDDING_ROL_XPATH = "(.//*[@name='registrantType'])[2]"
        PARTNER_FIRST_LAST_NAME_XPATH = ".//*[@name='partnerName']"
        PARTNER_WEDDING_ROL_XPATH = "(.//*[@name='partnerType'])[1]"
    
        #STEP 2 
        HAVENT_DECIDE_WEDDING_DATE_XPATH = ".//*[@class='datepicker-undecided-label']"
        DATE_TEXTBOX_XPATH = ".//*[@name='eventDate']"
        
        #STEP 3 
        THIRD_SKIP_LINK = ".//*[@href='./step4']"
        
        #STEP 4
        COUPLE_PHOTO_ID = "couple-photo"
        SKIP_DO_IT_LATER_BUTTON_XPATH = ".//*[@href='./step5']"
        FOURTH_SKIP_LINK = ".//*[@href='./step5']"
        PHOTO_UPLOAD_ID = "couple-photo-upload"
        
        #STEP 5 
        URL_TEXTBOX_XPATH = ".//*[@name='registryKeyFn']"
        
        #STEP LAST
        EMAIL_TEXTBOX_XPATH = ".//*[@type='email']"
        PASSWORD_TEXTBOX_XPATH = ".//*[@name='password']"
        
        #FINISH
        GET_STARTED_BUTTON_XPATH = ".//*[@class='btn btn-primary btn-lg']"
    
      #Hard Code Data
        #STEP 1
        FIRST_NAME_TEXT = "Antonio Gutierrez"
        PARTNER_NAME_TEXT = "Gabriela Suarez"
          #WRONG INFO
          NAME_ONLY = "Antonio"
          
        #STEP 2
          #WRONG INFO
          WRONG_DATE = "568923"
        
        #STEP 5
        URL_PREVIOUSLY_USED = "testandtest"
        
        #STEP LAST
        GENERATE_EMAIL = "Generate"
        PASSWORD_TEXT = "Password"
          #WRONG INFO
          INVALID_EMAIL = "emailemail.com"
          DOT_MISSING_EMAIL = "email@emailcom"
end