# frozen_string_literal: true

RSpec.describe HotwireDatatables::Cell do
  fixtures :books

  let(:table_class) do
    Class.new(HotwireDatatables::Table) do
      column :title
    end
  end

  let(:table) { table_class.new({}, Book.all) }
  let(:column) { table_class.columns.first }
  let(:row) { HotwireDatatables::Row.new(table, Book.first) }

  subject(:cell) { described_class.new(column, row) }

  describe "#to_html" do
    it { is_expected.to respond_to(:to_html) }
    context "without additional configuration" do
      it "returns the string value of the attribute" do
        expect(cell.to_html).to eq("The Hitchhikers Guide to the Galaxy")
      end
    end
  end
end
