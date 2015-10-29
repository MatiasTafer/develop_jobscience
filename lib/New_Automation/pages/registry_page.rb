class RegistryPage
  
  PRODUCT_TO_USE_XPATH = ".//*[@class='add-to-cart-action button small primary add-to-cart add-to-cart-available']"
  ERROR_MESSAGE_ID = "humaneMessage"
  ERROR_MESSAGE_TEXT_ID = "Cannot add items that belong to multiple registries. Please checkout existing items first."
  ERROR_MESSAGE_TEXT2_ID = "Quantity is over the maximum requested on registry"
  OTHER_REGISTRY_PRODUCT_XPATH = "(.//*[@class='contain-link'])[1]"
  PRODUCT_QUANTITY_BUTTON_PROOF_ID = "quick_addCart_jaipur_salmaorangeivory"
  PRODUCT_QUANTITY_FIELD_PROOF_XPATH = "(.//*[@class='quantity-input'])[1]"
  OTHER_REGISTRY_CART_XPATH = ".//*[@class='cart']"
  CASH_FUND_ON_REGISTRY_XPATH = "(.//*[@class='button small teal'])[2]" #TEST CART - LAST TEST
  EXTERNAL_PRODUCT_ON_REGISTRY_ID = "quick_addCart_ex-ion-audio-max-lp-3-speed-belt-drive-wooden-dj-turntable-with-built-in-speakers1446048214683" #TEST CART - LAST TEST
end