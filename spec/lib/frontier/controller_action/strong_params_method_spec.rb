require 'spec_helper'

describe Frontier::ControllerAction::StrongParamsMethod do

  describe "#to_s" do
    subject { strongs_params_method.to_s }
    let(:strongs_params_method) do
      Frontier::ControllerAction::StrongParamsMethod.new(model)
    end

    describe "omitting fields that are not on the form" do
      let(:model) do
        Frontier::Model.new({
          test_model: {
            attributes: {
              charlie: {type: "string", show_on_form: false},
              address: {type: "belongs_to", form_type: "select"},
              bravo: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        raw = <<-STRING
def test_model_params
  params.fetch(:test_model, {}).permit([:address_id, :bravo])
end
STRING
        raw.rstrip
      end

      it "renders the params on a single line" do
        should eq(expected)
      end
    end

    context "a simple model" do
      context "with 3 or fewer attributes" do
        let(:model) do
          Frontier::Model.new({
            test_model: {
              attributes: {
                charlie: {type: "string"},
                address: {type: "belongs_to", form_type: "select"},
                bravo: {type: "string"},
              }
            }
          })
        end

        let(:expected) do
          raw = <<-STRING
def test_model_params
  params.fetch(:test_model, {}).permit([:address_id, :bravo, :charlie])
end
STRING
          raw.rstrip
        end

        it "renders the params on a single line" do
          should eq(expected)
        end
      end

      context "with 4 or more attributes" do
        let(:model) do
          Frontier::Model.new({
            test_model: {
              attributes: {
                delta: {type: "string"},
                charlie: {type: "string"},
                address: {type: "belongs_to", form_type: "select"},
                bravo: {type: "string"},
              }
            }
          })
        end

        let(:expected) do
          raw = <<-STRING
def test_model_params
  params.fetch(:test_model, {}).permit([
    :address_id,
    :bravo,
    :charlie,
    :delta
  ])
end
STRING
          raw.rstrip
        end

        it "renders the params on multiple lines" do
          should eq(expected)
        end
      end
    end

    context "a model with a nested association" do
      let(:model) do
        Frontier::Model.new({
          test_model: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              other_address: {
                class_name: "Address",
                type: "belongs_to",
                form_type: "inline",
                attributes: {
                  line_1: {type: "string"},
                  state: {type: "belongs_to", form_type: "select"}
                }
              }
            }
          }
        })
      end

      let(:expected) do
        raw = <<-STRING
def test_model_params
  params.fetch(:test_model, {}).permit([
    :address_id,
    {other_address_attributes: [:line_1, :state_id]}
  ])
end
STRING
        raw.rstrip
      end

      it "renders the params on multiple lines" do
        should eq(expected)
      end
    end

    context "a model with a deeply nested association" do
      let(:model) do
        Frontier::Model.new({
          test_model: {
            attributes: {
              address: {type: "belongs_to", form_type: "select"},
              other_address: {
                class_name: "Address",
                type: "belongs_to",
                form_type: "inline",
                attributes: {
                  line_1: {type: "string"},
                  state: {
                    type: "belongs_to",
                    form_type: "inline",
                    attributes: {
                      name: {type: "string"}
                    }
                  }
                }
              },
              name: {type: "string"},
            }
          }
        })
      end

      let(:expected) do
        raw = <<-STRING
def test_model_params
  params.fetch(:test_model, {}).permit([
    :address_id,
    :name,
    {other_address_attributes: [:line_1, {state_attributes: [:name]}]}
  ])
end
STRING
        raw.rstrip
      end

      it "renders the params on multiple lines" do
        should eq(expected)
      end
    end
  end

end
