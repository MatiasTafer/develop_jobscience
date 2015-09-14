class ShippingInfoPage
  
  
  BUTTON_SAVE_CHANGES_XPATH = ".//*[@class='button teal big']"
  FIRST_NAME_TEXTBOX_XPATH = ".//*[@name='shipping_address.shipping_first']"
  LAST_NAME_TEXTBOX_XPATH = ".//*[@name='shipping_address.shipping_last']"
  STREET_ADDRESS_TEXTBOX_XPATH = ".//*[@name='shipping_address.shipping_address_1']"
  APTO_TEXTBOX_XPATH = ".//*[@name='shipping_address.shipping_address_2']"
  CITY_TEXTBOX_XPATH = ".//*[@name='shipping_address.shipping_city']"
  STATE_SELECT_ID = "shipping-state"
  ZIPCODE_TEXTBOX_XPATH = ".//*[@name='shipping_address.shipping_zip']"
  PHONE_TEXTBOX_XPATH = ".//*[@name='shipping_phone']"
  
  #ERROR MESSAGES
  
  FIRST_NAME_ERROR_XPATH = ".//*[@for='shippingFirstName']"
  LAST_NAME_ERROR_XPATH = ".//*[@for='shippingLastName']"
  STREET_ERROR_XPATH = ".//*[@for='shippingStreetAddress1']"
  CITY_ERROR_XPATH = ".//*[@for='shippingCity']"
  ZIP_CODE_ERROR_ID = "shippingZipCode-error"
  ZIP_CODE_WRONG_XPATH = ".//*[@class='skip-address-validation']"
  ZIP_CODE_ERROR_MESSAGE = "Invalid ZIP code"
  PHONE_ERROR_XPATH = ".//*[@for='shippingPhone']"
  STATE_ERROR_XPATH = ".//*[@for='shipping-state']"
  OK_MESSAGE_XPATH = ".//*[@class='humane humane-zola-success humane-animate']"
  ERROR_FIELD_REQUIRED = "This field is required."
  
  #HARDCODED DATA
  FIRST_NAME = 'Antonio'
  LAST_NAME = 'Perez'
  STREET = '18 de julio'
  APTO = '5'
  CITY = 'Reno'
  STATE = 'Nevada'
  ZIPCODE = '89501'
  PHONE = '5555555555'
  
  FIRST_NAME_2 = 'Richard'
  LAST_NAME_2 = 'Lamonth'
  STREET_2 = 'Central Street 222'
  APTO_2 = '17'
  CITY_2 = 'Delta'
  STATE_2 = 'Colorado'
  ZIPCODE_2 = '81416'
  PHONE_2 = '9999999999'
  
  FIRS_NAME_3 = "Donald"
  LAST_NAME_3 = "Trump"
  STREET_3 = "Central Street 333"
  APTO_3 = "11"
  CITY_3 = "Bronx"
  STATE_3 = "New York"
  ZIPCODE_3 = "10451"
  PHONE_3 = "5555555555"
  
  #USER
  USER_EMAIL = 'testtesttest@test.com'
  USER_PASSWORD = 'tester1234'
  
end