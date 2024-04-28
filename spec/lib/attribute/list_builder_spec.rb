# frozen_string_literal: true

RSpec.describe DeeTeaOhh::Attribute::ListBuilder do
  # @!attribute [r] builder
  #   @return [DeeTeaOhh::Attribute::ListBuilder]
  let(:builder) { described_class.new }

  shared_examples_for 'a list with single attr' do |name, type|
    it do
      is_expected.to be_a(DeeTeaOhh::Attribute::List)

      expect(subject.count).to eq(1)

      expect(subject[name])
        .to be_an_attribute
        .with_field_name(name)
        .that_is_required

      expect(subject[name].type).to be_a(type)
    end
  end

  shared_examples_for 'a list with a nullable attr' do |name, type|
    it_behaves_like 'a list with single attr',
                    name, DeeTeaOhh::Type::Nullable
    it { expect(subject[name].type.type).to be_a(type) }
  end

  context 'empty' do
    subject { builder.build }
    it do
      is_expected.to be_a(DeeTeaOhh::Attribute::List)
      is_expected.to be_none
    end
  end

  context 'single string field' do
    subject { builder.string(:first_name).build }
    it_behaves_like 'a list with single attr',
                    :first_name, DeeTeaOhh::Type::String
  end

  context 'single float field' do
    subject { builder.float(:price).build }
    it_behaves_like 'a list with single attr',
                    :price, DeeTeaOhh::Type::Float
  end

  context 'single integer field' do
    subject { builder.integer(:age).build }
    it_behaves_like 'a list with single attr',
                    :age, DeeTeaOhh::Type::Integer
  end

  context 'single boolean field' do
    subject { builder.bool(:enabled).build }
    it_behaves_like 'a list with single attr',
                    :enabled, DeeTeaOhh::Type::Boolean
  end

  context 'single nullable string field' do
    subject { builder.string(:first_name, null: true).build }
    it_behaves_like 'a list with a nullable attr',
                    :first_name, DeeTeaOhh::Type::String
  end

  context 'single nullable float field' do
    subject { builder.string(:price, null: true).build }
    it_behaves_like 'a list with a nullable attr',
                    :price, DeeTeaOhh::Type::String
  end

  context 'single nullable integer field' do
    subject { builder.integer(:count, null: true).build }
    it_behaves_like 'a list with a nullable attr',
                    :count, DeeTeaOhh::Type::Integer
  end

  context 'single nullable boolean field' do
    subject { builder.bool(:success, null: true).build }
    it_behaves_like 'a list with a nullable attr',
                    :success, DeeTeaOhh::Type::Boolean
  end

  context 'single nullable array field' do
    subject do
      builder
        .array(
          :scores,
          type: DeeTeaOhh::Type::Float.new,
          null: true
        )
        .build
    end
    it_behaves_like 'a list with a nullable attr',
                    :scores, DeeTeaOhh::Type::Array
    it do
      # Nullable > Array > Float
      expect(subject[:scores].type.type.type)
        .to be_a(DeeTeaOhh::Type::Float)
    end
  end

  context 'single array field' do
    subject { builder.array(:names, type: DeeTeaOhh::Type::String.new).build }
    it_behaves_like 'a list with single attr',
                    :names, DeeTeaOhh::Type::Array
    it do
      expect(subject[:names].type.type)
        .to be_a(DeeTeaOhh::Type::String)
    end
  end
end
