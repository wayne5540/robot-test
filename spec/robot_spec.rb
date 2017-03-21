require_relative "../app/Robot"

describe "Robot" do
  let(:robot) { Robot.new }

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