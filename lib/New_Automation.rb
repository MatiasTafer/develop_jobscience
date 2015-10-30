#Global scope
$browserName = ARGV[0]
$browser
$wait


#require './New_Automation/test_login'
#require './New_Automation/test_registry_creation'
require './New_Automation/test_change_password'
require './New_Automation/test_your_information'
require './New_Automation/test_shipping_info'
#require './New_Automation/test_registry_settings'
require './New_Automation/test_footer_links'
#require './New_Automation/test_cash_gift_settings'
#require './New_Automation/test_new_signup'
#DEPRECATED BECAUSE A NEW SIGNUP FLOW WAS MADE
#require './New_Automation/test_sign_up'
#require './New_Automation/test_recalculation_group-gifts'
#require './New_Automation/test_public_registry_reminders'
require './New_Automation/test_manage_collections_registry_page'

