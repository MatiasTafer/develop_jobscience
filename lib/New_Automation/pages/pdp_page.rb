class Pdp
  
  #ERROR MESSAGES
  
  ERROR_INVALID_QUANTITY_XPATH = ".//*[@class='humane humane-zola-error humane-animate']" 
  ERROR_INVALID_QUANTITY_TEXT = "Please enter a quantity between 1 and 100."
  ERROR_DIF_REGISTRY_MESS_ID = "humaneMessage"
  
  #LINKS 
  BRAND_LINK_XPATH = ".//*[@class='product-details product-details-big hidden-xs']/a"
  SEE_ALL_LINK_XPATH = ".//*[@class='header-link']"
  MORE_ITEM_FIRSTONE_BRAND_XPATH = "(.//*[@class='related-product block-link']//*[@class='brand-name'])[1]"
  MORE_ITEM_FIRSTONE_NAME_XPATH = "(.//*[@class='related-product block-link']//*[@class='product-name'])[1]"
  
  #PRODUCT DETAILS
  QUANTITY_BOX_XPATH = ".//*[@name='quantity']"
  SELECT_SIZE_XPATH = ".//*[@class='col-xs-12 col-sm-6 col-xl-5 col-xl-double-gutter']//*[@ng-change = 'resolveSku()']"
  SIZE_OPTION_TWO_XPATH = ".//*[@value='string:46 in.']"
  COLOR_DESCRIPTION_XPATH = ".//*[@class='col-xs-12 col-sm-6 col-xl-5 col-xl-double-gutter']//*[@class='swatch-label value-label']"
  COLOR_OPTION_XPATH = ".//*[@class='col-xs-12 col-sm-6 col-xl-5 col-xl-double-gutter']//*[@class='swatch']"
  COLOR_TEXT_SELECTED_XPATH = ".//*[@class='col-xs-12 col-sm-6 col-xl-5 col-xl-double-gutter']//*[@class='text-secondary']"
  PRODUCT_NAME_DIV_XPATH = ".//*[@class='product-details product-details-big hidden-xs']//*[@class='product-name']"
  QUANTITY_NEEDED_ID = "giftStatus"
  PRODUCT_COLOR_REGISTRY_MODAL_XPATH = ".//*[@class='color-selector option-selector']/p"
  PRODUCT_SIZE_REGISTRY_MODAL_XPATH = ".//*[@class='size-selector option-selector']/p"
  
  #BUTTONS
  ADD_REGISTRY_XPATH = ".//*[@class='col-xs-12 col-sm-6 col-xl-5 col-xl-double-gutter']//*[@class='btn btn-primary']"
  ADDTOCART_BUTTON_XPATH = ".//*[@class='btn btn-secondary btn-xs-block']"
  MODAL_ADDTOCART_BUTTON_XPATH = ".//*[@class='modal-body']//*[@ng-click='addToCart()']"
  BUY_NOW_BUTTON_ID = "addToCartButton"
  GO_TO_REGISTRY_BUTTON_XPATH = ".//*[@class='btn btn-success']"
  ADD_COLLECTION_DROPDOWN_XPATH = ".//*[@class='col-xs-12 col-sm-6 col-xl-5 col-xl-double-gutter']//*[@class='btn btn-primary dropdown-toggle']"
  COLLECTION_TO_SELECT_XPATH = ".//*[@class='col-xs-12 col-sm-6 col-xl-5 col-xl-double-gutter']//*[@class='dropdown-menu dropdown-menu-right']//*[@role='button']"
  EDIT_ITEM_XPATH = ".//*[@class='edit-product-link']/a"
  
  
  PRODUCT_PRICE_DIV_XPATH = ".//*[@class='product-details product-details-big hidden-xs']//*[@class='price']"
  
end