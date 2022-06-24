# frozen_string_literal: true

RSpec.describe "Column DSL" do
  class ExampleTable < HotwireDatatables::Table
    column :title
  end

  describe "Table.columns" do
    it "is defined" do
      expect(ExampleTable).to respond_to(:columns)
    end

    it "contains columns" do
      expect(ExampleTable.columns.length).to eq(1)
      ExampleTable.columns.each { |col| expect(col).to be_a_kind_of(HotwireDatatables::Column) }

      names = ExampleTable.columns.map(&:name)
      expect(names).to match_array(%i[title])
    end
  end

  describe "title" do
    subject(:column) { table.columns.first }

    let(:table) do
      Class.new(HotwireDatatables::Table) do
        column :foo_bar do
          title "Baz23"
        end
      end
    end

    it "passes specified string to column" do
      expect(column.title).to eq("Baz23")
    end
  end
end
