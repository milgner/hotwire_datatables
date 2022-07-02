# frozen_string_literal: true

RSpec.describe HotwireDatatables::Table do
  fixtures :books

  let(:clazz) do
    Class.new(HotwireDatatables::Table) do
    end
  end

  let(:request) do
    ActionDispatch::Request.new({ "REQUEST_METHOD" => "GET",
                                  "rack.input" => -> {} })
  end

  subject(:table) do
    clazz.new(request, Book.all)
  end

  it { is_expected.to respond_to(:rows) }

  describe "#rows" do
    subject(:rows) { table.rows }

    it "returns Row objects for visible records" do
      expect(subject.length).to eq(1)
      row = subject.first
      expect(row).to be_a_kind_of(HotwireDatatables::Row)
      expect(row.record).to eq(Book.first)
    end
  end

  it { is_expected.to respond_to(:to_partial_path) }

  describe "#pagination_context" do
    it "defaults to Pagy" do
      expect(table.pagination_context).to(
        be_a_kind_of(HotwireDatatables::PaginationAdapters::Pagy::PaginationContext)
      )
    end
  end

  it "provides access to class-level columns" do
    fake_columns = []
    expect(clazz).to receive(:columns).and_return(fake_columns)
    expect(table.columns).to equal(fake_columns)
  end
end
