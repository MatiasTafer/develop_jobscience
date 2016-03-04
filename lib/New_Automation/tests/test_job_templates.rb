require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require './New_Automation/pages/job_templates/job_templates_page.rb'
require './New_Automation/pages/job_templates/job_template_detail_page.rb'
require './New_Automation/pages/job_templates/new_job_template_page.rb'
require './New_Automation/pages/job_templates/job_template_mapping_page.rb'
require './New_Automation/pages/home_page.rb'
require './New_Automation/pages/requisitions/requisitions_detail_page.rb'

class TestJobTemplates < TestBasic
 
#TC969 - New Job Template  
def test_newJobTemplate
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::JOB_TEMPLATES_TAB_LINK_URL
  test = [{"displayed" => JobTemplates::NEW_BUTTON_XPATH},
          {"click" => JobTemplates::NEW_BUTTON_XPATH},
          {"displayed" => NewJobTemplate::JOB_TITLE_TEXT_XPATH},
          {"set_text" => NewJobTemplate::JOB_TITLE_TEXT_XPATH, "text" => NewJobTemplate::JOB_TEMPLATE_NAME_TEXT},
          {"set_text" => NewJobTemplate::JOB_TEMPLATE_MAPPING_TEXT_XPATH, "text" => NewJobTemplate::JOB_TEMPLATE_MAPPING_TEXT},
          {"click" => NewJobTemplate::SAVE_BUTTON_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, JobTemplateDetail::EDIT_TEMPLATE_BUTTON_XPATH).displayed?
  }  
end  


#TC970 - New Job Template, Validation
def test_newJobTemplateValidation
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::JOB_TEMPLATES_TAB_LINK_URL
  test = [{"displayed" => JobTemplates::NEW_BUTTON_XPATH},
          {"click" => JobTemplates::NEW_BUTTON_XPATH},
          {"displayed" => NewJobTemplate::JOB_TITLE_TEXT_XPATH},
          {"click" => NewJobTemplate::SAVE_BUTTON_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, NewJobTemplate::ERROR_REQUIRED_FIELDS).displayed?
  }  
  assert_equal($browser.find_element(:xpath, NewJobTemplate::ERROR_REQUIRED_FIELDS).text, NewJobTemplate::ERROR_REQUIRED_FIELDS_TEXT)  
end  

#TC971 - New Job Template Mapping 
def test_newJobTemplateMapping
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::JOB_TEMPLATE_MAPPING_TAB_LINK
  templateMappingName = SecureRandom.hex(5)
  test = [{"displayed" => JobTemplateMapping::NEW_BUTTON_XPATH},
          {"click" => JobTemplateMapping::NEW_BUTTON_XPATH},
          {"displayed" => JobTemplateMapping::JOB_TEMPLATE_MAPPING_NAME_XPATH},
          {"set_text" => JobTemplateMapping::JOB_TEMPLATE_MAPPING_NAME_XPATH, "text" => templateMappingName},
          {"click" => JobTemplateMapping::SAVE_BUTON_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, JobTemplateMapping::NEW_MAPPING_ITEM_BUTTON_XPATH).displayed?
  }
end 

#TC972 - New Job Template Mapping, Validation  
def test_newJobTemplateMappingValidation
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::JOB_TEMPLATE_MAPPING_TAB_LINK
  test = [{"displayed" => JobTemplateMapping::NEW_BUTTON_XPATH},
          {"click" => JobTemplateMapping::NEW_BUTTON_XPATH},
          {"displayed" => JobTemplateMapping::JOB_TEMPLATE_MAPPING_NAME_XPATH},
          {"click" => JobTemplateMapping::SAVE_BUTON_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, JobTemplateMapping::ERROR_REQUIRED_FIELD_XPATH).displayed?
  }
  assert_equal($browser.find_element(:xpath, JobTemplateMapping::ERROR_REQUIRED_FIELD_XPATH).text, JobTemplateMapping::ERROR_REQUIRED_FIELD_TEXT)
 
end


#TC973 - Create Job Order 
def test_createJobOrder
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::JOB_TEMPLATES_TAB_LINK_URL
  test = [{"displayed" => JobTemplates::FIRST_JOB_TEMPLATE_IN_LIST_XPATH},
          {"click" => JobTemplates::FIRST_JOB_TEMPLATE_IN_LIST_XPATH},
          {"displayed" => JobTemplates::CREATE_JOB_ORDER_BUTTON_XPATH},
          {"click" => JobTemplates::CREATE_JOB_ORDER_BUTTON_XPATH},
          {"displayed" => JobTemplates::NEXT_BUTTON_XPATH},
          {"click" => JobTemplates::NEXT_BUTTON_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, RequisitionsDetail::REQUISITIONS_DETAIL_BTN_EDIT_XPATH).displayed?  
  }         
end

#TC974 - Create Job Order, Validation 
def test_createJobOrderValidation
  Common.login(Common::USER_EMAIL, Common::PASSWORD)
  $browser.get HomePage::JOB_TEMPLATES_TAB_LINK_URL
  test = [{"displayed" => JobTemplates::FIRST_JOB_TEMPLATE_IN_LIST_XPATH},
          {"click" => JobTemplates::FIRST_JOB_TEMPLATE_IN_LIST_XPATH},
          {"displayed" => JobTemplates::CREATE_JOB_ORDER_BUTTON_XPATH},
          {"click" => JobTemplates::CREATE_JOB_ORDER_BUTTON_XPATH},
          {"displayed" => JobTemplates::NEXT_BUTTON_XPATH},
          {"set_text" => JobTemplates::PRIMARY_RECRUITER_TEXT_FIELD_XPATH, "text" => ""},
          {"click" => JobTemplates::NEXT_BUTTON_XPATH}]
  Common.main(test)
  assert $wait.until {
    $browser.find_element(:xpath, JobTemplates::ERROR_REQUIRED_FIELD_XPATH).displayed?  
  } 
  assert_equal($browser.find_element(:xpath, JobTemplates::ERROR_REQUIRED_FIELD_XPATH).text, JobTemplates::ERROR_REQUIRED_FIELD_TEXT)
end  
  
end




