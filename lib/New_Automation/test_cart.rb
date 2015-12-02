require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/cart_modal.rb'
require_relative './pages/checkout_modal.rb'
require_relative './pages/checkout_page.rb'
require_relative './pages/collection_page.rb'
require_relative './pages/home_page.rb'
require_relative './pages/pdp_page.rb'
require_relative './pages/continue_or_check_modal.rb'
require_relative './pages/registry_page.rb'
require_relative './pages/bedroom_category_page.rb'

class TestCart < TestBasic

  #CHECKOUT PAGE FROM CART WHEN NOT LOGGED IN (TC1360)
  def test_checkoutPageNotLoggedIn
    
    #Add items to cart
    Common.add_items_to_cart
    
    #Click on Cart
    $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    
    #Get items name and quantity at the cart
    item1Name = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    item1Quantity = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).text
    item2Name = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    item2Quantity = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).text
    
    #Check out, go to check out page
    $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => CheckOutModal::BUTTON_CHECKOUT_GUEST).displayed?
    }
    $browser.find_element(:xpath => CheckOutModal::BUTTON_CHECKOUT_GUEST).click
    $wait.until{
      $browser.find_element(:id => CheckOutPage::PLACEORDER_BUTTON_ID).displayed?
    }
    
    #Get the check out items name and quantity and compare with the one got in the cart
    cartFirstItem = $browser.find_element(:xpath => CheckOutPage::ITEM_ONE_ADDED_NAME_XPATH).text 
    assert_equal(cartFirstItem, item1Name)
    cartFirstQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_ONE_ADDED_QUANTITY_XPATH).text
    assert_equal(cartFirstQuantity, item1Quantity)
    cartSecondItem = $browser.find_element(:xpath => CheckOutPage::ITEM_TWO_ADDED_NAME_XPATH).text
    assert_equal(cartSecondItem, item2Name)
    cartSecondQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_TWO_ADDED_QUANTITY_XPATH).text
    assert_equal(cartSecondQuantity, item2Quantity)
    
    #Remove items in the cart
    Common.remove_items_cart
  end


  #CHECKOUT PAGE FROM CART WHEN LOGGED IN (TC1361)
  def test_CheckoutWhenLoggedin
    
    #METHOD TO LOGIN    
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
        
    #Preconditions: Must have items on the cart
    Common.add_items_to_cart
    
    #Click on CART
    $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    
    $browser.find_element(:id, HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    
    #Get items name and quantity at the cart
    item1Name = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    item1Quantity = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).text
    item2Name = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    item2Quantity = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).text
    
    #Go to check out and compare items name and quantity with the one got at the cart
    $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).click
    $wait.until{
      $browser.find_element(:id => CheckOutPage::PLACEORDER_BUTTON_ID).displayed?
    }
    cartFirstItem = $browser.find_element(:xpath => CheckOutPage::ITEM_ONE_ADDED_NAME_XPATH).text 
    assert_equal(cartFirstItem, item1Name)
    cartFirstQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_ONE_ADDED_QUANTITY_XPATH).text
    assert_equal(cartFirstQuantity, item1Quantity)
    cartSecondItem = $browser.find_element(:xpath => CheckOutPage::ITEM_TWO_ADDED_NAME_XPATH).text
    assert_equal(cartSecondItem, item2Name)
    cartSecondQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_TWO_ADDED_QUANTITY_XPATH).text
    assert_equal(cartSecondQuantity, item2Quantity)
    
    #Remove all items
    Common.remove_items_cart
  end


  #REMOVE AN ITEM FROM A LIST OF ITEMS FROM THE CART (TC1362)
  def test_RemoveItemFromList

    #Add items to the cart
    Common.add_items_to_cart

    #Steps Click on "CART"
    $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    
    #Get the number of items in the cart    
    presentElements = $browser.find_elements(:xpath => CartModal::ALL_REMOVE_LINKS_XPATH)
    cartSize= presentElements.size
    
    #Get the name of the item to be removed, and remove it
    firstItem = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text    
    $browser.find_element(:xpath => CartModal::REMOVE_LINK_XPATH).click
    
    #Waits until the number of items in the cart is less than before
    $wait.until {
        $browser.find_elements(:xpath => CartModal::ALL_REMOVE_LINKS_XPATH).size < cartSize
    }
    
    #Get the name of the first item in the cart and check it's not the same than before
    newFirstItem = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    assert_not_equal(firstItem,newFirstItem)
    
    #Remove all items from the cart
    Common.remove_items_cart
    
  end


  #REMOVE THE LAST ITEM FROM THE CART (TC1537)
  def test_RemoveLastItem

    #Go to the Shop page
    $browser.find_element(:xpath => HomePage::HOME_SHOP_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    $browser.find_element(:xpath => Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::MODAL_ADDTOCART_BUTTON_XPATH).displayed?
    }
    
    #Add an item to the cart and go to he cart
    $browser.find_element(:xpath => Pdp::MODAL_ADDTOCART_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ContinueOrCheckModal::CHECKOUT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => ContinueOrCheckModal::CHECKOUT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    
    #Remove the item added and check the "empty cart" message displayed
    $browser.find_element(:xpath => CartModal::REMOVE_LINK_XPATH).click
    $wait.until{
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    assert_equal($browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).text, CartModal::EMPTY_CART_TEXT_MESSAGE)
  end


  #ENTER AN INVALID QUANTITY (TC1363)
  def test_InvalidQuantity
   
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)    
        
    #Add items to the cart
    Common.add_items_to_cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    
    #Set an invalid quantity to the item
    $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).send_keys :backspace, "-3", :tab  
    $wait.until {
      $browser.find_element(:xpath => CartModal::MESSAGE_INVALID_QUANTITY_XPATH).displayed?
    }
    
    #Check the error message displayed
    assert_equal($browser.find_element(:xpath => CartModal::MESSAGE_INVALID_QUANTITY_XPATH).text, CartModal::INVALID_QUANTITY_MESSAGE_TEXT)
    
    #Remove all items from the cart
    Common.remove_items_cart
  end


  #GUEST CART ITEMS ARE MOVED OVER TO USER CART AFTER LOG IN (TC1364)
  def test_CartContentRemains
    
    #Add items and get the name of them
    Common.add_items_to_cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    itemInitialName1 = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    itemInitialName2 = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART) 
    
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    
    #Obtain the new names to compare
    itemFinalName1 = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text    
    itemFinalName2 = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    
    #Compare item names
    assert_equal(itemInitialName1, itemInitialName1)
    assert_equal(itemInitialName2, itemFinalName2)
    
    #Remove all items from the cart
    Common.remove_items_cart
  end


  #CART DISAPPEARS ON LOG OUT (1365)
  def test_CartContentDisappears
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
      
    #Add items  
    Common.add_items_to_cart
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    
    #Step Log Out
    Common.logout
    
    #Verify that the cart is empty
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:id => CartModal::MESSAGE_NO_ITEMS_ID).displayed?
    }
    assert_equal($browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).text, CartModal::EMPTY_CART_TEXT_MESSAGE)
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
        
    #Remove all items from the cart 
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    Common.remove_items_cart
  end


  #CART ITEMS REAPPEARS AFTER RELOG IN (TC1366)
  def test_CartContentReappears
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
        
    #Add items
    Common.add_items_to_cart
    
    #Clicks on cart link
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
     $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    #Get the name of the items
    itemInitialName1 = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    itemInitialName2 = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    
    #LogOut
    Common.logout
    
    #Look that the cart is empty
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    
    #RelogIn
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
        
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click    
    $wait.until {
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    
    #Get name of items to compare
    itemFinalName1 = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text 
    itemFinalName2 = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    
    #Compare item names
    assert_equal(itemInitialName1, itemFinalName1)
    assert_equal(itemInitialName2, itemFinalName2)
  
    #Remove all items from the cart
    Common.remove_items_cart
    
  end


  #ADD A PRODUCT TO THE CART THAT IS ALREADY ADDED (TC1367)
  def test_add_product_already_added
    #Add items
    Common.add_items_to_cart
    $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }

    #Go to cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).displayed?
    }

    #Save the actual quantity
    quantity_first_element = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).attribute("value")
    quantity_second_element = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).attribute("value")

    #Add the same items to the cart
    Common.add_items_to_cart
    $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).displayed?
    }

    #Get the second quantity
    quantity2_first_element = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).attribute("value")
    quantity2_second_element = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).attribute("value")

    #Compare quantities
    assert_not_equal(quantity_first_element, quantity2_first_element)
    assert_not_equal(quantity_second_element, quantity2_second_element)

    #Remove all items from the cart
    Common.remove_items_cart
  end

  
  #RELOG IN AFTER ADDING A PRODUCT ALREADY ADDED TO THE CART (TC1368)
  def test_RelogInAlreadyAddedItem
     
     #Log in
     Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
         
     #Add items
     Common.add_items_to_cart
     $wait.until {
       $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
     }
     
     #Go to cart
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     $wait.until {
       $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).displayed?
     }
     
     #Save the actual quantity  
     quantity_first_element = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).attribute("value")
     quantity_second_element = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).attribute("value")
     
     #LogOut
     Common.logout
     
     #Add the same items to the cart
     Common.add_items_to_cart
     $wait.until {
        $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
     } 
     
     #Re Log in
     Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
          
     #Go to cart
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click 
     $wait.until {
       $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).displayed?
     }
     
     #Get the quantity of items in cart 
     quantity2_first_element = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).attribute("value")
     quantity2_second_element = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).attribute("value")

     #Compare both quantities
     assert_not_equal(quantity_first_element, quantity2_first_element)
     assert_not_equal(quantity_second_element, quantity2_second_element)
     
     #Remove all items from the cart
     Common.remove_items_cart
  end


  #ADD PRODUCTS FROM TWO DIFFERENT REGISTRIES (TC1369)
  #This test needs TWO ACCOUNTS with at least ONE ITEM NOT fullfiled at the first position on those registries. The cart must be empty.
  def test_ProductsFromDiffRegistries
    
    #First login to user's url to use the registry
    Common::login(LoginModal::OTHER_USER_TEXT,LoginModal::OTHER_USER_PASSWORD_TEXT)
        
    userUrl = $browser.current_url
    
    #Log Out
    Common.logout
    
    #LogIn to a new user
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
       
    #Paste the url of the user's registry 
    $browser.get userUrl
    
    $wait.until{
      $browser.find_element(:xpath => RegistryPage::OTHER_REGISTRY_PRODUCT_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistryPage::OTHER_REGISTRY_PRODUCT_XPATH).click
    $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).click
    
    $wait.until{
      $browser.find_element(:id => CartModal::CONTINUE_SHOPPING_LINK_ID).displayed?
    }
    $browser.find_element(:id => CartModal::CONTINUE_SHOPPING_LINK_ID).click
    
    #Go to actual logged user registry
    $browser.find_element(:xpath => HomePage::LOGO_ZOLA_XPATH).click     
    $wait.until{
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    
    #Add an item from the actual user and an error message is displayed
    $wait.until{
      $browser.find_element(:xpath => RegistryPage::PRODUCT_TO_USE_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistryPage::PRODUCT_TO_USE_XPATH).click
    $wait.until{
      $browser.find_element(:id => RegistryPage::ERROR_MESSAGE_ID).displayed?
    }
    assert_equal($browser.find_element(:id, RegistryPage::ERROR_MESSAGE_ID).text, RegistryPage::ERROR_MESSAGE_TEXT_ID)
    
    #Rollback
    #Remove every item from the cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::CHECKOUT_MODAL_XPATH).displayed?
    }
    Common.remove_items_cart
  end 


  #ADD A QUANTITY HIGHER THAN REQUESTED ON REGISTRY (TC1535)
  def test_QuantityHigherThanRequested

     #First Log in to user's url to use the registry
     Common::login(LoginModal::OTHER_USER_TEXT,LoginModal::OTHER_USER_PASSWORD_TEXT)  
         
     userUrl = $browser.current_url
    
     #LogOut
     Common.logout

     #LogIn to a new user
     Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
          
     #Paste the url of the user's registry
     $browser.get userUrl
     
     $wait.until {
       $browser.find_element(:id => RegistryPage::PRODUCT_QUANTITY_BUTTON_PROOF_ID).displayed?
     }
    
     #Add an item with a quantity bigger than requested. An error message is displayed 
     $browser.find_element(:xpath => RegistryPage::PRODUCT_QUANTITY_FIELD_PROOF_XPATH).send_keys :backspace, "3"
     $browser.find_element(:id => RegistryPage::PRODUCT_QUANTITY_BUTTON_PROOF_ID).click         
     $wait.until{
        $browser.find_element(:id => CartModal::ERROR_MESSAGE_XPATH).displayed?
     }
     assert_equal($browser.find_element(:id => CartModal::ERROR_MESSAGE_XPATH).text, RegistryPage::ERROR_MESSAGE_TEXT2_ID)
  end

  
  #LINKS TO PRODUCT (TC1622)
  #This Test needs a user with at least one external product and cash fund on it registry
  def test_linksToPrducts
    
    #Login into a user with the propouse of get an external item and a fund from it registry
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    
    #Add first item with one properie in this case size
    $browser.find_element(:xpath => HomePage::HOME_SHOP_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).displayed?
    }
    $browser.action.move_to($browser.find_element(:xpath => Shop::HOME_LINK_XPATH)).perform
    $wait.until{
      $browser.find_element(:xpath => Shop::BEDROOM_FURNITURE_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => Shop::BEDROOM_FURNITURE_LINK_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => BedroomCategoryPage::ITEM_WITHSIZE_XPATH).displayed?
    }
    $browser.find_element(:xpath => BedroomCategoryPage::ITEM_WITHSIZE_XPATH).click
    $wait.until{
          $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
    }
    Common.selectByText($browser.find_element(:xpath => Pdp::SELECT_SIZE2_XPATH), "twin")
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ContinueOrCheckModal::CONTINUE_SHOPPING_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => ContinueOrCheckModal::CONTINUE_SHOPPING_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => BedroomCategoryPage::ZOLA_HOME_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => BedroomCategoryPage::ZOLA_HOME_LINK_XPATH).click
    
    #Add the second item with two properties, size and color 
    Common.goToItemWithcolorModal()
    haveSize = Common.findSpecificSizeElement(Pdp::SELECT_SIZE_XPATH)
    if haveSize == true
      Common.selectByText($browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH), "full")
    end
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    
    $wait.until{
      $browser.find_element(:xpath => ContinueOrCheckModal::CONTINUE_SHOPPING_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => ContinueOrCheckModal::CONTINUE_SHOPPING_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => BedroomCategoryPage::ZOLA_HOME_LINK_XPATH).displayed?
    }
    $browser.find_element(:xpath => BedroomCategoryPage::ZOLA_HOME_LINK_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => RegistryPage::PRODUCT_TO_USE_XPATH).displayed?
    }
    
    #Add a cash fund item
    $browser.find_element(:xpath => RegistryPage::CASH_FUND_ON_REGISTRY_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::CONTRIBUTE_TEXTBOX_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::CONTRIBUTE_TEXTBOX_XPATH).send_keys 100
    $browser.find_element(:id => Pdp::BUY_NOW_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:id => CartModal::CONTINUE_SHOPPING_LINK_ID).displayed?
    }
    $browser.find_element(:id => CartModal::CONTINUE_SHOPPING_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => RegistryPage::PRODUCT_TO_USE_XPATH).displayed?
    }
    
    #Add an external product
    $browser.find_element(:id => RegistryPage::EXTERNAL_PRODUCT_ON_REGISTRY_ID).click
    $wait.until{
      $browser.find_element(:id => CartModal::CONTINUE_SHOPPING_LINK_ID).displayed?
    }
    
    #Get size of the first item added in this case it size
    sizeOnCart = $browser.find_element(:xpath => CartModal::ITEM_SIZE_SELECTED_XPATH).text
    sizeOnCart = sizeOnCart.slice(6..sizeOnCart.length)
    sizeOnCart = sizeOnCart.downcase
    
    #Go to first item on cart pdp by clicking on it image and compare the size on cart with the size on pdp
    $browser.find_element(:xpath => CartModal::FIRST_ITEM_IMAGE_CART_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::SIZE_SELECTOR_ON_PDP_PAGE).displayed?
    }
    sizeOnPdpPage = $browser.find_element(:xpath => Pdp::SIZE_SELECTOR_ON_PDP_PAGE).attribute("value")
    sizeOnPdpPage = sizeOnPdpPage.slice(7..sizeOnPdpPage.length)
    assert_equal(sizeOnCart, sizeOnPdpPage)
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::FIRST_ITEM_IMAGE_CART_XPATH).displayed?
    }
    
    #Once again on the cart go to first item pdp by clicking on it brand/name and compare the size selected on the cart with the one displayed on the pdp
    $browser.find_element(:xpath => CartModal::NAME_LINK_FIRST_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::SIZE_SELECTOR_ON_PDP_PAGE).displayed?
    }
    sizeOnPdpPage = $browser.find_element(:xpath => Pdp::SIZE_SELECTOR_ON_PDP_PAGE).attribute("value")
    sizeOnPdpPage = sizeOnPdpPage.slice(7..sizeOnPdpPage.length)
    assert_equal(sizeOnCart, sizeOnPdpPage)
    
    
    #START SECOND ITEM (with two properties) TEST
    
    
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::SECOND_ITEM_IMAGE_CART_XPATH).displayed?
    }
    
    #Get item size and color displayed on cart
    secondItemSize = $browser.find_element(:xpath => CartModal::ITEM2_SIZE_SELECTED_XPATH).text
    displayError = secondItemSize.slice(0..5)
    if displayError == "Size: "
      secondItemSize = secondItemSize.slice(6..secondItemSize.length)
      secondItemSize = secondItemSize.downcase
      secondItemColor = $browser.find_element(:xpath => CartModal::ITEM_COLOR_SELECTED_XPATH).text
      secondItemColor = secondItemColor.slice(7..secondItemColor.length)
      secondItemColor = secondItemColor.downcase
    else
      secondItemSize = $browser.find_element(:xpath => CartModal::ITEM_COLOR_SELECTED_XPATH).text
      secondItemSize = secondItemSize.slice(6..secondItemSize.length)
      secondItemSize = secondItemSize.downcase
      secondItemColor = $browser.find_element(:xpath => CartModal::ITEM2_SIZE_SELECTED_XPATH).text
      secondItemColor = secondItemColor.slice(7..secondItemColor.length)
      secondItemColor = secondItemColor.downcase
    end
    
    
    #Go to item pdp by clicking on the item image
    $browser.find_element(:xpath => CartModal::SECOND_ITEM_IMAGE_CART_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::SIZE_SELECTOR_ON_PDP_PAGE).displayed?
    }
    sizeOnPdpPage = $browser.find_element(:xpath => Pdp::SIZE_SELECTOR_ON_PDP_PAGE).attribute("value")
    sizeOnPdpPage = sizeOnPdpPage.slice(7..sizeOnPdpPage.length)
    assert_equal(secondItemSize, sizeOnPdpPage)
    
    colorOnPdpPage = $browser.find_element(:xpath => Pdp::COLOR_TEXT_SELECTED_XPATH).text
    colorOnPdpPage = colorOnPdpPage.downcase
    assert_equal(secondItemColor, colorOnPdpPage)
    
   
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::SECOND_ITEM_IMAGE_CART_XPATH).displayed?
    }
    
    #Click on brand/name
    $browser.find_element(:xpath => CartModal::NAME_LINK_SECOND_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::SIZE_SELECTOR_ON_PDP_PAGE).displayed?
    }
    
    sizeOnPdpPage = $browser.find_element(:xpath => Pdp::SIZE_SELECTOR_ON_PDP_PAGE).attribute("value")
    sizeOnPdpPage = sizeOnPdpPage.slice(7..sizeOnPdpPage.length)
    assert_equal(secondItemSize, sizeOnPdpPage)
    
    colorOnPdpPage = $browser.find_element(:xpath => Pdp::COLOR_TEXT_SELECTED_XPATH).text
    colorOnPdpPage = colorOnPdpPage.downcase
    assert_equal(secondItemColor, colorOnPdpPage)
    
    
    #START THIRD ITEM (CASH FUND) TEST
    
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::SECOND_ITEM_IMAGE_CART_XPATH).displayed?
    }
    
    
    #Get cash fund name and click on the item image to go to the pdp 
    fundName = $browser.find_element(:xpath => CartModal::THIRD_ITEM_NAME_XPATH).text
    $browser.find_element(:xpath => CartModal::THIRD_ITEM_IMAGE_CART_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::EDIT_ITEM_XPATH).displayed?
    }
    assert_equal(fundName, $browser.find_element(:id => Pdp::ITEM_NAME_ID).text)
    
    #Return to cart 
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::SECOND_ITEM_IMAGE_CART_XPATH).displayed?
    }
    
    #Go to item pdp by clicking on the brand/name
    $browser.find_element(:xpath => CartModal::THIRD_ITEM_NAME_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::EDIT_ITEM_XPATH).displayed?
    }
    assert_equal(fundName, $browser.find_element(:id => Pdp::ITEM_NAME_ID).text)
    
    
    #START FOURTH ITEM (EXTERNAL) TEST
    
    #Go to item pdp by clicking on the item image
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::SECOND_ITEM_IMAGE_CART_XPATH).displayed?
    }
    externalName = $browser.find_element(:xpath => CartModal::NAME_LINK_FOURTH_XPATH).text
    $browser.find_element(:xpath => CartModal::FOURTH_ITEM_IMAGE_CART_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::EDIT_ITEM_XPATH).displayed?
    }
    assert_equal(externalName, $browser.find_element(:id => Pdp::ITEM_NAME_ID).text)
    
    #Return to the cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::FOURTH_ITEM_IMAGE_CART_XPATH).displayed?
    }
    $browser.find_element(:xpath => CartModal::NAME_LINK_FOURTH_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::EDIT_ITEM_XPATH).displayed?
    }
    assert_equal(externalName, $browser.find_element(:id => Pdp::ITEM_NAME_ID).text)
    
    #Delete every item on cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::SECOND_ITEM_IMAGE_CART_XPATH).displayed?
    } 
    Common.remove_items_cart()
  end

end