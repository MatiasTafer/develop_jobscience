require 'date'
#Improve the way the buttons are obtained (id instead of xpath)
class CashGiftSettings
  
  #BUTTONS AND TEXTBOXES
  YOU_COVER_FEE_RADIOBUTTON_ID = "coverCardFees"
  GUEST_COVER_FEE_RADIOBUTTON_ID = "doNotCoverCardFees"
  SUBMIT_FEE_CHANGES_BUTTON_XPATH = ".//*[@id='registry-settings-fee-form-submit']"
  SUBMIT_CHANGES_BUTTON_XPATH = ".//*[@id='registry-settings-banking-form-submit']"
  ROUTING_NUMBER_ID = "banking-routing-number"
  ACCOUNT_TEXTBOX_ID = "banking-account-number"
  BANK_NAME_ID = "banking-name"
  STREET_ADDRESS_ID = "banking-street-address-1"
  APT_ADDRESS_ID = "banking-street-address-2"
  CITY_ADDRESS_ID = "banking-city"
  STATE_ADDRESS_ID = "banking-state"
  ZIP_CODE_ID = "banking-postal-code"
  MONTH_BIRTH_ID = "banking-birth-month"
  DAY_BIRTH_ID = "banking-birth-day"
  YEAR_BIRTH_ID = "banking-birth-year"
  REMOVE_BANK_ACCOUNT_XPATH = ".//*[@class='delete-bank']"
  
  # DATA TO USE
  
  ROUTING_NUMBER = "110000000"
  ACCOUNT_NUMBER = "000123456789"
  NAME = "Master Card"
  STREET_ADDRESS = "18 de julio"
  APT_ADDRESS = "5"
  CITY = "Reno"
  STATE = "Nevada"
  ZIP_CODE = "89501"
  MONTH_OF_BIRTH = "December"
  DAY_OF_BIRTH = "31"
  YEAR_OF_BIRTH = "1999"
  #WRONG INFORMATION TO USE
  SHORT_ROUTING_NUMBER = "11000000"
  LARGE_ROUTING_NUMBER = "1100000000"
  SHORT_ACCOUNT_NUMBER = "12"
  LARGER_ACCOUNT_NUMBER = "1234567891234567890"  
  WRONG_YEAR_BIRTH = Date.today.year
  LARGE_ZIPCODE_NUMBER = "123456"
  
  #ERROR MESSAGES
  
  ERROR_ROUTING_MESSAGE = "registry-settings-banking-form-routing_number"
  ERROR_ACCOUNT_MESSAGE = "registry-settings-banking-form-account_number"
  ERROR_NAME_MESSAGE = "registry-settings-banking-form-name"
  ERROR_STREET_MESSAGE = "registry-settings-banking-form-street_address_1"
  ERROR_CITY_MESSAGE = "registry-settings-banking-form-city"
  ERROR_STATE_MESSAGE = "registry-settings-banking-form-state"
  ERROR_ZIP_CODE_MESSAGE = "registry-settings-banking-form-postal_code"
  ERROR_DATE_OF_BIRTH_MONTH = "registry-settings-banking-form-birth_month"
  ERROR_DATE_OF_BIRTH_DAY = "registry-settings-banking-form-birth_day"
  ERROR_DATE_OF_BIRTH_YEAR = "registry-settings-banking-form-birth_year"
  ERROR_ROUTING_TEXT = "Must be 9 digits."
  ERROR_ROUTING_NON_NUMERIC_TEXT = "Use only digits."
  ERROR_ACCOUNT_TEXT = "Must be between 3 and 17 digits."
  ERROR_NAME_WORDS_TEXT = "Please enter your full name." 
  ERROR_ZIPCODE_WORDS_TEXT = "Invalid ZIP code"
  ERROR_DATE_WORDS_TEXT = "Invalid date selected."
  
  #VALID MESSAGES
  
  VALID_ACCOUNT_ENTER = "humaneMessage"
  VALID_ACCOUNT_ENTER_TEXT = "Bank Information Updated"
  FEE_SETTINGS_CHANGED_TEXT = "Settings Updated"
end