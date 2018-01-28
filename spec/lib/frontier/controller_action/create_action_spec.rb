require 'spec_helper'

RSpec.describe Frontier::ControllerAction::CreateAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::CreateAction.new(model).to_s }
    let(:model) { build_model }

    let(:expected) do
      raw = <<-STRING
def create
  @test_model = TestModel.new(test_model_params)
  authorize(TestModel)
  @test_model.save

  respond_with(@test_model, location: admin_test_models_path)
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
