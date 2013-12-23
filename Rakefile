require 'foodcritic'
require 'kitchen/rake_tasks'

# --- tasks ---------------------------------------------------------------------------------------

task :default => :foodcritic

Kitchen::RakeTasks.new do |t|
end

FoodCritic::Rake::LintTask.new do |t|
end

desc "Runs knife cookbook test"
task :knife do
  mkdir_p sandbox_path
  prepare_sandbox
  sh "bundle exec knife cookbook test cookbook -c test/knife.rb -o #{sandbox_path}/../"
  rm_rf File.join(File.dirname(__FILE__), %w(sandbox))
end

private

def sandbox_path
  File.join(File.dirname(__FILE__), %w(sandbox cookbooks cookbook))
end

def prepare_sandbox
  files = %w{*.md *.rb attributes definitions files libraries providers recipes resources templates}
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox_path
end
