require "bundler/gem_tasks"
require 'rubygems'
require 'ci/reporter/rake/test_unit_loader'
require 'ci/reporter/rake/test_unit'

task :test => 'ci:setup:testunit' do
  cd 'lib'
  rm 'test/reports/*'  
  ruby 'New_Automation.rb ' 'firefox'  
end