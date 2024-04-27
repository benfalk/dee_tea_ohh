# frozen_string_literal: true

RSpec.describe DeeTeaOhh::Type::Float do
  let(:instance) { described_class.new }

  it do
    expect(instance).to be_a(described_class)
    expect(instance.json_schema).to eq(type: 'numeric')
  end
end
