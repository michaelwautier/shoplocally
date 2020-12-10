require 'rails_helper'

RSpec.describe Shopreview, :type => :model do
  before(:all) do
    @user = User.create!(
      email: "test@rspec.be",
      password: "123456"
    )

    @address = Address.create!(
      street: "Rue Laurent Delvaux",
      number: "39",
      postcode: "1400",
      city: "Nivelles"
    )

    @shop = Shop.create!(
      name: "Shop Test",
      description: "Shop 1 - Test description for test shop",
      vat_number: "BE1234567891",
      address_id: @address.id,
      user_id: @user.id
    )
  end

  after(:all) do
    Shopreview.destroy_all
    Shop.destroy_all
    Address.destroy_all
    User.destroy_all
  end

  let(:valid_attributes) do
    {
      content: "Nice shop",
      rating: 5,
      user_id: @user.id,
      shop_id: @shop.id
    }
  end

  let(:shop_review) do
    Shopreview.create!(valid_attributes)
  end

  describe '.create' do
    it 'should be invalid if no content' do
      attributes = valid_attributes
      attributes.delete(:content)
      review = Shopreview.new(attributes)
      expect(review).not_to be_valid
    end
    it 'should be invalid if the content is smaller than 5 characters' do
      attributes = valid_attributes
      attributes[:content] = "test"
      review = Shopreview.new(attributes)
      expect(review).not_to be_valid
    end
    it 'should be invalid if no rating' do
      attributes = valid_attributes
      attributes.delete(:rating)
      review = Shopreview.new(attributes)
      expect(review).not_to be_valid
    end
    it "rating should be a number between 0 and 5" do
      attributes = valid_attributes
      (0..5).each do |rating|
        attributes[:rating] = rating
        review = Shopreview.new(attributes)
        expect(review).to be_valid
      end

      expect(Shopreview.new(attributes.merge(rating: -1))).not_to be_valid
      expect(Shopreview.new(attributes.merge(rating: 6))).not_to be_valid
    end
    it "parent shop cannot be nil" do
      attributes = valid_attributes
      attributes.delete(:shop_id)
      review = Shopreview.new(attributes)
      expect(review).not_to be_valid
    end
    it "parent user cannot be nil" do
      attributes = valid_attributes
      attributes.delete(:user_id)
      review = Shopreview.new(attributes)
      expect(review).not_to be_valid
    end
    it "rating should be an integer" do
      attributes = valid_attributes
      attributes[:rating] = "five"
      review = Shopreview.new(attributes)
      expect(review).not_to be_valid
    end
  end

  describe '#content' do
    it 'should display the content of the shop review' do
      expect(shop_review.content).to eq("Nice shop")
    end
  end

  describe '#rating' do
    it 'should display the rating of the shop review' do
      expect(shop_review.rating).to eq(5)
    end
  end

  describe '#user' do
    it 'should return the user who wrote the review' do
      expect(shop_review.user).to eq(@user)
    end
  end

  describe '#shop' do
    it 'should return the shop of the review' do
      expect(shop_review.shop).to eq(@shop)
    end
  end
end
