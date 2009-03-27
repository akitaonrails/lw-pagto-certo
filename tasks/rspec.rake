gem 'test-unit', '1.2.3' if RUBY_VERSION.to_f >= 1.9
gem 'rspec'
require 'spec/rake/spectask'

# Don't load rspec if running "rake gems:*"
unless ARGV.any? {|a| a =~ /^gems/}

Rake.application.instance_variable_get('@tasks').delete('default')

CURRENT_DIR = File.expand_path(File.dirname(__FILE__)) + "/.."

task :default => :spec
task :stats => "spec:statsetup"

desc "Run all specs in spec directory (excluding plugin specs)"
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['--options', "\"#{CURRENT_DIR}/spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

namespace :spec do
  desc "Run all specs in spec directory with RCov (excluding plugin specs)"
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.spec_opts = ['--options', "\"#{CURRENT_DIR}/spec/spec.opts\""]
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true
    t.rcov_opts = lambda do
      IO.readlines("#{CURRENT_DIR}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
    end
  end

  desc "Print Specdoc for all specs (excluding plugin specs)"
  Spec::Rake::SpecTask.new(:doc) do |t|
    t.spec_opts = ["--format", "specdoc", "--dry-run"]
    t.spec_files = FileList['spec/**/*_spec.rb']
  end
end

end