namespace :ci do

  require 'rubocop/rake_task'
  RuboCop::RakeTask.new

  task(:quality).clear
  task quality: [:rubocop]
  task(:test).clear
  task test: [:quality, :spec_with_coverage]

  task :spec_with_coverage do
    ENV['RUN_COVERAGE'] = 'true'
    Rake::Task['spec'].invoke
  end

  task :pact_without_coverage do
    ENV['RUN_COVERAGE'] = 'false'
    Rake::Task['pact:verify'].invoke
  end

end
