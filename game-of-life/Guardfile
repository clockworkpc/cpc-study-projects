def watch_spec_and_lib_files(dsl)
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
end

scope group: :default

group :default do
  guard :rspec, cmd: 'bundle exec rspec --format documentation' do
    require 'guard/rspec/dsl'
    dsl = Guard::RSpec::Dsl.new(self)
    watch_spec_and_lib_files(dsl)
  end
end

group :tdd do
  guard :rspec, cmd: 'bundle exec rspec --format documentation --only-failures' do
    require 'guard/rspec/dsl'
    dsl = Guard::RSpec::Dsl.new(self)
    watch_spec_and_lib_files(dsl)
  end
end
