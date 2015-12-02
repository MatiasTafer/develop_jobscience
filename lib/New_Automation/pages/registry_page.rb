class RegistryPage
  
  PRODUCT_TO_USE_XPATH = ".//*[@class='add-to-cart-action button small primary add-to-cart add-to-cart-available']"
  ERROR_MESSAGE_ID = "humaneMessage"
  ERROR_MESSAGE_TEXT_ID = "Cannot add items that belong to multiple registries. Please checkout existing items first."
  ERROR_MESSAGE_TEXT2_ID = "Quantity is over the maximum requested on registry"
  OTHER_REGISTRY_PRODUCT_XPATH = "(.//*[@class='contain-link'])[1]"
  PRODUCT_QUANTITY_BUTTON_PROOF_ID = "quick_addCart_jaipur_salmaorangeivory"
  PRODUCT_QUANTITY_FIELD_PROOF_XPATH = "(.//*[@class='quantity-input'])[1]"
  OTHER_REGISTRY_CART_XPATH = ".//*[@class='cart']"

  FIRST_PRODUCT_XPATH = "((.//*[@id='collection-results']//*[@class='single-item single-product editable'])[1])//*[@class='item-top']//*[@class='contain-link']"
  FIRST_PRODUCT_BUY_BUTTON_XPATH = "(.//*[@value='Buy Now'])[1]"
  LAST_PRODUCT_XPATH = "((.//*[@id='collection-results']//*[@class='single-item single-product editable'])[last()])//*[@class='item-top']//*[@class='contain-link']"
  QUANTITY_OF_ITEMS_IN_REGISTRY_XPATH = "((.//*[@id='collection-results']//*[@class='single-item single-product editable']))//*[@class='item-top']//*[@class='contain-link']"
  NAME_OF_FIRST_ITEM_IN_REGISTRY_XPATH = "(.//*[@class='item-body with-bottom']//*[@class='single-product-name'])[1]"
  CHANGE_SAVED_MESSAGE_ID ="humaneMessage"
  YOUR_REGISTRY_LINK_ID = "registrySettingsLink"
  GIFT_ATTRIBUTE_ID = "data-collection-item-id"
  NEW_COLLECTION_BUTTON_XPATH = ".//*[@class='new-collection-wrapper top']//*[@class='button medium secondary tooltip-plain tooltipstered']"
  ALL_COLLECTIONS_IN_REGISTRY_XPATH = ".//*[@class='collection-header collection']"
  SETTINGS_LINK_ID = "registrySettingsLink"
   
  
 
 
 
  #Action button of collections
  EDIT_COLLECTION_BUTTON_XPATH = ".//*[@class='collection-header collection']//*[@class='collection-actions']//*[@class='edit-link']"
  DELETE_COLLECTION_BUTTON_XPATH =".//*[@class='collection-header collection']//*[@class='collection-actions']//*[@class='remove-collection']"
  MOVE_UP_COLLECTION_BUTTON_XPATH = ".//*[@class='icon icon-arrow-up']"
  MOVE_DOWN_COLLECTION_BUTTON_XPATH = ".//*[@class='icon icon-arrow-down']"
  
  
  
  
  
  GROUP_OF_COLLECTIONS_XPATH = ".//*[@class='collection-header collection']"
  FIRST_COLLECTION_IN_GROUP_XPATH = "(.//*[@class='collection-header collection'])[1]"
  SECOND_COLLECTION_IN_GROUP_XPATH = "(.//*[@class='collection-header collection'])[2]"
  LAST_COLLECTION_IN_GROUP_XPATH = "(.//*[@class='collection-header collection'])[last()]"
  
  
  
  
  #ALL_COLLECTIONS_IN_FOLDER_LAYOUT_XPATH = ".//*[@class='collection-tile']//*[@class='item-actions']//*[@class='move-item']"
  #FIRST_ITEM_COLLECTION_IN_FOLDER_LAYOUT_XPATH = "(.//*[@class='collection-tile']//*[@class='item-actions']//*[@class='move-item'])[1]"
  #LAST_ITEM_COLLECTION_IN_FOLDER_LAYOUT_XPATH = "(.//*[@class='collection-tile']//*[@class='item-actions']//*[@class='move-item'])[last()]"
 
  
  

  CASH_FUND_ON_REGISTRY_XPATH = "(.//*[@class='button small teal'])[2]" #TEST CART - LAST TEST
  EXTERNAL_PRODUCT_ON_REGISTRY_ID = "quick_addCart_ex-ion-audio-max-lp-3-speed-belt-drive-wooden-dj-turntable-with-built-in-speakers1446048214683" #TEST CART - LAST TEST

end