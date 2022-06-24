# frozen_string_literal: true

RSpec.describe "Column DSL" do
  subject(:clazz) do
    Class.new(HotwireDatatables::Table) do
      column :title
    end
  end

  it { is_expected.to respond_to(:columns) }

  describe "Table.columns" do
    it "contains columns" do
      expect(subject.columns.length).to eq(1)
      subject.columns.each { |col| expect(col).to be_a_kind_of(HotwireDatatables::Column) }

      names = subject.columns.map(&:name)
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
