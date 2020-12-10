require 'rails_helper'

RSpec.describe Productreview, :type => :model do
  let(:valid_attributes) do
    {
      content: "Nice product",
      rating: 5,
      user_id: user.id,
      product_id: product.id
    }
  end

  let(:user) do
    User.create!(
      email: "test@rspec.be",
      password: "123456"
    )
  end

  let(:address) do
    Address.create!(
      street: "Rue Laurent Delvaux",
      number: "39",
      postcode: "1400",
      city: "Nivelles"
    )
  end

  let(:shop) do
    Shop.create!(
      name: "Shop Test",
      description: "Shop 1 - Test description for test shop",
      vat_number: "BE1234567891",
      address_id: address.id,
      user_id: user.id
    )
  end

  let(:category) do
    Category.create!(name: "food")
  end

  let(:product) do
    Product.create!(
      name: "Product Test",
      description: "Product 1 - Test description for test product",
      price_cents: 2000,
      ean: "123456789",
      stock: 3,
      tax: 21,
      shop_id: shop.id,
      category_id: category.id
    )
  end

  let(:product_review) do
    Productreview.create!(valid_attributes)
  end

  describe '.create' do
    it 'should be invalid if no content' do
      attributes = valid_attributes
      attributes.delete(:content)
      review = Productreview.new(attributes)
      expect(review).not_to be_valid
    end
    it 'should be invalid if the content is smaller than 5 characters' do
      attributes = valid_attributes
      attributes[:content] = "test"
      review = Productreview.new(attributes)
      expect(review).not_to be_valid
    end
    it 'should be invalid if no rating' do
      attributes = valid_attributes
      attributes.delete(:rating)
      review = Productreview.new(attributes)
      expect(review).not_to be_valid
    end
    it "rating should be a number between 0 and 5" do
      attributes = valid_attributes
      (0..5).each do |rating|
        attributes[:rating] = rating
        review = Productreview.new(attributes)
        expect(review).to be_valid
      end

      expect(Productreview.new(attributes.merge(rating: -1))).not_to be_valid
      expect(Productreview.new(attributes.merge(rating: 6))).not_to be_valid
    end
    it "parent product cannot be nil" do
      attributes = valid_attributes
      attributes.delete(:product_id)
      review = Productreview.new(attributes)
      expect(review).not_to be_valid
    end
    it "parent user cannot be nil" do
      attributes = valid_attributes
      attributes.delete(:user_id)
      review = Productreview.new(attributes)
      expect(review).not_to be_valid
    end
    it "rating should be an integer" do
      attributes = valid_attributes
      attributes[:rating] = "five"
      review = Productreview.new(attributes)
      expect(review).not_to be_valid
    end
  end

  describe '#content' do
    it 'should display the content of the product review' do
      expect(product_review.content).to eq("Nice product")
    end
  end

  describe '#rating' do
    it 'should display the rating of the product review' do
      expect(product_review.rating).to eq(5)
    end
  end

  describe '#user' do
    it 'should return the user who wrote the review' do
      expect(product_review.user).to eq(user)
    end
  end

  describe '#product' do
    it 'should return the product of the review' do
      expect(product_review.product).to eq(product)
    end
  end
end
