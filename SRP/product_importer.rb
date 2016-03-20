class ProductImporter

  def import_products(csv)
    csv.each_line do |product_line|
      columns = product_line.chomp.split(/ *, */)
      columns[2] = columns[2].to_f
      columns[3] = columns[3].to_i
      Product.all << Product.new(columns)
    end
  end

end
