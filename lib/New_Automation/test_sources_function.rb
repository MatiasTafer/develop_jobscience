require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'securerandom'

require_relative 'test_basic.rb'
require_relative 'common.rb'
require_relative './pages/board_setup_detail_page.rb'
require_relative './pages/board_setup_edit_page.rb'
require_relative './pages/board_setup_home_page.rb'
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_register_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/home_page.rb'
require_relative './pages/contacts_home_page.rb'
require_relative './pages/contacts_detail_page.rb'
require_relative './pages/contacts_new_edit_page.rb'
require_relative './pages/answer_detail_page.rb'
require_relative './pages/setup_page.rb'
require_relative './pages/job_board_home_page.rb'
require_relative './pages/job_board_job_detail.rb'
require_relative './pages/applications_detail_page.rb'
require_relative 'custom_settings.rb'
require_relative './pages/accounts_home_page.rb'
require_relative './pages/accounts_new_edit_page.rb'
require_relative './pages/accounts_detail_page.rb'
require_relative './pages/skill_detail_page.rb'
require_relative './pages/short_list_home_page.rb'
require_relative './pages/short_list_new_edit_page.rb'
require_relative './pages/short_list_detail_page.rb'
require_relative './pages/short_list_send_email_popup.rb'
require_relative './pages/short_list_review_email_popup.rb'
require_relative './pages/requisitions_home_page.rb'
require_relative './pages/requisitions_new_and_edit.rb'
require_relative './pages/requisitions_detail_page.rb'
require_relative './pages/search_results_page.rb'
require_relative './pages/education_history_new_page.rb'
require_relative './pages/employment_history_new_page.rb'
require_relative './pages/forward_popup.rb'
require_relative './pages/applications_home_page.rb'
require_relative './pages/applications_detail_page.rb'
require_relative './pages/submittals_home_page.rb'
require_relative './pages/submittals_detail_page.rb'
require_relative './pages/interviews_detail_page.rb'
require_relative './pages/interviews_home_page.rb'
require_relative './pages/offers_home_page.rb'
require_relative './pages/offers_detail_page.rb'
require_relative './pages/placements_detail_page.rb'
require_relative './pages/placements_home_page.rb'
require_relative './pages/source_home_page.rb'
require_relative './pages/source_new_edit_page.rb'



class TestSourcesFunction < TestBasic
  
  $USER_JOB_BOARD = "ETTT@fromthesky.up"
  $PASSWORD_JOB_BOARD = "otherworld666"
  
  
  
end