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
end
