require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/pdp_page.rb'
require_relative './pages/bedroom_category_page.rb'
require_relative './pages/proceed_to_checkout_modal.rb'
require_relative './pages/cart_modal.rb'
require_relative './pages/collection_page.rb'
require_relative './pages/edit_item_modal.rb'
require_relative './pages/remove_item_confirmation_modal.rb'
require_relative './pages/new_signup_page.rb'
require_relative './pages/brand_page.rb'


class TestStandalonePdp < TestBasic
  
#-----------------------------  ACCESSORY METHODS  --------------------------------------------

  #Method to go to an item modal
  #Tests (TC1492), (TC1493), (TC1494), (TC1495 STEPS 1,2,3), (TC1496), (TC1500), (TC1503), (TC1506) and (TC1507)
  def goToItemModal
    #Go to Collection/easy-entertaining
    $wait.until{
      $browser.find_element(:xpath => HomePage::TWITTER_XPATH).displayed?
    }   
    $browser.find_element(:xpath => HomePage::HOME_SHOP_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Shop::SHOP_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Collection::COLLECTION_GIFT_XPATH).displayed?
    }
    #Go to item modal
    $browser.find_element(:xpath => Collection::COLLECTION_GIFT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
    }
  end
  
  #Find an item that has size options 
  def findSpecificSizeElement(xpath)
    way = xpath.slice(0..36)
    $browser.action.move_to($browser.find_element(:xpath => way)).perform
    $wait.until{
      $browser.find_element(:xpath => way + "//*[@class='quickview-inputs-wrapper']").displayed?
    }
    array = $browser.find_elements(:xpath => xpath)
    found = array.size > 0
    return found
  end
  
  #Find an item that has color options
  def findSpecificColorElement(xpath)
    array = $browser.find_elements(:xpath => xpath)
    found = array.size > 0
    return found
  end
  

  #Method to go to an item, which you can choose its color, modal
  #Tests (TC1499), (TC1502) and (TC1505)
  def goToItemWithcolorModal 
    #Go to Collection/easy-entertaining
    $wait.until{
      $browser.find_element(:xpath => HomePage::TWITTER_XPATH).displayed?
    }
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
      $browser.find_element(:xpath => BedroomCategoryPage::ITEM_WITH_COLOR_XPATH).displayed?
    }
    aux = 1;
    @@find = false   
    while(@@find == false)
      @@find = true;
      way = "(.//*[@class='col-xs-6 col-sm-4'])[#{aux}]//*[@class='hidden-xs text-center']"
      @@find = findSpecificColorElement(way)   
      if @@find == true
        way = way.slice(0..36)
      end
      aux = aux + 1
    end
    
    $browser.find_element(:xpath => way + "/div/a").click
    $wait.until{
      $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
    }
  end
  
  
  #Method to go to an item, which you can choose its size, modal
  #Tests (TC1498), (TC1501) and (TC1504)
  def goToItemWithSizeModal
    #Go to Collection/easy-entertaining
    $wait.until{
      $browser.find_element(:xpath => HomePage::TWITTER_XPATH).displayed?
    }
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
      $browser.find_element(:xpath => BedroomCategoryPage::ITEM_WITH_SIZE_XPATH).displayed?
    }
    aux = 1;
    @@find = false   
    while(@@find == false)
      @@find = true;
      way = "(.//*[@class='col-xs-6 col-sm-4'])[#{aux}]//*[@sku-selector='']"
      @@find = findSpecificSizeElement(way)   
      
      if @@find == true
        way = way.slice(0..36)
      end
      aux = aux + 1
    end
     $browser.find_element(:xpath => way + "/div/a").click
     $wait.until{
          $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
     }  
  end
  
  
  #Method to get the current URL, open a new tab and paste the taken URL.
  #Tests (TC1492), (TC1493), (TC1494), (TC1495 STEPS 1,2,3), (TC1496), (TC1498), (TC1499), (TC1500), (TC1501), (TC1502), (TC1503), (TC1504), (TC1505), (TC1506) and (TC1507)
  def newTabURL
    #Get the current URL
    url = $browser.current_url
    #Open new tab with the URL passed
    $browser.switch_to.window($browser.window_handles.last)
    $browser.get url
  end
  
  
  #Method to iterate through all items in registry and compare their names with the one passed as parameter, and once it finds the item, it goes to the item modal
  #Tests (TC1501), (TC1502), (TC1503) and (TC1506)
  def searchAndGoToModal(nameSelected)  
    #This section of code iterates through all items name on registry to compare them with the one taken on the PDP until found the indicated
    flag = false
    counter = 1
    while flag == false do
      element = "(.//*[@class='item-body with-bottom']/h5)[#{counter}]"
      nameOnRegistry = $browser.find_element(:xpath => element).text
      if nameOnRegistry == nameSelected
        flag = true
      end
      counter += 1
    end
    assert_equal(nameOnRegistry, nameSelected)
    #Once found the item goes to the product modal so it can compare 
    element["/h5"] = "/a"
    $browser.find_element(:xpath => element).click
    $wait.until{
      $browser.find_element(:id => Pdp::BUY_NOW_BUTTON_ID).displayed?
    } 
  end
  
  
  #Method to remove recently added item, when you are at the item modal
  #Tests (TC1501), (TC1502), (TC1503), (TC1504), (TC1505) and (1506)
  def deleteRecentItem  
    #Remove the item from the registry
    $browser.find_element(:xpath => Pdp::EDIT_ITEM_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => EditItemModal::DELETE_ITEM_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => EditItemModal::DELETE_ITEM_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:id => RemoveItemConfirmModal::CONFIRM_ITEM_REMOVE_ID).displayed?
    }
    $browser.find_element(:id => RemoveItemConfirmModal::CONFIRM_ITEM_REMOVE_ID).click 
  end
 
  
