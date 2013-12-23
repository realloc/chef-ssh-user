COOKBOOK_NAME = "ssh_user"
COOKBOOK_CATEGORY = "Networking"

task :default do
  system "rake -T"
end

desc "Runs foodcritic test"
task :foodcritic do
  system "foodcritic ."
end

desc "Runs kitchen tests"
task :kitchen_test do
  system "kitchen test all"
end

desc "Share cookbook to the opscode community site"
task :share do
  cleanup_sandbox
  prepare_sandbox
  system "bundle exec knife cookbook site share '#{COOKBOOK_NAME}' '#{COOKBOOK_CATEGORY}' -V -o #{sandbox_path}/../"
  cleanup_sandbox
end

desc "Runs knife cookbook test"
task :knife_test do
  cleanup_sandbox
  prepare_sandbox
  system "bundle exec knife cookbook test '#{COOKBOOK_NAME}' -c test/knife.rb -o #{sandbox_path}/../"
  #cleanup_sandbox
end

private

def sandbox_path
  File.join('/tmp', 'cookbooks', COOKBOOK_NAME)
end

def prepare_sandbox
  mkdir_p sandbox_path
  files = %w{*.md *.rb *}
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox_path
end

def cleanup_sandbox
  rm_rf sandbox_path
end