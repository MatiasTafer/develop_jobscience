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
=begin
  #CHECKOUT PAGE FROM CART WHEN NOT LOGGED IN (TC1360)
  def test_checkoutPageNotLoggedIn
    
    #Add items to cart
    Common.add_items_to_cart
    
    #Click on Cart
    assert $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id=> CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Get items name and quantity at the cart
    item1Name = $browser.find_element(:id => CartModal::ITEM_NAME_ID).text
    item1Quantity = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).text
    item2Name = $browser.find_element(:id => CartModal::ITEM_TWO_NAME_ID).text
    item2Quantity = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).text
    
    #Check out, go to check out page
    $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CheckOutModal::BUTTON_CHECKOUT_GUEST).displayed?
    }
    $browser.find_element(:xpath => CheckOutModal::BUTTON_CHECKOUT_GUEST).click
    assert $wait.until{
      $browser.find_element(:id => CheckOutPage::PLACEORDER_BUTTON_ID).displayed?
    }
    
    #Get the check out items name and quantity and compare with the one getted in the cart
    cartFirtsItem = $browser.find_element(:id => CheckOutPage::ITEM_ONE_ADDED_NAME_ID).text 
    cartFirtsItem = item1Name
    cartFirstQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_ONE_ADDED_QUANTITY_XPATH).text
    cartFirstQuantity = item1Quantity
    cartSeconditem = $browser.find_element(:id => CheckOutPage::ITEM_TWO_ADDED_NAME_ID).text
    cartSeconditem = item2Name
    cartSecondQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_TWO_ADDED_QUANTITY_XPATH).text
    cartSecondQuantity = item2Quantity
    
    #Remove items in the cart
    Common.remove_items_cart
  end

  #CHECKOUT PAGE FROM CART WHEN LOGGED IN (TC1361)
  def test_CheckoutWhenLoggedin
    
    #METHOD TO LOGIN
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until{
      $browser.find_element(:xpath => CheckOutPage::CART_TEXT_AUX_XPATH).displayed?
    }
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    assert $wait.until {
     $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Preconditions: Must have items on the cart
    Common.add_items_to_cart
    
    #Click on CART
    assert $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    
    $browser.find_element(:id, HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id=> CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Get items name and quantity at the cart
    item1Name = $browser.find_element(:id => CartModal::ITEM_NAME_ID).text
    item1Quantity = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).text
    item2Name = $browser.find_element(:id => CartModal::ITEM_TWO_NAME_ID).text
    item2Quantity = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).text
    
    #Go to check out and compare items name and quantity with the one getted at the cart
    $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).click
    assert $wait.until{
      $browser.find_element(:id => CheckOutPage::PLACEORDER_BUTTON_ID).displayed?
    }
    cartFirtsItem = $browser.find_element(:id => CheckOutPage::ITEM_ONE_ADDED_NAME_ID).text 
    cartFirtsItem = item1Name
    cartFirstQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_ONE_ADDED_QUANTITY_XPATH).text
    cartFirstQuantity = item1Quantity
    cartSeconditem = $browser.find_element(:id => CheckOutPage::ITEM_TWO_ADDED_NAME_ID).text
    cartSeconditem = item2Name
    cartSecondQuantity = $browser.find_element(:xpath => CheckOutPage::ITEM_TWO_ADDED_QUANTITY_XPATH).text
    cartSecondQuantity = item2Quantity
    
    #Remove all items
    Common.remove_items_cart
  end

  #REMOVE AN ITEM FROM A LIST OF ITEMS FROM THE CART (TC1362)
  def test_RemoveItemFromListThem

    #Add items to the cart
    Common.add_items_to_cart

    #Steps Click on "CART"
    assert $wait.until {
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
      $browser.find_element(:id => CartModal::ITEM_TWO_NAME_ID).displayed?
    }
    
    #Get the name of the item to be removed, and remove it
    firstItem = $browser.find_element(:id => CartModal::ITEM_NAME_ID).text
    $browser.find_element(:xpath => CartModal::REMOVE_LINK_XPATH).click
    
    #Look if item isn't at the list
    $browser.page_source.include? firstItem
    
    #Remove all items from the cart
    Common.remove_items_cart
    
  end

  #REMOVE THE LAST ITEM FROM THE CART (TC1363)
  def test_RemoveLastItem

    #Go to the Shop page
    $browser.find_element(:xpath => HomePage::HOME_SHOP_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Collection::BUILD_YOUR_BAR_TEXT_XPATH).displayed?
    }
    $browser.find_element(:xpath => Collection::COLLECTION_GIFT_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
    }
    
    #Add an item to the cart and go to he cart
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => ContinueOrCheckModal::CHECKOUT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => ContinueOrCheckModal::CHECKOUT_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Remove the item added and check the "empty cart" message displayed
    $browser.find_element(:xpath => CartModal::REMOVE_LINK_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).text == CartModal::EMPTY_CART_TEXT_MESSAGE
  end

  #ENTER AN INVALID QUANTITY (TC1363)
  def test_InvalidQuantity
   
    #Login
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    
    assert $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Add items to the cart
    Common.add_items_to_cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Set an invalid quantity to the item
    $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).send_keys :backspace, "-3"
  
    $browser.find_element(:xpath => CartModal::UNIT_PRICE_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath => CartModal::MESSAGE_INVALID_QUANTITY_XPATH).displayed?
    }
    
    #Check the error message displayed
    $browser.find_element(:xpath => CartModal::MESSAGE_INVALID_QUANTITY_XPATH).text == CartModal::INVALID_QUANTITY_MESSAGE_TEXT
    
  end

  #GUEST CART ITEMS ARE MOVED OVER TO USER CART AFTER LOG IN
  def test_CartContentManteins
    
    #Add items and get the name of them
    Common.add_items_to_cart
    nombreItem1 = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    nombreItem2 = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART) 
    assert $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Depurate to obtain the necessary part of the name to compare
    nombreItem11 = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text 
    aux = nombreItem11.split(",").last
    nombreFinal = aux[1..-1]
    
    nombreItem22 = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    aux2 = nombreItem22.split(",").last
    nombreFinal2 = aux2[1..-1]
    
    #Compeare item names
    assert_equal(nombreItem1, nombreFinal)
    assert_equal(nombreItem2, nombreFinal2)
    
    #Remove all items from the cart
    Common.remove_items_cart
  end

  #CART DISAPPEARS ON LOG OUT
  def test_CartContentDisappears
    
    #Accessory Login through the cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    assert $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
  
    #Add items  
    Common.add_items_to_cart
    assert $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Step Log Out
    Common.logout
    
    #Verify that the cart is empty
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id => CartModal::MESSAGE_NO_ITEMS_ID).displayed?
    } 
    
  end

  #CART ITEMS REAPPEARS AFTER RELOG IN (TC1366)
  def test_CartContentReappears
    
    #Login through the cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    assert $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    #Add items
    Common.add_items_to_cart
    
    #Clicks on cart link
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
     $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    #get the name of the items
    itemInitialName1 = $browser.find_element(:xpath => CartModal::FIRST_ITEM_NAME_XPATH).text
    itemInitialName2 = $browser.find_element(:xpath => CartModal::SECOND_ITEM_NAME_XPATH).text
    
    #LogOut
    Common.logout
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until{
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    
    #Look that the cart is empty
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    
    #RelogIn
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    assert $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    
    assert $wait.until {
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

  #ADD A PRUDUCT TO THE CART THAT IS ALREADY ADDED (TC1367)
  def test_add_product_already_added
      
    #Add items
    Common.add_items_to_cart
     assert $wait.until {
       $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
     }
     
     #Go to cart
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     assert $wait.until {
       $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).displayed?
     }
     
     #Save the actual quantity  
     quantity_first_element = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).attribute("value")
     quantity_second_element = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).attribute("value")
     
     #Add the same items to the cart
     Common.add_items_to_cart
     assert $wait.until {
        $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
     } 
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click 
     assert $wait.until {
       $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).displayed?
     }
     
     #Get the second quantity
     quantity2_first_element = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).attribute("value")
     quantity2_second_element = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).attribute("value")

     #Compare quantities
     assert_not_equal(quantity_first_element, quantity2_first_element)
     assert_not_equal(quantity_second_element, quantity2_second_element)
        
  end

  #RELOG IN AFTER ADDING A PRODUCT ALREDAY ADDED TO THE CART (TC1368)
  def test_LoggedOutAlreadyItem
      
     #Login through the cart
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     assert $wait.until {
       $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
     }
    
     #Log in
     Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
     assert $wait.until {
       $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
     }
    
     #Add items
     Common.add_items_to_cart
     assert $wait.until {
       $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
     }
     
     #Go to cart
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     assert $wait.until {
       $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).displayed?
     }
     
     #Save the actual quantity  
     quantity_first_element = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).attribute("value")
     quantity_second_element = $browser.find_element(:xpath => CartModal::SECOND_ITEM_QUANTITY_XPATH).attribute("value")
     
     #LogOut
     Common.logout
     
     #Add the same items to the cart
     Common.add_items_to_cart
     assert $wait.until {
        $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
     } 
     
     #Re Log in
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     assert $wait.until {
       $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
     }
     
     Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
     assert $wait.until {
       $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
     }
     
     #Go to cart
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click 
     assert $wait.until {
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
    
    #Login through the cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
      $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    
    #First login to user's url to use the regsitry
    $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
    $wait.until{
      $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
    }
    $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::OTHER_USER_TEXT
    $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::OTHER_USER_PASSWORD_TEXT
    $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit  
  
    assert $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
    
    userUrl = $browser.current_url
    
    #Log Out
    Common.logout
   
    #Login through the cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
    assert $wait.until {
       $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
    }
    
    #LogIn to a new user
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    assert $wait.until {
      $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
    }
   
    #Paste the url of the user's registry 
    $browser.switch_to.window($browser.window_handles.last)
    $browser.get userUrl
    
    assert $wait.until{
      $browser.find_element(:id => RegistryPage::OTHER_REGISTRY_PRODUCT_ID).displayed?
    }
    $browser.find_element(:id => RegistryPage::OTHER_REGISTRY_PRODUCT_ID).click
    assert $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    
    #Go to actual logged user registry
    $browser.find_element(:xpath => HomePage::LOGO_ZOLA_XPATH).click     
    assert $wait.until{
      $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
    }
    $browser.find_element(:xpath => RegistryPage::PRODUCT_TO_USE_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => RegistryPage::PRODUCT_TO_USE_XPATH).displayed?
    }
    
    #Add an item from the actual user and an error message is displayed
    assert $wait.until{
      $browser.find_element(:xpath => RegistryPage::PRODUCT_TO_USE_XPATH).displayed?
    }
    $browser.find_element(:xpath => RegistryPage::PRODUCT_TO_USE_XPATH).click
    assert $wait.until{
      $browser.find_element(:id => RegistryPage::ERROR_MESSAGE_ID).displayed?
    }
    
    #Rollback
    #Remove every item from the cart
    $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     assert $wait.until {
        $browser.find_element(:id => HomePage::CART_BUTTON_ID).displayed?
     }
    Common.remove_items_cart
  end
