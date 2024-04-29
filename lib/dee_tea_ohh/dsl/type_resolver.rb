# frozen_string_literal: true

# = Type Resolver
module DeeTeaOhh::DSL::TypeResolver
  refine Symbol do
    def dto_type
      case self
      when :int, :integer then DeeTeaOhh::Type::Integer.new
      when :str, :string then DeeTeaOhh::Type::String.new
      when :float then DeeTeaOhh::Type::Float.new
      when :bool then DeeTeaOhh::Type::Boolean.new
      end
    end
  end

  refine DeeTeaOhh::Type::Base do
    def dto_type = self
  end

  refine Array do
    def dto_type
      # TODO: Error Handling
      DeeTeaOhh::Type::Array.new(first.dto_type)
    end
  end

  refine DeeTeaOhh::DSL::ObjectTypeDef do
    def dto_type = self.class.dto_type
  end

  using self

  module_function

  def resolve(any) = any.dto_type
end
