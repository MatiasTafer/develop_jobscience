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

class Cart < TestBasic

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
      $browser.find_element(:id=> CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Get items name and quantity at the cart
    item1Name = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    item1Quantity = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).text
    item2Name = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    item2Quantity = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).text
    
    #Check out, go to check out page
    $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:xpath => CheckOutModal::BUTTON_CHECKOUT_GUEST).displayed?
    }
    $browser.find_element(:xpath => CheckOutModal::BUTTON_CHECKOUT_GUEST).click
    $wait.until{
      $browser.find_element(:id => CheckOutPage::PLACEORDER_BUTTON_ID).displayed?
    }
    
    #Get the check out items name and quantity and compare with the one got in the cart
    cartFirstItem = $browser.find_element(:id => CheckOutPage::ITEM_ONE_ADDED_NAME_ID).text 
    assert_equal(cartFirstItem, item1Name)
    cartFirstQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_ONE_ADDED_QUANTITY_XPATH).text
    assert_equal(cartFirstQuantity, item1Quantity)
    cartSecondItem = $browser.find_element(:id => CheckOutPage::ITEM_TWO_ADDED_NAME_ID).text
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
    $wait.until {
     $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Preconditions: Must have items on the cart
    Common.add_items_to_cart
    
    #Click on CART
    $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    
    $browser.find_element(:id, HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:id=> CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Get items name and quantity at the cart
    item1Name = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    item1Quantity = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).text
    item2Name = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    item2Quantity = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).text
    
    #Go to check out and compare items name and quantity with the one got at the cart
    $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:id => CheckOutPage::PLACEORDER_BUTTON_ID).displayed?
    }
    cartFirstItem = $browser.find_element(:id => CheckOutPage::ITEM_ONE_ADDED_NAME_ID).text 
    assert_equal(cartFirstItem, item1Name)
    cartFirstQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_ONE_ADDED_QUANTITY_XPATH).text
    assert_equal(cartFirstQuantity, item1Quantity)
    cartSecondItem = $browser.find_element(:id => CheckOutPage::ITEM_TWO_ADDED_NAME_ID).text
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
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
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

  #REMOVE THE LAST ITEM FROM THE CART (TC1363)
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
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
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
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Add items to the cart
    Common.add_items_to_cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
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

  #GUEST CART ITEMS ARE MOVED OVER TO USER CART AFTER LOG IN
  def test_CartContentRemains
    
    #Add items and get the name of them
    Common.add_items_to_cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    itemInitialName1 = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    itemInitialName2 = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART) 
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
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


  #CART DISAPPEARS ON LOG OUT
  def test_CartContentDisappears
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
  
    #Add items  
    Common.add_items_to_cart
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
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
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Remove all items from the cart 
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    Common.remove_items_cart
  end

  #CART ITEMS REAPPEARS AFTER RELOG IN (TC1366)
  def test_CartContentReappears
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Add items
    Common.add_items_to_cart
    
    #Clicks on cart link
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    $wait.until {
     $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
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
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click    
    $wait.until {
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
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
     $wait.until {
       $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
     }
    
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
     $wait.until {
       $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
     }
     
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
  def test_ProductsFromDiffRegistries
    
    #First login to user's url to use the registry
    Common::login(LoginModal::OTHER_USER_TEXT,LoginModal::OTHER_USER_PASSWORD_TEXT)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    userUrl = $browser.current_url
    
    #Log Out
    Common.logout
    
    #LogIn to a new user
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
   
    #Paste the url of the user's registry 
    $browser.get userUrl
    
    $wait.until{
      $browser.find_element(:id => RegistryPage::OTHER_REGISTRY_PRODUCT_ID).displayed?
    }
    $browser.find_element(:id => RegistryPage::OTHER_REGISTRY_PRODUCT_ID).click
    $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
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
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    Common.remove_items_cart
  end
 

  #ADD A QUANTITY HIGHER THAN REQUESTED ON REGISTRY (TC1535)
  def test_QuantityHigherThanRequested

     #First Log in to user's url to use the registry
     Common::login(LoginModal::OTHER_USER_TEXT,LoginModal::OTHER_USER_PASSWORD_TEXT)  
     $wait.until {
       $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
     }
    
     userUrl = $browser.current_url
    
     #LogOut
     Common.logout

     #LogIn to a new user
     Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
     $wait.until {
       $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
     }
     
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

end