class CartModal

  BUTTON_CONTINUE_SHOPPING_XPATH = ".//*[@class='modal-footer modal-footer-dark']//*[@class='btn btn-secondary btn-xs-block']"
       
  CHECK_OUT_BUTTON_ID ="checkout-button"
  ERROR_MESSAGE_XPATH = "humaneMessage"
  EMPTY_CART_MESSAGE_ID = "noItemsInCartMessage" 
  EMPTY_CART_TEXT_MESSAGE = "You have nothing in your cart. Get shopping!"
  MESSAGE_INVALID_QUANTITY_XPATH = ".//*[@class='error']"
  INVALID_QUANTITY_MESSAGE_TEXT = "Please enter a valid quantity."
  
  #ITEMS IN THE CART PROPERTIES
  FIRST_ITEM_NAME_XPATH = "(.//*[@class='product-name'])[1]"
  SECOND_ITEM_NAME_XPATH = "(.//*[@class='product-name'])[2]"
  FIRST_ITEM_QUANTITY_XPATH= "(.//*[@class='short quantity-p'])[1]"
  SECOND_ITEM_QUANTITY_XPATH= "(.//*[@class='short quantity-p'])[2]"

  #Remove Item
  REMOVE_LINK_XPATH = "(.//*[@class='remove-p'])[1]"   

  TRUCK_ICON_XPATH = ".//*[@class='icon icon-truck-white']"
  UNIT_PRICE_XPATH = "(.//*[@class='local-cost'])[1]"

  BUTTON_CHECKOUTNOW_XPATH = "(.//*[@id='checkout-button'])[1]" 
  MESSAGE_NO_ITEMS_ID = "noItemsInCartMessage"
  
  
  ALL_REMOVE_LINKS_XPATH = ".//*[@class='remove-p']" 
end