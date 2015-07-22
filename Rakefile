require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'hbs_content'
require 'dotenv'
Dotenv.load

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :configure do
  HbsContent.configure(:contentful, access_token: ENV['CONTENTFUL_ACCESS_TOKEN'], space: ENV['CONTENTFUL_SPACE_ID'])
end

namespace :people do
  task :all => :configure do
    HbsContent::Person.all.each do |person|
      puts person.full_name
    end
  end
end
