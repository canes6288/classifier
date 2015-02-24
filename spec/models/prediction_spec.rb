require 'rails_helper'


describe Prediction do
  before { @prediction = Prediction.new(height: "6", weight: "130") }

  subject { @prediction }

  it { should respond_to(:height) }
  it { should respond_to(:weight) }

  it { should be_valid }

  describe '#set_gender' do
    let(:male)   { Prediction.new(height: 6, weight: 191) }
    let(:female) { Prediction.new(height: 5, weight: 130) }

    context 'male data' do
      it 'returns male' do
        male.save
        expect(male.gender).to eq('male')
      end
    end

    context 'female data' do
      it 'returns female' do
        female.save
        expect(female.gender).to eq('female')
      end
    end
  end

  describe '#male_classifier' do
    let(:classifier)   { @prediction.male_classifier }
    subject { classifier }
    it { should be_a(Classifier) }
  end

  describe '#female_classifier' do
    let(:classifier)   { @prediction.female_classifier }
    subject { classifier }
    it { should be_a(Classifier) }
  end


  describe "validations" do
    describe "height" do
      context "not present" do
        before { @prediction.height = "" }
        it { should_not be_valid }
      end

      context "includes letters" do
        before { @prediction.height = "yeehaw" }
        it { should_not be_valid }
      end

      context "includes symbols" do
        before { @prediction.height = "$$@@^^26%$()*(#!}" }
        it {should_not be_valid }
      end

      context "less than or equal to 0" do
        before { @prediction.height = "-20" }
        it { should_not be_valid }
      end
    end

    describe "weight" do
      context "not present" do
        before { @prediction.weight = "" }
        it { should_not be_valid }
      end

      context "includes letters" do
        before { @prediction.weight = "hurricanes" }
        it { should_not be_valid }
      end

      context "includes symbols" do
        before { @prediction.weight = "$%!@##$)(*33&&^%$!@~~)}}"}
        it { should_not be_valid }
      end

      context "less than or equal to 0" do
        before { @prediction.height = "-20" }
        it { should_not be_valid }
      end
    end
  end
end

