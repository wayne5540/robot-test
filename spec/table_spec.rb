require_relative "../app/table"

describe "Table" do
  let(:table) { Table.new }

  describe "place!" do
    let(:x) { 1 }
    let(:y) { 2 }
    subject { table.place!(x, y) }

    context "when place-able" do
      it "sets robot_position" do
        expect { subject }.to change { table.robot_position }.from(nil).to({ x: x, y: y })
      end
    end

    context "when non-place-able" do
      before do
        allow(table).to receive(:place?).with(x, y) { false }
      end

      it "doesn't set robot_position" do
        expect { subject }.not_to change { table.robot_position }
      end
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
      before { table.place!(x, y) }

      it "returns false" do
        expect(table.place?(x, y)).to be false
      end
    end
  end

  describe "placed?" do
    context "when been placed" do
      before do
        table.place!(1, 2)
      end
      specify do
        expect(table.placed?).to be true
      end
    end

    context "when not been placed yet" do
      specify do
        expect(table.placed?).to be false
      end
    end
  end
end