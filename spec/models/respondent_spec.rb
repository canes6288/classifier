require 'rails_helper'


describe Respondent do
  before { @all_respondents = Respondent.all }
  before { @respondent = Respondent.new(gender: "female", height: "5", weight: "110") }

  subject { @respondent }

  it { should respond_to(:gender) }
  it { should respond_to(:height) }
  it { should respond_to(:weight) }

  it { should be_valid }

  describe "retrieve metrics" do
    context "height" do
      it "returns heights array" do
        expect(@all_respondents.heights).to match_array([6,6,5,5,5,6,5,5])
      end
    end

    context "weight" do
      it "returns weights array" do
        expect(@all_respondents.weights).to match_array([180,180,130,150,150,100,190,165])
      end
    end

    context "sum height" do
      it "returns sum of heights as number" do
        expect(@all_respondents.sum_height).to be_eql(43.0)
      end
    end

    context "sum weight" do
      it "returns sum of weights as number" do
        expect(@all_respondents.sum_weight).to be_eql(1245.0)
      end
    end

    context "mean height" do
      it "returns mean of heights as number" do
        expect(@all_respondents.mean_height).to be_eql(5.375)
      end
    end

    context "mean weight" do
      it "returns mean of weights as number" do
        expect(@all_respondents.mean_weight).to be_eql(155.625)
      end
    end

    context "variance height" do
      it "returns variance of heights as number" do
        expect(@all_respondents.variance_height).to be_eql(0.26785714285714285)
      end
    end

    context "variance weight" do
      it "returns variance of weights as number" do
        expect(@all_respondents.variance_weight).to be_eql(895.9821428571429)
      end
    end
  end




  describe "validations" do
    describe "height" do
      context "not present" do
        before { @respondent.height = "" }
        it { should_not be_valid }
      end

      context "includes letters" do
        before { @respondent.height = "yessir" }
        it { should_not be_valid }
      end

      context "includes symbols" do
        before { @respondent.height = "$$@@^^26%$()*(#!}" }
        it {should_not be_valid }
      end

      context "less than or equal to 0" do
        before { @respondent.height = "-20" }
        it { should_not be_valid }
      end
    end

    describe "weight" do
      context "not present" do
        before { @respondent.weight = "" }
        it { should_not be_valid }
      end

      context "includes letters" do
        before { @respondent.weight = "hurricanes" }
        it { should_not be_valid }
      end

      context "includes symbols" do
        before { @respondent.weight = "$%!@##$)(*33&&^%$!@~~)}}"}
        it { should_not be_valid }
      end

      context "less than or equal to 0" do
        before { @respondent.height = "-20" }
        it { should_not be_valid }
      end
    end
  end
end