=end
  #ADD A QUANTITY HIGHER THAN REQUESTED ON REGISTRY (TC1535)
  def test_QuantityHigherThanRequested
    
     #Login through the cart
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     assert $wait.until {
       $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
     }
    
     #First Log in to user's url to use the regsitry
     $browser.find_element(:id, HomePage::LOGIN_LINK_ID).click
     $wait.until{
        $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).displayed?
     }
     $browser.find_element(:xpath => LoginModal::EMAIL_FIELD_XPATH).send_keys LoginModal::OTHER_USER_TEXT
     $browser.find_element(:xpath => LoginModal::PASSWORD_FIELD_XPATH).send_keys LoginModal::OTHER_USER_PASSWORD_TEXT
     $browser.find_element(:xpath => LoginModal::LOGIN_BUTTON_XPATH).submit  
  
     assert $wait.until {
       $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
     }
    
     userUrl = $browser.current_url
    
     #LogOut
     Common.logout
    
     #Option of login through the cart
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     assert $wait.until {
        $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
     }
    
     #LogIn to a new user
     Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
     assert $wait.until {
       $browser.find_element(:xpath => HomePage::MY_ACCOUNT_LINK_XPATH).displayed?
     }

     #Remove all items in the cart    
     $browser.find_element(:id => HomePage::CART_BUTTON_ID).click
     assert $wait.until {
        $browser.find_element(:id => CartModal::EMPTY_CART_MESSAGE_ID).displayed?
     }
     Common.remove_items_cart
     
     #Paste the url of the user's registry
     $browser.switch_to.window($browser.window_handles.last)
     $browser.get userUrl
     
     assert $wait.until {
       $browser.find_element(:id => RegistryPage::PRODUCT_QUANTITY_PROOF_ID).displayed?
     }
    
     #Add an item
     $browser.find_element(:id => RegistryPage::PRODUCT_QUANTITY_BUTTON_PROOF_ID).click
    
     assert $wait.until{
       $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
     }
     
     #Set a quantity bigger than requested
     $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).send_keys :backspace, "3"
     $browser.find_element(:xpath => CartModal::UNIT_PRICE_XPATH).click
     assert $wait.until{
        $browser.find_element(:id => CartModal::ERROR_MESSAGE_XPATH).displayed?
     }
     
     #Remove all items from the cart 
     Common.remove_items_cart
  end
end