require_relative "../app/table"

describe "Table" do
  let(:table) { Table.new }

  describe "place!" do
    let(:x) { 1 }
    let(:y) { 2 }
    subject { table.place!(x, y) }

    context "when place-able" do
      it "sets robot_position" do
        subject

        expect(table.robot_position).to eq({ x: x, y: y })
      end

      it { is_expected.to be true }
    end

    context "when non-place-able" do
      before do
        allow(table).to receive(:place?).with(x, y) { false }
      end

      it { is_expected.to be false }
    end
  end

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

    describe "placed" do
      let(:x) { 1 }
      let(:y) { 2 }
      before { table.robot_position = { x: x, y: y } }

      it "returns false" do
        expect(table.place?(x, y)).to be false
      end
    end
  end
end