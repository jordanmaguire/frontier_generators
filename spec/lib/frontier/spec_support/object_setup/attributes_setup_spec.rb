require 'spec_helper'

RSpec.describe Frontier::SpecSupport::ObjectSetup::AttributesSetup do

  describe "#to_s" do
    subject { Frontier::SpecSupport::ObjectSetup::AttributesSetup.new(model_configuration).to_s }

    context "with no associations" do
      let(:model_configuration) do
        Frontier::ModelConfiguration.new({
          model_name: {
            attributes: {
              name: {type: "string"},
            }
          }
        })
      end

      it { should eq("let(:model_name_attributes) { FactoryGirl.attributes_for(:model_name) }") }
    end

    context "with associations" do
      let(:model_configuration) do
        Frontier::ModelConfiguration.new({
          model_name: {
            attributes: {
              address: {type: "belongs_to", form_type: form_type},
              name: {type: "string"},
            }
          }
        })
      end

      context "without nested attributes" do
        let(:form_type) { "select" }
        it { should eq("let(:model_name_attributes) { FactoryGirl.attributes_for(:model_name) }") }
      end

      context "with nested attributes" do
        let(:form_type) { "inline" }
        let(:expected) do
          raw = <<STRING
let(:model_name_attributes) { FactoryGirl.attributes_for(:model_name) }
let(:address_attributes) { FactoryGirl.attributes_for(:address) }
STRING
          raw.rstrip
        end

        it { should eq(expected) }
      end
    end

  end

end
