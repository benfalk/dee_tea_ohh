# frozen_string_literal: true

FactoryBot.define do
  # Simple Types
  factory :string_type, class: DeeTeaOhh::Type::String
  factory :int_type, class: DeeTeaOhh::Type::Integer
  factory :float_type, class: DeeTeaOhh::Type::Float
  factory :bool_type, class: DeeTeaOhh::Type::Boolean

  # Container Types
  factory :array_type, class: DeeTeaOhh::Type::Array do
    transient do
      type { build(:string_type) }
    end

    trait :string do
      type { build(:string_type) }
    end

    trait :float do
      type { build(:float_type) }
    end

    trait :bool do
      type { build(:bool_type) }
    end

    trait :int do
      type { build(:int_type) }
    end

    initialize_with { new(type) }
  end
end
