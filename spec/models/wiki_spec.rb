require 'rails_helper'
include RandomData

RSpec.describe Wiki, type: :model do

  let(:user)  { create(:user) }
  let(:wiki)  { create(:wiki) }

  it {should belong_to(:user)}

  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:body)}
  it {should validate_presence_of(:user)}

  it {should validate_length_of(:title).is_at_least(5)}
  it {should validate_length_of(:body).is_at_least(20)}

  describe "attributes" do

    it "should respond to title" do
      expect(post).to respond_to(:title)
    end

    it "should respond to body" do
      expect(post).to respond_to(:body)
    end
  end

end
