require "runner"

RSpec.configure do |config|
  config.expose_dsl_globally = false
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end
end
