# frozen_string_literal: true

# = Domain Specific Language
#
# Everyone loves magic; I myself enjoy dabling in
# the dark arts from time to time.  Having said that,
# this magic is best if it's understandable for those
# who need to know.
#
module DeeTeaOhh::DSL
  require_relative 'dsl/data_builder'
  require_relative 'dsl/type_resolver'
  require_relative 'dsl/object_type_def'
end