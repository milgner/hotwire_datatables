# frozen_string_literal: true

RSpec.describe "Column DSL" do
  context 'without configuration block' do
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
  end

  describe "title" do
    let(:table) do
      Class.new(HotwireDatatables::Table) do
        column :foo_bar do
          title "Baz23"
        end
      end
    end

    subject(:column) { table.columns.first }

    it "passes specified string to column" do
      expect(column.title).to eq("Baz23")
    end
  end

  describe 'sortable' do
    let(:table) do
      Class.new(HotwireDatatables::Table) do
        column :foo_bar do
          sortable
        end
      end
    end

    subject(:column) { table.columns.first }

    it "marks the column as sortable" do
      expect(column).to be_sortable
    end
  end

  describe 'value' do
    let(:table) do
      Class.new(HotwireDatatables::Table) do
        column :foo_bar do
          value ->(record) { "#{record}_baz" }
        end
      end
    end

    subject(:column) { table.columns.first }

    it 'assigns the proc' do
      expect(column.value("foo")).to eq("foo_baz")
    end
  end
end
