require 'rails_helper'
require 'rake'

describe "training_data:import" do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/tasks/respondents" }
  let(:json_file) { "https://gist.githubusercontent.com/kconarro14/52f2f6d497817f430b7e/raw/0ab05fd8c126663ea88dc6fa4af901bfac46cdd8/gender_classifier_training_data.json"}
  subject         { rake[task_name] }

  def loaded_files_excluding_current_rake_file
    $".reject {|file| file == Rails.root.join("#{task_path}.rake").to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [Rails.root.to_s], loaded_files_excluding_current_rake_file)

    Rake::Task.define_task(:environment)
    Respondent.destroy_all

    allow(STDOUT).to receive(:puts)
    allow(STDIN).to receive(:gets).and_return(json_file)
  end

  it "reads JSON file" do
    subject.invoke
    json = JSON.parse(HTTParty.get(json_file))
    expect(Respondent.first.weight).to eq(json["people"].first["person"]["weight"].round)
    expect(Respondent.first.gender).to eq(json["people"].first["person"]["gender"].downcase)
    expect(Respondent.first.height).to eq(json["people"].first["person"]["height"].round)
  end

  it "raises count on Respondent table" do
    subject.invoke
    expect(Respondent.count).to_not eq(0)
  end

  it "does not raise an exception" do
    expect{subject.invoke}.to_not raise_error
  end
end
