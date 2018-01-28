require 'spec_helper'

RSpec.describe Frontier::ControllerAction::UpdateAction do

  describe "#to_s" do
    subject { Frontier::ControllerAction::UpdateAction.new(model).to_s }
    let(:model) { build_model }

    let(:expected) do
      raw = <<-STRING
def update
  @test_model = find_test_model
  @test_model.assign_attributes(test_model_params)
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
