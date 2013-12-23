
# --- tasks ---------------------------------------------------------------------------------------

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

desc "Runs knife cookbook test"
task :knife_test do
  sandbox_path = File.join(File.dirname(__FILE__), %w(sandbox cookbooks cookbook))
  mkdir_p sandbox_path
  files = %w{*.md *.rb attributes definitions files libraries providers recipes resources templates}
  cp_r Dir.glob("{#{files.join(',')}}"), sandbox_path
  sh "bundle exec knife cookbook test cookbook -c test/knife.rb -o #{sandbox_path}/../"
  rm_rf File.join(File.dirname(__FILE__), %w(sandbox))
end

