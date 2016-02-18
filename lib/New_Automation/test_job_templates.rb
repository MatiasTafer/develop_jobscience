require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'

require_relative './pages/job_templates_page.rb'
require_relative './pages/job_template_detail_page.rb'
require_relative './pages/new_job_template_page.rb'
require_relative './pages/home_page.rb'

class TestJobTemplates < TestBasic
  
=begin  
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
=end

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
  
  
  
  
  
  
  
end




