# frozen_string_literal: true

# = Type
#
# Everything needed to describe and work
# with defining types to encode to.
#
module DeeTeaOhh::Type
  # = Base Type Definition
  #
  # Any and all shared functionality comes from
  # this base type definition.
  #
  class Base
    # @return [Hash]
    def json_schema = DeeTeaOhh::Schema.json(self)
  end
  private_constant :Base

  # = Object Type Definition
  #
  # Holds any number of named fields and the
  # types that they hold
  #
  class Object < Base
    # @return [Hash<Symbol, DeeTeaOhh::Attribute>]
    attr_reader :attributes

    # @param attributes [Hash<Symbol, DeeTeaOhh::Attribute>]
    def initialize(attributes = {})
      super()
      @attributes = attributes
      freeze
    end
  end

  # = Nullable Type Definition
  #
  # Type wrapper that describes a type can be either
  # the type provided OR it may be Null
  #
  class Nullable < Base
    # @return [DeeTeaOhh::Type::Base]
    attr_reader :type

    # @param type [DeeTeaOhh::Type::Base]
    def initialize(type)
      super()
      @type = type
      freeze
    end
  end

  # = Array Type Definition
  #
  # Type wrapper which describes an array of zero
  # or more of the provided type.
  #
  class Array < Base
    # @return [DeeTeaOhh::Type::Base]
    attr_reader :type

    # @param type [DeeTeaOhh::Type::Base]
    def initialize(type)
      super()
      @type = type
      freeze
    end
  end

  # = Integer Type Definition
  class Integer < Base; end

  # = Float Type Definition
  class Float < Base; end

  # = String Type Definition
  class String < Base; end
end
