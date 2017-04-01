require_relative "../app/robot"

describe "Robot" do
  let(:robot) { Robot.new }

  describe "#face=" do
    describe "valid orientation, non case-sensitive" do
      specify do
        expect { robot.face=("NORTH") }.to change(robot, :face).from(nil).to(:north)
      end
      specify do
        expect { robot.face=("west") }.to change(robot, :face).from(nil).to(:west)
      end
      specify do
        expect { robot.face=("South") }.to change(robot, :face).from(nil).to(:south)
      end
      specify do
        expect { robot.face=("eAST") }.to change(robot, :face).from(nil).to(:east)
      end
    end

    describe "invalid orientation" do
      specify do
        expect{ robot.face=("SOUTHEAST") }.not_to change(robot, :face)
      end
    end
  end

  describe "#face?" do
    describe "valid orientation, non case-sensitive" do
      specify do
        expect(robot.face?("NORTH")).to be true
      end
      specify do
        expect(robot.face?("west")).to be true
      end
      specify do
        expect(robot.face?("South")).to be true
      end
      specify do
        expect(robot.face?("eAST")).to be true
      end
    end

    describe "invalid orientation" do
      specify do
        expect(robot.face?("SOUTHEAST")).to be false
      end
    end
  end

  describe "#orientation_set?" do
    subject { robot.orientation_set? }

    context "when face has not been set yet" do
      it { is_expected.to be false }
    end

    context "when face has been set" do
      before { robot.face = :north }
      it { is_expected.to be true }
    end
  end

  describe "#left!" do
    subject { robot.left! }

    describe "from North turns to West" do
      before { robot.face = :north }

      specify do
        expect { subject } .to change(robot, :face).from(:north).to(:west)
      end
    end

    describe "from West turns to South" do
      before { robot.face = :west }

      specify do
        expect { subject } .to change(robot, :face).from(:west).to(:south)
      end
    end

    describe "from South turns to East" do
      before { robot.face = :south }

      specify do
        expect { subject } .to change(robot, :face).from(:south).to(:east)
      end
    end

    describe "from East turns to North" do
      before { robot.face = :east }

      specify do
        expect { subject } .to change(robot, :face).from(:east).to(:north)
      end
    end
  end

  describe "#right!" do
    subject { robot.right! }

    describe "from North turns to East" do
      before { robot.face = :north }

      specify do
        expect { subject } .to change(robot, :face).from(:north).to(:east)
      end
    end

    describe "from East turns to South" do
      before { robot.face = :east }

      specify do
        expect { subject } .to change(robot, :face).from(:east).to(:south)
      end
    end

    describe "from South turns to West" do
      before { robot.face = :south }

      specify do
        expect { subject } .to change(robot, :face).from(:south).to(:west)
      end
    end

    describe "from West turns to North" do
      before { robot.face = :west }

      specify do
        expect { subject } .to change(robot, :face).from(:west).to(:north)
      end
    end
  end
end