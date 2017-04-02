require "rake/testtask"

task default: [:test]

def cli_colored_text(color_code, text)
  "\e[#{color_code}#{text}\e[0m"
end

desc "Run all applicaiton tests"
Rake::TestTask.new do |t|
  t.libs.push '.'
  t.pattern = "test/*_test.rb"
end