#---------------------------------------          ---------------------------------------------------- 
 

#--------------------------------------  TESTS  -------------------------------------------------------


  #STANDALONE PRODUCT DETAILS PAGE WHEN LOGGED IN (TC1492)
  def test_GoodStandalonePage
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    #Go to an item modal
    goToItemModal()
    #Get the product name and price to compare with the same information from the pdp
    prodModalName = $browser.find_element(:xpath =>Pdp::PRODUCT_NAME_DIV_XPATH).text
    prodModalPrice = $browser.find_element(:xpath => Pdp::PRODUCT_PRICE_DIV_XPATH).text
    #Open a new tab with the taken url.
    newTabURL()
    #Check until "Add To Cart" and "Add To Registry" buttons are displayed; so they exist 
    $wait.until{
      $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
      $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).displayed?
    }
    #Check that the item name and price are the same as those taken previously
    assert_equal($browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text, prodModalName)
    assert_equal($browser.find_element(:xpath => Pdp::PRODUCT_PRICE_DIV_XPATH).text, prodModalPrice)
  end


  #STANDALONE PRODUCT DETAILS PAGE WHEN NOT LOGGED IN (TC1493)
  def test_GoodStandaloneNotLogged
    #Go to an item modal
    goToItemModal()
    #Get the product name and price to compare with the same information from the pdp
    prodModalName = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    prodModalPrice = $browser.find_element(:xpath => Pdp::PRODUCT_PRICE_DIV_XPATH).text
    #Open new tab with taken url.
    newTabURL()
    #Check until "Add To Cart" and "Add To Registry" buttons are displayed; so they exist 
    $wait.until{
      $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
      $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).displayed?
    }
    #Check that the item name and price are the same as those taken previously
    assert_equal($browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text, prodModalName)
    assert_equal($browser.find_element(:xpath => Pdp::PRODUCT_PRICE_DIV_XPATH).text, prodModalPrice)
  end


  #STANDALONE PRODUCT DETAILS PAGE WHEN LOGGED IN WITHOUT A REGISTRY (TC1494)
    #A USER with NO REGISTRY is needed for this test
  def test_GoodStandaloneNoRegistry
    #Login with a user with No registry 
    Common.login(Common::USER_NO_REGISTRY_EMAIL, Common::USER_NO_REGISTRY_PASS)
    #Go to an item modal
    goToItemModal()
    #Get the product name and price to compare with the same information from the pdp
    prodModalName = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    prodModalPrice = $browser.find_element(:xpath => Pdp::PRODUCT_PRICE_DIV_XPATH).text
    #Open new tab with taken url.
    newTabURL()
    #Check until "Add To Cart" button is displayed; so it exist 
    $wait.until{
      $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
    }
    #Check that the item name and price are the same as those taken previously
    assert_equal($browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text, prodModalName)
    assert_equal($browser.find_element(:xpath => Pdp::PRODUCT_PRICE_DIV_XPATH).text, prodModalPrice)
  end


  #LINKS (TC1495) - STEP 1
  def test_LinksTestStep1     
    #Go to an item modal
    goToItemModal()
    #Open new tab with taken url.
    newTabURL()
    brand = $browser.find_element(:xpath => Pdp::BRAND_LINK_XPATH).text
    #Obtain the brand section of the text to compare it.
    brandName = brand.slice(0..brand.length-3)
    downBrandName = brandName.downcase
    #Click on Brand link
    $browser.find_element(:xpath => Pdp::BRAND_LINK_XPATH).click
    #Compares with the name of the brand at the brand page
    $wait.until{
      $browser.find_element(:xpath => BrandPage::BRAND_NAME_DIV_XPATH).displayed?
    }
    brand = $browser.find_element(:xpath => BrandPage::BRAND_NAME_DIV_XPATH).text
    brand = brand.downcase
    assert_equal(downBrandName, brand)
  end


  #LINKS (TC1495) - STEP 2
  def test_LinksTestStep2    
    #Go to an item modal
    goToItemModal()
    #Open new tab with taken url.
    newTabURL()
    brand = $browser.find_element(:xpath => Pdp::BRAND_LINK_XPATH).text
    #Obtain the brand section of the text to compare it.
    brandName = brand.slice(0..brand.length-3)
    downBrandName = brandName.downcase
    #Click on "See all" link
    $browser.find_element(:xpath => Pdp::SEE_ALL_LINK_XPATH).click
    #Compares with the name of the brand at the brand page
    $wait.until{
      $browser.find_element(:xpath => BrandPage::BRAND_NAME_DIV_XPATH).displayed?
    }
    brand = $browser.find_element(:xpath => BrandPage::BRAND_NAME_DIV_XPATH).text
    brand = brand.downcase
    assert_equal(downBrandName, brand) 
  end


  #LINKS (TC1495) - STEP 3 
  def test_LinksTestStep3
    #Go to an item modal
    goToItemModal()
    #Open new tab with taken url.
    newTabURL()
    $wait.until{
      $browser.find_element(:xpath => Pdp::MORE_ITEM_FIRSTONE_BRAND_XPATH).displayed?
    }
    #Get the selected item name and brand ("More From Fort Standard" section)
    newItemBrand = $browser.find_element(:xpath => Pdp::MORE_ITEM_FIRSTONE_BRAND_XPATH).text
    newItemName = $browser.find_element(:xpath => Pdp::MORE_ITEM_FIRSTONE_NAME_XPATH).text
    $browser.find_element(:xpath => Pdp::MORE_ITEM_FIRSTONE_BRAND_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).displayed?
    }
    #Get the current pdp item brand and name
    pdpNewItemName = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    #Piece together Brand name to compare
    brand = $browser.find_element(:xpath => Pdp::BRAND_LINK_XPATH).text
    pdpNewItemBrand = brand.slice(0..brand.length-3)
    upNewBrandName = pdpNewItemBrand.upcase
    #Compare names and brands
    assert_equal(newItemBrand, upNewBrandName)
    assert_equal(newItemName, pdpNewItemName)
  end


  #CHANGE THE QUANTITY OF THE PRODUCT TO A NEGATIVE NUMBER, ZERO OR NON NUMERIC VALUE(TC1496)
  def test_invalidQuantity    
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    #Go to an item modal
    goToItemModal()
    #Open new tab with taken url.
    newTabURL()
    #Clean and set a negative quantity and try to add to the registry; an error message is displayed
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).clear
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).send_keys "-1"
    $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Pdp::ERROR_INVALID_QUANTITY_XPATH).displayed?
    }
    #Now click on "Add to Cart" button with the same negative value and see the same error message
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Pdp::ERROR_INVALID_QUANTITY_XPATH).displayed?
    }
    #Now clean again and set the quantity to zero and try to add to the registry; an error message is displayed too
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).clear
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).send_keys "0"
    $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Pdp::ERROR_INVALID_QUANTITY_XPATH).displayed?
    }
    #Click on "Add to Cart" with the same zero value and see the same error message
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Pdp::ERROR_INVALID_QUANTITY_XPATH).displayed?
    }
    #Clean again and set the quantity to a non-numeric value and try to add to the registry; an error message is displayed too
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).clear
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).send_keys "ho///ho"
    $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Pdp::ERROR_INVALID_QUANTITY_XPATH).displayed?
    }
    #Click on "Add to Cart" button with the same non-numeric value and see the same error message
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    assert $wait.until{
      $browser.find_element(:xpath => Pdp::ERROR_INVALID_QUANTITY_XPATH).displayed? 
    }
  end


  #ADD A PRODUCT THAT HAS AN ATTRIBUTE (E.G. SIZE) TO THE CART (TC1498)
  def test_AddProductWithSize
    #Go to an item modal
    goToItemWithSizeModal()
    #Open new tab with taken url.
    newTabURL()
    #Select item size on PDP page.
    $wait.until{
      $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH).displayed?
    }
    #Select size from the dropdown list
    path = $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH)
    #Select a value from the size dropdown list
    Common.selectByIndex(path, 1)
    #Save the size value to be selected on the pdp
    sizeSelected = Common.get_selected_option_text(path)
    $wait.until{
      $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).displayed?
    }  
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ProceedToCheckOutModal::PROCEED_TO_CHECKOUT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => ProceedToCheckOutModal::PROCEED_TO_CHECKOUT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::BUTTON_CHECKOUTNOW_XPATH).displayed?
    }
    #Once in cart get the item size here displayed and compare it with the one taken when select the size
    sizeInCart = $browser.find_element(:xpath => CartModal::ITEM_SIZE_SELECTED_XPATH).text
    defSize = sizeInCart.slice(6..sizeInCart.length-1)
    sizeToComp = defSize.downcase 
    assert_equal(sizeSelected, sizeToComp) 
  end


  #ADD A PRODUCT THAT HAS COLOR SWATCHES TO YOUR CART(TC1499)
  def test_AddproductWithColor
    #Go to an item modal
    goToItemWithcolorModal()
    #Open PDP on a new tab
    newTabURL()
    $wait.until{
      $browser.find_element(:xpath => Pdp::COLOR_DESCRIPTION_XPATH).displayed?
    }
    #Select a color and get the color name
    $browser.find_element(:xpath => Pdp::COLOR_OPTION_XPATH).click
    textSelected = $browser.find_element(:xpath => Pdp::COLOR_TEXT_SELECTED_XPATH).text
    if $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH).displayed? != false
      #Select a size from the dropdown list
      path = $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH)
      #Select a value from the size dropdown list
      Common.selectByIndex(path, 1)
    end    
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    #Advance from "proceed to checkout/continue shopping" modal to the cart
    $wait.until{
      $browser.find_element(:xpath => ProceedToCheckOutModal::PROCEED_TO_CHECKOUT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => ProceedToCheckOutModal::PROCEED_TO_CHECKOUT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => CartModal::BUTTON_CHECKOUTNOW_XPATH).displayed?
    }
    #This section of code is used to select the color section of the item displayed on the cart; because not always appears at the same position 
    color = $browser.find_element(:xpath => CartModal::ITEM_COLOR_SELECTED_XPATH).text
    if color.index("Color:") != nil
       colorInCart = $browser.find_element(:xpath => CartModal::ITEM_COLOR_SELECTED_XPATH).text
    else
       colorInCart = $browser.find_element(:xpath => CartModal::ITEM_SIZE_SELECTED_XPATH).text    
    end  
    #Compare color values
    defColor = colorInCart.slice(7..colorInCart.length-1)
    assert_equal(textSelected, defColor)   
  end


  #ADD A PRODUCT TO YOUR CART AFTER CHANGING ITS QUANTITY (TC1500)
  def test_QuantityInAddItem
    #Go to an item modal
    goToItemModal()
    #Copy the modal URL and open it on a new tab
    newTabURL()
    $wait.until{
      $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).displayed?
    }
    #Clear and set quantity
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).clear
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).send_keys "3"
    $browser.find_element(:xpath => Pdp::ADDTOCART_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => ProceedToCheckOutModal::PROCEED_TO_CHECKOUT_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => ProceedToCheckOutModal::PROCEED_TO_CHECKOUT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:id => CartModal::CHECK_OUT_BUTTON_ID).displayed?
    }
    #Get the item quantity on cart
    quantityOnCart = $browser.find_element(:xpath => CartModal::FIRST_ITEM_QUANTITY_XPATH).attribute("value")
    #Compare quantity 
    assert_equal("3", quantityOnCart)
  end


  #ADD A PRODUCT THAT HAS AN ATTRIBUTE (E.G.SIZE) TO YOUR REGISTRY PAGE (TC1501)
    #A USER who has REGISTRY is needed for this test
  def test_AddItemWithSizeToReg
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    #Go to item modal
    goToItemWithSizeModal()
    #Copy the item modal URL and open it on a new page
    newTabURL()
    #Select item size on PDP page.
    $wait.until{
      $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH).displayed?
    }
    path = $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH)
    #Select a value from the size dropdown list
    Common.selectByIndex(path, 1)
    #Save the size and name of the selected item
    sizeSelected = Common.get_selected_option_text(path) 
    nameSelected = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    #Add the item to the registry
    $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).click
    #Search for the new item on the registry
    searchAndGoToModal(nameSelected)
    #Compare sizes
    size = $browser.find_element(:xpath => Pdp::PRODUCT_SIZE_REGISTRY_MODAL_XPATH).text
    size = size.downcase
    assert_equal(size, sizeSelected)
  
    #Delete item added 
    deleteRecentItem()   
  end


  #ADD A PRODUCT THAT HAS COLOR SWATCHES TO YOUR REGISTRY HOMEPAGE (TC1502)
    #A USER who has REGISTRY is needed for this test
  def test_AddItemWithColorToReg
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    #Go to an item modal
    goToItemWithcolorModal()
    #Open item modal, copy the URL and paste it on a new tab
    newTabURL()
    $wait.until{
      $browser.find_element(:xpath => Pdp::COLOR_DESCRIPTION_XPATH).displayed?
    }
    #Select a color; get the color name and the item name
    $browser.find_element(:xpath => Pdp::COLOR_OPTION_XPATH).click
    colorSelected = $browser.find_element(:xpath => Pdp::COLOR_TEXT_SELECTED_XPATH).text
    nameSelected = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    array = $browser.find_elements(:xpath => Pdp::SELECT_SIZE_XPATH)
    if array.size>0
      #Select a size from the dropdown list
      path = $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH)
      #Select a value from the size dropdown list
      Common.selectByIndex(path, 1)
    end   
    #Add to the registry
    $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).click
    #Search for the new item on the registry
    searchAndGoToModal(nameSelected)
    #Compare colors
    color = $browser.find_element(:xpath => Pdp::PRODUCT_COLOR_REGISTRY_MODAL_XPATH).text
    assert_equal(color, colorSelected)

    #Delete item added
    deleteRecentItem()
  end


  #ADD A PRODUCT TO YOUR REGISTRY HOMEPAGE AFTER CHANGING ITS QUANTITY (TC1503)
    #A USER who has REGISTRY is needed for this test
  def test_AddItemQtyToReg
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    #Go to an item modal
    goToItemModal()
    #Copy the item modal URL, paste it on a new tab
    newTabURL()
    $wait.until{
      $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).displayed?
    }
    #Clear and set quantity
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).clear
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).send_keys "3"
    nameSelected = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).click
    #Search for the new item on the registry
    searchAndGoToModal(nameSelected) 
    #Compare quantity
    quantity = $browser.find_element(:id => Pdp::QUANTITY_NEEDED_ID).text
    quantity = quantity.slice(quantity.length-1..quantity.length)
    assert_equal(quantity, "3")
    
    #Delete the item
    deleteRecentItem()
  end


  #ADD A PRODUCT THAT HAS A ATTRIBUTE (E.G. SIZE) TO A COLLECTION (TC1504)
    #A USER who has REGISTRY with at least one COLLECTION is needed for this test
  def test_ItemWithSizeToColl
    #Login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)  
    #Go to an item modal
    goToItemWithSizeModal()
    #Copy the item modal URL and paste it on a new tab
    newTabURL()
    $wait.until{
      $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).displayed?
    }    
    path = $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH)
    #Select a value from the size dropdown list
    Common.selectByIndex(path, 1)
    #Save the size and name of the selected item
    sizeSelected = Common.get_selected_option_text(path) 
    nameSelected = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    #Add the new item to a collection and go to see it on the registry
    $browser.find_element(:xpath => Pdp::ADD_COLLECTION_DROPDOWN_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::COLLECTION_TO_SELECT_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::COLLECTION_TO_SELECT_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).click
    #Search for the new item on the registry
    searchAndGoToModal(nameSelected)
    #Go to the item edit modal to look if the item is associated with a collection
    $browser.find_element(:xpath => Pdp::EDIT_ITEM_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => EditItemModal::DELETE_ITEM_BUTTON_XPATH).displayed?
    }
    pass = $browser.find_element(:xpath => "(.//*[@data-placeholder='Choose a Collection'])[3]")
    #Look the collection name if it's correct and if the item is really associated with a collection 
    collection = Common.get_selected_option_text(pass)
    #If the item it's associated with a collection can't be a coincidence in this two lines above.
    assert_not_equal(collection, "Feature On Main Page")
    
    $browser.find_element(:xpath => EditItemModal::CANCEL_EDIT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:id => Pdp::BUY_NOW_BUTTON_ID).displayed?
    } 
    #Compare sizes
    size = $browser.find_element(:xpath => Pdp::PRODUCT_SIZE_REGISTRY_MODAL_XPATH).text
    size = size.downcase
    assert_equal(size, sizeSelected)

    #Delete item added 
    deleteRecentItem()   
  end


  #ADD A PRODUCT THAT HAS COLOR SWATCHES TO A COLLECTION (TC1505)
    #A USER who has REGISTRY with at least one COLLECTION is needed for this test
  def test_ItemWithColorToColl
    #login    
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    #Go to an item modal
    goToItemWithcolorModal()
    #Copy the item modal URL and paste it on a new tab
    newTabURL()
    $wait.until{
      $browser.find_element(:xpath => Pdp::COLOR_DESCRIPTION_XPATH).displayed?
    }
    #Select a color; get the color name and the item name
    $browser.find_element(:xpath => Pdp::COLOR_OPTION_XPATH).click
    colorSelected = $browser.find_element(:xpath => Pdp::COLOR_TEXT_SELECTED_XPATH).text
    nameSelected = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    array = $browser.find_elements(:xpath => Pdp::SELECT_SIZE_XPATH)
    if array.size>0
      #Select a size from the dropdown list
      path = $browser.find_element(:xpath => Pdp::SELECT_SIZE_XPATH)
      #Select a value from the size dropdown list
      Common.selectByIndex(path, 1) 
    end
    #Add item to a collection and go to see it on the registry
    $browser.find_element(:xpath => Pdp::ADD_COLLECTION_DROPDOWN_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::COLLECTION_TO_SELECT_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::COLLECTION_TO_SELECT_XPATH).click
     $wait.until{
      $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).click
    #Search for the new item on the registry
    searchAndGoToModal(nameSelected)  
     #Go to the item edit modal to look if the item is associated with a collection
    $browser.find_element(:xpath => Pdp::EDIT_ITEM_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => EditItemModal::DELETE_ITEM_BUTTON_XPATH).displayed?
    }
    pass = $browser.find_element(:xpath => "(.//*[@data-placeholder='Choose a Collection'])[3]")
    #Look the collection name if it's correct and if the item is really associated with a collection 
    collection = Common.get_selected_option_text(pass)
    #If the item it's associated with a collection can't be a coincidence in this two lines above.
    assert_not_equal(collection, "Feature On Main Page")
    
    $browser.find_element(:xpath => EditItemModal::CANCEL_EDIT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:id => Pdp::BUY_NOW_BUTTON_ID).displayed?
    }  
    #Compare colors
    color = $browser.find_element(:xpath => Pdp::PRODUCT_COLOR_REGISTRY_MODAL_XPATH).text
    assert_equal(color, colorSelected)
    
    #Delete the item
    deleteRecentItem()
  end

  #ADD A PRODUCT TO A COLLECTION AFTER CHANGING ITS QUANTITY (TC1506)
    #A USER who has REGISTRY with at least one COLLECTION is needed for this test
  def test_AddDiffQtyToColl
    #login
    Common.login(Common::USER_NAME_CART, Common::USER_PASSWORD_CART)
    #Go to an item modal
    goToItemModal()
    #Copy the item modal URL and paste it on a new tab
    newTabURL()
    $wait.until{
      $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).displayed?
    }
    #Clear and set quantity
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).clear
    $browser.find_element(:xpath => Pdp::QUANTITY_BOX_XPATH).send_keys "3"
    nameSelected = $browser.find_element(:xpath => Pdp::PRODUCT_NAME_DIV_XPATH).text
    #Select a collection to add the new item
    $browser.find_element(:xpath => Pdp::ADD_COLLECTION_DROPDOWN_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => Pdp::COLLECTION_TO_SELECT_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::COLLECTION_TO_SELECT_XPATH).click
    #Go to registry
    $wait.until{
      $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::GO_TO_REGISTRY_BUTTON_XPATH).click
    #Search for the new item on the registry
    searchAndGoToModal(nameSelected)
     #Go to the item edit modal to look if the item is associated with a collection
    $browser.find_element(:xpath => Pdp::EDIT_ITEM_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => EditItemModal::DELETE_ITEM_BUTTON_XPATH).displayed?
    }
    pass = $browser.find_element(:xpath => "(.//*[@data-placeholder='Choose a Collection'])[3]")
    #Look the collection name if it's correct and if the item is really associated with a collection 
    collection = Common.get_selected_option_text(pass)
    #If the item it's associated with a collection can't be a coincidence in this two lines above.
    assert_not_equal(collection, "Feature On Main Page")
    
    $browser.find_element(:xpath => EditItemModal::CANCEL_EDIT_BUTTON_XPATH).click
    $wait.until{
      $browser.find_element(:id => Pdp::BUY_NOW_BUTTON_ID).displayed?
    } 
    #Compare quantity
    quantity = $browser.find_element(:id => Pdp::QUANTITY_NEEDED_ID).text
    quantity = quantity.slice(quantity.length-1..quantity.length)
    assert_equal(quantity, "3")
    
    #Delete the item
    deleteRecentItem()
  end

  
=begin
  #Waiting for new signup definitely enable

  #TRY TO ADD A PRODUCT TO YOUR REGISTRY WHILE NOT LOGGED IN (TC1507)
  def test_NotLoggedAddToReg
    #Go to an item modal
    goToItemModal()
    #Copy the item modal URL and paste it on a new tab
    newTabURL()
    #Press "Add To Registry" button and redirected to new signup first step 
    $wait.until{
      $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).displayed?
    }
    $browser.find_element(:xpath => Pdp::ADD_REGISTRY_XPATH).click
    $wait.until{
      $browser.find_element(:xpath => NewSignupPage::FIRST_STEP_PAGE_DIV_TEXT).displayed
    }
  end
=end
end