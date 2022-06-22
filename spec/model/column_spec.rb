# frozen_string_literal: true

RSpec.describe HotwireDatatables::Column do
  subject { described_class.new("foobar") }

  it { is_expected.to respond_to(:name) }
  it "receives name as first constructor argument" do
    expect(subject.name).to eq("foobar")
  end
end
