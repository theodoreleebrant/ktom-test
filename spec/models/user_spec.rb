require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(
      email: "newtest@e.mail",
      name: "test name 2",
      password: "test password",
      password_confirmation: "test password"
    )
  }

  it "is valid with valid inputs" do
    expect(subject).to be_valid
  end

  it "is not valid without name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without valid email" do
    subject.email = "invalid email"
    expect(subject).to_not be_valid
  end
end
