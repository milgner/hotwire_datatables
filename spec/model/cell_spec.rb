# frozen_string_literal: true

RSpec.describe HotwireDatatables::Cell do
  fixtures :books

  let(:table_class) do
    Class.new(HotwireDatatables::Table) do
      column :title
    end
  end

  let(:table) { table_class.new({}, Book.all) }
  let(:column_definition) { table_class.columns.first }
  let(:row) { HotwireDatatables::Row.new(table, Book.first) }

  subject(:cell) { described_class.new(column_definition, row) }

  describe "#render_in" do
    it { is_expected.to respond_to(:render_in) }
    context "without additional configuration" do
      it "renders using a lambda renderer and identity function" do
        view_context = double('view context')
        allow(view_context).to receive(:assign)
        expect(cell.render_in(view_context)).to eq("The Hitchhikers Guide to the Galaxy")
      end
    end
  end
end
