#require 'ci/reporter/rake/test_unit_loader'
require 'test-unit' 
require 'rubygems'
require 'selenium-webdriver'
require 'test-unit'
require 'net/http'

#Global scope
$browserName = ARGV[0]
$browser
$wait

require './New_Automation/test_applications.rb'