require_relative "../app/controller"

describe "controller" do
  let(:controller) { Controller.new }

  describe "#execute!" do
    describe "action PLACE" do
      context "when invalid arguments" do
        specify do
          controller.execute!("PLACE")

          expect(controller.outputs.first).to eq("Error: PLACE action requires 3 arguments: X,Y,F")
        end

        specify do
          controller.execute!("PLACE one,")

          expect(controller.outputs.first).to eq("Error: InvalidArgumentsError")
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
          controller.execute!("LEFT")

          expect(controller.outputs.first).to include("Error:")
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
          controller.execute!("RIGHT")

          expect(controller.outputs.first).to include("Error:")
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
          controller.execute!("MOVE")

          expect(controller.outputs.first).to include("Error:")
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

    describe "action REPORT" do
      context "when robot has been placed" do
        let(:x) { 1 }
        let(:y) { 2 }
        let(:f) { "NORTH" }

        before do
          controller.execute!("PLACE #{x},#{y},#{f}")
        end

        it "add X,Y,F into outputs" do
          controller.execute!("REPORT")

          expect(controller.outputs.first).to eq("#{x},#{y},#{f.downcase}")
        end
      end

      context "when robot has not been placed yet" do
        specify do
          controller.execute!("REPORT")

          expect(controller.outputs.first).to eq("Error: REPORT is only available after robot has been placed")
        end
      end
    end

    describe "invalid action" do
      specify "case sensitive" do
        controller.execute!("right")

        expect(controller.outputs.first).to eq("Error: right is not a valid action")
      end

      specify do
        controller.execute!("invalid command")

        expect(controller.outputs.first).to eq("Error: invalid is not a valid action")
      end
    end
  end
end