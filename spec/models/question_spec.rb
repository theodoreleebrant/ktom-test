require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { described_class.new(
    problem: "valid problem",
    answer: "valid answer",
    contest_id: Contest.first.id,
    maximum_score: 1,
    question_number: 1
  ) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "has a maximum score" do
    subject.maximum_score = nil
    expect(subject).to_not be_valid
  end

  it "has a positive maximum score" do
    subject.maximum_score = -1
    expect(subject).to_not be_valid
  end

  it "has a problem" do
    subject.problem = nil
    expect(subject).to_not be_valid
  end

  it "has a answer" do
    subject.answer = nil
    expect(subject).to_not be_valid
  end
end
