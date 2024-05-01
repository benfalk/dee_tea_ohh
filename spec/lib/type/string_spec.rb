# frozen_string_literal: true

RSpec.describe DeeTeaOhh::Type::String do
  let(:instance) { described_class.new }

  it do
    expect(instance).to be_a(described_class)
    expect(DeeTeaOhh::Schema.json(instance)).to eq(type: 'string')
  end
end
