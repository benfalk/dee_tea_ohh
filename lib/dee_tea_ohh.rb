# frozen_string_literal: true

require_relative 'dee_tea_ohh/version'

# = DeeTeeOhh
#
# TODO: Documentation
module DeeTeaOhh
  class Error < StandardError; end

  require_relative 'dee_tea_ohh/attribute'
  require_relative 'dee_tea_ohh/type'
  require_relative 'dee_tea_ohh/schema'
end
