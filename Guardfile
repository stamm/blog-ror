# A sample Guardfile
# More info at https://github.com/guard/guard#readme


guard 'rspec', spring: true, all_on_start: false, all_after_pass: false do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| %W(
    spec/routing/#{m[1]}_routing_spec.rb
    spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb
    spec/acceptance/#{m[1]}_spec.rb
    )
  }
  watch(%r{^app/models/(.+)\.rb$})                    { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/models/concerns/.+\.rb$})             { "spec/models" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }
  
  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
  
  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end


#guard 'cucumber', cli: "--no-profile --drb --color", all_after_pass: false, notification: false do
#  watch(%r{^features/.+\.feature$})
#  watch(%r{^features/support/.+$})          { 'features' }
#  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
#end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
