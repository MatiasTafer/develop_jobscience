class PromotionPage
  
  EMAIL_FIELD_ID = "promo-email"
  PASSWORD_FIELD_ID = "promo-password"
  CREATE_YOUR_FREE_REGISTRY_BUTTON_XPATH = ".//*[@class='promotion-sign-up-form']//*[@class='button big primary']"
  GO_TO_ZOLA_BUTTON_XPATH = ".//*[@class='already-registered']//*[@class='button big primary']"
  
  EMPTY_EMAIL_ERROR_ID = "undefined-email"
  EMPTY_PASSWORD_ERROR_ID = "undefined-password"
  INVALID_EMAIL_ERROR_ID = "undefined-email"
  TAKEN_EMAIL_ERROR_ID = "undefined-email"
  LENGTH_PASSWORD_ERROR_ID = "undefined-password"
  
  
  EMPTY_EMAIL_ERROR_TEXT = "This field is required."
  EMPTY_PASSWORD_ERROR_TEXT = "This field is required."
  TAKEN_EMAIL_ERROR_TEXT = "That email address is taken."
  INVALID_EMAIL_ERROR_TEXT = "Please enter a valid email address."
  LENGTH_PASSWORD_ERROR_TEXT = "Password must be at least 8 characters long."
  
  EMAIL_VALID = "rrrrrrr@gmail.com"
  PASSWORD = "1password"
  PASSWORD_SHORT = "123"
  
end