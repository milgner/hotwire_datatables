# frozen_string_literal: true

RSpec.describe HotwireDatatables::Column do
  subject { described_class.new("foo_bar") }

  it { is_expected.to respond_to(:name) }

  it "receives name as first constructor argument" do
    expect(subject.name).to eq("foo_bar")
  end

  it { is_expected.to respond_to(:title) }

  it "returns the titleized name if not overridden" do
    expect(subject.title).to eq("Foo Bar")
  end

  it "returns explicit value if given" do
    subject.title = "Foo"
    expect(subject.title).to eq("Foo")
  end

  it { is_expected.to respond_to(:sortable) }
  it { is_expected.to respond_to(:sortable?) }
  it { is_expected.to respond_to(:sort_expression) }
  it { is_expected.to respond_to(:value) }
end
