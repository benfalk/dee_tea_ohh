# frozen_string_literal: true

# = Type Resolver
module DeeTeaOhh::DSL::TypeResolver
  module Constants
    STRING = DeeTeaOhh::Type::String.new.freeze
    FLOAT = DeeTeaOhh::Type::Float.new.freeze
    INTEGER = DeeTeaOhh::Type::Integer.new.freeze
    BOOLEAN = DeeTeaOhh::Type::Boolean.new.freeze
  end
  private_constant :Constants

  refine Kernel do
    import_methods DeeTeaOhh::DSL::TypeSpecs
  end

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

  refine ::String.singleton_class do
    def dto_type = Constants::STRING
  end

  refine ::String do
    def dto_type = Constants::STRING
  end

  refine ::Float.singleton_class do
    def dto_type = Constants::FLOAT
  end

  refine ::Float do
    def dto_type = Constants::FLOAT
  end

  refine ::Integer.singleton_class do
    def dto_type = Constants::INTEGER
  end

  refine ::Integer do
    def dto_type = Constants::INTEGER
  end

  refine ::TrueClass do
    def dto_type = Constants::BOOLEAN
  end

  refine ::FalseClass do
    def dto_type = Constants::BOOLEAN
  end

  refine ::Set do
    def dto_type
      # TODO: Type checking of all values
      DeeTeaOhh::Type::Enum.new(
        first.dto_type,
        values: dup.freeze
      )
    end
  end

  using self

  module_function

  def resolve(any) = any.dto_type
end
