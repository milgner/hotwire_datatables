# frozen_string_literal: true

RSpec.describe HotwireDatatables::Row do
  fixtures :books

  let(:table_class) do
    Class.new(HotwireDatatables::Table) do
      column :title
    end
  end
  let(:table) { table_class.new({}, Book.all) }
  let(:record) { Book.first }

  subject(:row) { described_class.new(table, record) }

  describe "#cells" do
    it { is_expected.to respond_to(:cells) }
    it "returns a cell for every column" do
      expect(row.cells.length).to eq(table_class.columns.length)
    end
    it "returns Cell objects" do
      row.cells.each do |cell|
        expect(cell).to be_a_kind_of(HotwireDatatables::Cell)
      end
    end
  end
end
