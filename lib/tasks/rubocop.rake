if %w(development test).include? Rails.env
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new
end 