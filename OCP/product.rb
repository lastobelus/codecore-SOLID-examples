require 'awesome_print'
require_relative 'product_import_job'

class Product
  attr_accessor :name, :description, :cost, :inventory, :supplier

  def self.all
    @all ||= []
  end

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @cost = args[:cost]
    @inventory = args[:inventory] || 0
    @supplier = args[:supplier]
  end

  def create
    Product.all << self
  end

  def price
    cost * 2
  end

  def order(qty)
    if inventory >= qty
      inventory -= qty
      true
    else
      false
    end
  end

  def resupply(qty)
    inventory += qty
  end

  def header
    <<-eos.gsub(/^ {6}/, '')
      <div class="product-header">
        <h1>#{@name}</h1>
        <p>#{@description}<p>
      </div>
    eos
  end
end


if __FILE__ == $0
  import_job = ProductImportJob.new
  suppliers = ["Acme", "Toysco", "Amazune"]

  import_job.run(suppliers)

  puts "All Products:"
  ap Product.all
end
