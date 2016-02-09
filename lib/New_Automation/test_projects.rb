require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/projects_detail_page.rb'
require_relative './pages/projects_home_page.rb'
require_relative './pages/projects_new_project_page.rb'


class TestProjects <TestBasic
  
  #TC963 - New Project Successfully Created
  def test_projectSuccessCreated
    Common.login(Common::USER_EMAIL, Common::PASSWORD)
    $browser.get HomePage::PROJECTS_TAB_LINK_URL
    $wait.until {
      $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).displayed?
    }
    $browser.find_element(:xpath, ProjectsHomePage::PROJECTS_HOME_BTN_NEW_XPATH).click
    $wait.until {
      $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).displayed?
    }
    $browser.find_element(:id, ProjectsNewProject::PROJECTS_NEW_PROJECT_NAME_ID).send_keys ProjectsNewProject::PROJECT_NAME
    $browser.find_element(:xpath, ProjectsNewProject::PROJECTS_NEW_PROJECT_BTN_SAVE_XPATH).click
    assert $wait.until {
      $browser.find_element(:xpath, ProjectDetail::PROJECT_DETAIL_BTN_CLONE).displayed?
    }
    assert_equal($browser.find_element(:id, ProjectDetail::PROJECT_NAME_TEXT_ID).text, ProjectsNewProject::PROJECT_NAME)  
  end
  
  
  
  
end