#Global scope
$browserName = ARGV[0]
$browser
$wait


require './New_Automation/test_login'
require './New_Automation/test_registry_creation'
require './New_Automation/test_change_password'

#not ready yet
#require './New_Automation/test_your_information'
#require './New_Automation/test_sign_up'