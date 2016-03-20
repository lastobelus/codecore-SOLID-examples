require 'product'

require 'product'
require 'product_importer'

RSpec.describe Product, 'creation' do
  before(:each) do
    Product.all.clear
  end

  it "initializes from args" do
    product = Product.new( "name", "desc", 1.5, 100
    )
    expect(product.name).to eq("name")
    expect(product.description).to eq("desc")
    expect(product.cost).to eq(1.5)
    expect(product.inventory).to eq(100)
  end
end
