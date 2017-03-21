require_relative "../app/Table"

describe "Table" do
  let(:table) { Table.new }

  describe "#place?" do
    describe "boundary" do
      context 'when inside boundary' do
        it { expect(table.place?(0, 0)).to be true }
        it { expect(table.place?(1, 0)).to be true }
        it { expect(table.place?(0, 2)).to be true }
        it { expect(table.place?(4, 4)).to be true }
      end
      context 'when out of boundary' do
        it { expect(table.place?(-1, 0)).to be false }
        it { expect(table.place?(1, -1)).to be false }
        it { expect(table.place?(5, 0)).to be false }
        it { expect(table.place?(1, 5)).to be false }
      end
    end
  end
end