require_relative 'dttp'
require_relative 'product_importer'

class ProductImportJob

  ENDPOINTS = {
    "Acme" => "dttp://current-catalog",
    "Toysco" => "dttp://our-toys",
    "Amazune" => "dttp://products-we-sell"
  }

  HEADERS = {

  }
  def run(suppliers)
    Product.all.clear
    suppliers.each do |supplier|
      endpoint = case supplier
      when "Acme"
        "dttp://current-catalog"
      when "Toysco"
        "dttp://our-toys"
      when "Amazune"
        "dttp://products-we-sell"
      end

      data = case supplier
      when "Acme", "Toysco"
        DTTP.get_csv(endpoint)
      when "Amazune"
        DTTP.get_json(endpoint)
      end

      importer = case supplier
      when "Acme"
        ProductCSVImporter.new(supplier: supplier)
      when "Toysco"
        ProductCSVImporter.new(supplier: supplier, delimiter: / *; */, headers: [:inventory, :name, :description, :cost])
      when "Amazune"
        ProductJSONImporter.new(supplier: supplier, keymap: {title: :name, body: :description})
      end

      importer.import(data)
    end
  end
end
