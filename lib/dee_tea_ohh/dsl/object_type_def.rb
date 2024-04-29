# frozen_string_literal: true

# = Object Definition Tag
#
# This serves as a tag for produced
# transformation object definitions.
#
module DeeTeaOhh::DSL::ObjectTypeDef
  # @private
  module ClassMethods
    def dto_type = @dto_type

    def inherited(klass)
      super
      klass.extend(ClassMethods)
      klass.instance_variable_set(
        :@dto_type,
        dto_type
      )
    end
  end
  private_constant :ClassMethods

  def self.included(klass) = klass.extend(ClassMethods)
end
