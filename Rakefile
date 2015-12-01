require "bundler/gem_tasks"
require 'rubygems'
require 'ci/reporter/rake/test_unit_loader'
require 'ci/reporter/rake/test_unit'

task :firefox => 'ci:setup:testunit' do
  cd 'lib'  
  ruby 'New_Automation.rb ' 'firefox'  
end

task :chrome => 'ci:setup:testunit' do
  cd 'lib'  
  ruby 'New_Automation.rb ' 'chrome'  
end

task :safari => 'ci:setup:testunit' do
  cd 'lib'  
  ruby 'New_Automation.rb ' 'safari'  
end

task :internet_explorer => 'ci:setup:testunit' do
  cd 'lib'  
  ruby 'New_Automation.rb ' 'internet_explorer'  
end