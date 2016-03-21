require 'product'

RSpec.describe Product, '.import_products' do
  context "a csv list of products" do
    let(:csv){
      <<-eos.gsub(/^ {8}/, '')
        name1, desc1, 1.5, 100
        name2, desc2, 2.5, 200
        name3, desc3, 3.5, 300
      eos
    }

    subject{ Product.import_products(csv) }

    it "creates a product for each row" do
      subject
      expect(Product.all.count).to eq 3
    end

    it "gets the fields in the right place" do
      subject
      expect(Product.all.first.name).to eq("name1")
      expect(Product.all.first.description).to eq("desc1")
      expect(Product.all.first.cost).to eq(1.5)
      expect(Product.all.first.inventory).to eq(100)
    end

    it "converts inventory to an integer" do
      subject
      expect(Product.all.first.inventory).to be_a(Integer)
    end

    it "converts cost to a float" do
      subject
      expect(Product.all.first.cost).to be_a(Float)
    end
  end
end