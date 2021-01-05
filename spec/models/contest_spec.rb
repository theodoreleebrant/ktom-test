require 'rails_helper'

RSpec.describe Contest, type: :model do
  it "is not valid without a name" do
    contest = Contest.new(name: nil)
    expect(contest).to_not be_valid
  end
end
