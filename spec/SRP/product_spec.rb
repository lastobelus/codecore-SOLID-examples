require 'product'

require 'product'
require 'product_importer'

RSpec.describe Product, 'initialization' do
  before(:each) do
    Product.all.clear
  end

  it "initializes from args" do
    product = Product.new(
      name: "name",
      description: "desc",
      cost: 1.5,
      inventory: 100
    )
    expect(product.name).to eq("name")
    expect(product.description).to eq("desc")
    expect(product.cost).to eq(1.5)
    expect(product.inventory).to eq(100)
  end
end

RSpec.describe Product, '#create' do
  before(:each) do
    Product.all.clear
  end

  it "adds product to collection" do
    product = Product.new(
      name: "name",
      description: "desc",
      cost: 1.5,
      inventory: 100
    )
    expect {
      product.create
    }.to change{ Product.all.count }.by(1)
    expect(Product.all.last.name).to eq("name")
  end
end