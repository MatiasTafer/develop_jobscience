require 'ci/reporter/rake/test_unit_loader'
require 'test-unit' 
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'net/http'

#Global scope
$browserName = ARGV[0]
$browser
$wait


#Ready for Jenkins-----------

#require './New_Automation/tests/test_url_builder.rb'

#require './New_Automation/tests/test_job_templates.rb'

#require './New_Automation/tests/test_candidates_actions_on_record'

#require './New_Automation/tests/test_candidates_actions'

#require './New_Automation/tests/test_candidates_action_on_list_view'

#require './New_Automation/tests/test_daxtra_parse.rb'

#require './New_Automation/test_requisition.rb'

#require './New_Automation/tests/test_standard_questions'

#Pending Jenkins-------------

require './New_Automation/tests/test_sources.rb'

#require './New_Automation/tests/test_resume.rb'

#require './New_Automation/tests/test_email_actions'

#require './New_Automation/tests/test_eeo_question.rb'

#require './New_Automation/tests/test_requisition.rb'

#require './New_Automation/test_email_actions'

#require './New_Automation/test_job_board'

#require './New_Automation/tests/test_standard_questions'

#require './New_Automation/test_projects'

#require './New_Automation/test_short_list.rb'

#require './New_Automation/test_projects'

#require './New_Automation/tests/test_question_sets'

#require './New_Automation/tests/test_candidates_parsing_candidates_file_types'

#require './New_Automation/test_candidates_misc'

#require './New_Automation/tests/test_board_setup'

#require './New_Automation/tests/test_job_board'

#require './New_Automation/tests/test_applications.rb'

#require './New_Automation/test_daxtra_parse.rb'

#require './New_Automation/tests/test_daxtra_parse.rb'

#require './New_Automation/test_candidates_actions_on_record'

#require './New_Automation/test_applications.rb'

#require './New_Automation/tests/test_eeo_question.rb'