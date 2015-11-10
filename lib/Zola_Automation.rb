#Global scope
$browserName = ARGV[0]
$browser
$wait

require './Zola_Web/test_login'
require './Zola_Web/test_change_password'
require './Zola_Web/test_your_information'
require './Zola_Web/test_shipping_info'
require './Zola_Web/test_new_signup'
require './Zola_Web/test_footer_links'
require './Zola_Web/test_forgot_password'
require './Zola_Web/test_registry_settings'
require './Zola_Web/test_sign_up'
require './Zola_Web/test_sign_up'
require './Zola_Web/test_cash_gift_settings'
require './Zola_Web/test_promotion_pages.rb'

#require './Zola_Web/test_cart'
#require './Zola_Web/test_product_modal'
#require './Zola_Web/test_standalone_pdp'
#require './Zola_Web/test_registry_creation'
#require './Zola_Web/test_cash_gift_settings'
#require './Zola_Web/test_registry_settings'
#require './Zola_Web/test_recalculation_group-gifts'
#require './Zola_Web/test_public_registry_reminders'
#require './Zola_Web/test_manage_collections_registry_page'