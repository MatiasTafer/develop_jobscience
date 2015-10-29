class CartModal

  BUTTON_CONTINUE_SHOPPING_XPATH = ".//*[@class='modal-footer modal-footer-dark']//*[@class='btn btn-secondary btn-xs-block']"
       
  CHECK_OUT_BUTTON_ID ="addToCartButton"
  CHECKOUT_MODAL_XPATH = "(.//*[@id='checkout-button'])[1]"
  ERROR_MESSAGE_XPATH = "humaneMessage"
  EMPTY_CART_MESSAGE_ID = "noItemsInCartMessage" 
  EMPTY_CART_TEXT_MESSAGE = "You have nothing in your cart. Get shopping!"
  MESSAGE_INVALID_QUANTITY_XPATH = ".//*[@id='humaneMessage']/div"
  INVALID_QUANTITY_MESSAGE_TEXT = "Please enter a valid quantity."
  
  #ITEMS NAME
  FIRST_ITEM_NAME_XPATH = "(.//*[@class='product-name'])[1]"
  SECOND_ITEM_NAME_XPATH = "(.//*[@class='product-name'])[2]"
  THIRD_ITEM_NAME_XPATH = "(.//*[@class='product-name'])[3]"
  
  
  FIRST_ITEM_QUANTITY_XPATH= "(.//*[@class='short quantity-p'])[1]"
  SECOND_ITEM_QUANTITY_XPATH= "(.//*[@class='short quantity-p'])[2]"

  #ITEMS SIZES SELECTED DISPLAYED
  ITEM_SIZE_SELECTED_XPATH = "(.//*[@class='product-data sku-attribute'])[1]"
  ITEM2_SIZE_SELECTED_XPATH = "(.//*[@class='product-data sku-attribute'])[3]"
  
  #ITEMS COLOR SELECTED DISPLAYED
  ITEM_COLOR_SELECTED_XPATH = "(.//*[@class='product-data sku-attribute'])[2]"

  #Remove Item
  REMOVE_LINK_XPATH = "(.//*[@class='remove-p'])[1]"   

  TRUCK_ICON_XPATH = ".//*[@class='icon icon-truck-white']"
  UNIT_PRICE_XPATH = "(.//*[@class='local-cost'])[1]"

  MESSAGE_NO_ITEMS_ID = "noItemsInCartMessage"
  
  CONTINUE_SHOPPING_LINK_ID = "continueShoppingButton"
  
  ALL_REMOVE_LINKS_XPATH = ".//*[@class='remove-p']" 
  
  #ITEM IMAGES ON CART
  FIRST_ITEM_IMAGE_CART_XPATH = "(.//*[@class='photo-wrapper'])[1]/a"
  SECOND_ITEM_IMAGE_CART_XPATH = "(.//*[@class='photo-wrapper'])[2]/a"
  THIRD_ITEM_IMAGE_CART_XPATH = "(.//*[@class='photo-wrapper'])[3]/a"
  FOURTH_ITEM_IMAGE_CART_XPATH = "(.//*[@class='photo-wrapper'])[4]/a"
  
  #ITEMS BRAND/NAME LINKS
  NAME_LINK_FIRST_XPATH = "(.//*[@class='info-wrapper'])[1]/a"
  NAME_LINK_SECOND_XPATH = "(.//*[@class='info-wrapper'])[2]/a"
  NAME_LINK_THIRD_XPATH = "(.//*[@class='info-wrapper'])[3]/a"
  NAME_LINK_FOURTH_XPATH = "(.//*[@class='info-wrapper'])[4]/a"
end