# frozen_string_literal: true

require_relative 'dee_tea_ohh/version'

# = DeeTeeOhh
#
# TODO: Documentation
module DeeTeaOhh
  require_relative 'dee_tea_ohh/attribute'
  require_relative 'dee_tea_ohh/type'
  require_relative 'dee_tea_ohh/schema'

  class Error < StandardError; end
  # Your code goes here...
end
