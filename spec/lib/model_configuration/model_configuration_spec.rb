require 'spec_helper'

describe ModelConfiguration do

  let(:configuration)   { ModelConfiguration.new(test_model_path) }
  let(:test_model_path) { File.join("spec", "support", "test_model.yaml") }

  describe "#as_constant" do
    subject { configuration.as_constant }
    it { should eq("TestModel") }
  end

  describe "#as_symbol" do
    subject { configuration.as_symbol }
    it { should eq(":test_model") }
  end

  describe "#as_symbol_collection" do
    subject { configuration.as_symbol_collection }
    it { should eq(":test_models") }
  end

  describe "#ivar_collection" do
    subject { configuration.ivar_collection }
    it { should eq("@test_models") }
  end

  describe "#ivar_instance" do
    subject { configuration.ivar_instance }
    it { should eq("@test_model") }
  end

end