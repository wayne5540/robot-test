require_relative "../app/controller"

describe "controller" do
  let(:controller) { Controller.new }

  describe "#execute!" do
    describe "action PLACE" do
      context "when invalid arguments" do
        specify do
          expect { controller.execute!("PLACE") }.to raise_error Controller::InvalidArgumentsError
        end

        context "when face is invalid" do
          it "doesn't change robot face orientation" do
            expect { controller.execute!("PLACE 1,2,SOUTHWEST") }.not_to change { controller.robot.face }
          end
          it "doesn't change robot position" do
            expect { controller.execute!("PLACE 1,2,SOUTHWEST") }.not_to change { controller.table.robot_position }
          end
        end

        context "when cordinate is invalid" do
          it "doesn't change robot face orientation" do
            expect { controller.execute!("PLACE -1,2,NORTH") }.not_to change { controller.robot.face }
          end
          it "doesn't change robot position" do
            expect { controller.execute!("PLACE -1,2,NORTH") }.not_to change { controller.table.robot_position }
          end
        end
      end

      context "when valid arguments" do
        specify do
          expect(controller.execute!("PLACE 1,2,north")).to be true
        end
      end
    end

    describe "action LEFT" do
      context "when robot has not been placed yet" do
        specify do
          expect { controller.execute!("LEFT") }.to raise_error Controller::InvalidCommandError
        end
      end

      context "when robot has been placed" do
        before do
          controller.robot.face = "North"
        end

        specify do
          expect(controller.robot).to receive(:left!).once
          controller.execute!("LEFT")
        end
      end
    end

    describe "action RIGHT" do
      context "when robot has not been placed yet" do
        specify do
          expect { controller.execute!("RIGHT") }.to raise_error Controller::InvalidCommandError
        end
      end

      context "when robot has been placed" do
        before do
          controller.robot.face = "North"
        end

        specify do
          expect(controller.robot).to receive(:right!).once
          controller.execute!("RIGHT")
        end
      end
    end

    describe "action MOVE" do
      context "when robot has not been placed yet" do
        specify do
          expect { controller.execute!("MOVE") }.to raise_error Controller::InvalidCommandError
        end
      end

      context "when robot has been placed" do
        let(:x) { 2 }
        let(:y) { 2 }

        describe "North" do
          before do
            controller.execute!("PLACE #{x},#{y},NORTH")
          end

          specify do
            expect {
              controller.execute!("MOVE")
            }.to change {
              controller.table.robot_position
            }.from({ x: x, y: y }).to({ x: x, y: y + 1 })
          end
        end

        describe "SOUTH" do
          before do
            controller.execute!("PLACE #{x},#{y},SOUTH")
          end

          specify do
            expect {
              controller.execute!("MOVE")
            }.to change {
              controller.table.robot_position
            }.from({ x: x, y: y }).to({ x: x, y: y - 1 })
          end
        end

        describe "WEST" do
          before do
            controller.execute!("PLACE #{x},#{y},WEST")
          end

          specify do
            expect {
              controller.execute!("MOVE")
            }.to change {
              controller.table.robot_position
            }.from({ x: x, y: y }).to({ x: x - 1, y: y })
          end
        end

        describe "EAST" do
          before do
            controller.execute!("PLACE #{x},#{y},EAST")
          end

          specify do
            expect {
              controller.execute!("MOVE")
            }.to change {
              controller.table.robot_position
            }.from({ x: x, y: y }).to({ x: x + 1, y: y })
          end
        end
      end
    end

    describe "invalid action" do
      specify "case sensitive" do
        expect { controller.execute!("right") }.to raise_error Controller::InvalidCommandError
      end

      specify do
        expect { controller.execute!("invalid command") }.to raise_error Controller::InvalidCommandError
      end
    end
  end
end