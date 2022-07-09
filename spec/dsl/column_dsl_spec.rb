# frozen_string_literal: true

RSpec.describe "Column DSL" do
  subject(:column) { table.columns.first }

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
        subject.columns.each { |col| expect(col).to be_a_kind_of(HotwireDatatables::ColumnDefinition) }

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
    
    it "marks the column as sortable" do
      expect(column).to be_sortable
    end
  end

  describe 'virtual' do
    context 'using a partial' do
      let(:table) do
        Class.new(HotwireDatatables::Table) do
          column :actions do
            virtual partial: 'foobar/table_row_actions'
          end
        end
      end

      it 'is marked as virtual' do
        expect(column).to be_virtual
      end

      it 'registers a partial renderer' do
        expect(column.cell_renderer).to be_a(HotwireDatatables::Rendering::PartialRenderer)
      end
    end
  end

  describe 'value' do
    let(:table) do
      Class.new(HotwireDatatables::Table) do
        column :foo_bar do
          format_with ->(record) { "#{record}_baz" }
        end
      end
    end

    it 'assigns the proc' do
      expect(column.format_value("foo")).to eq("foo_baz")
    end
  end
end
