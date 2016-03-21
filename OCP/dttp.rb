module DTTP
  class << self
    def get_csv(endpoint)
      case endpoint
      when "dttp://current-catalog"
        <<-eos.gsub(/^ {10}/, '')
          mop, a tool for cleaning, 4.00, 100
          shiny tool, a tool for playing, 2.00, 200
        eos
      when "dttp://our-toys"
        <<-eos.gsub(/^ {10}/, '')
          100; truck; the coolest truck ever; 5.00
          200; plane; it flies! it lands!; 5.00
        eos
      end
    end

    def get_json(endpoint)
      case endpoint
      when "dttp://products-we-sell"
        <<-eos.gsub(/^ {10}/, '')
          {
            "products":
            [
              {
                "title": "The Little Prince",
                "body": "a book for kids that only makes sense when you're old!",
                "cost": 10.00,
                "inventory": 100
              },
              {
                "title": "Catch-22",
                "body": "10 million copies sold!",
                "cost": 10.00,
                "inventory": 100
              }
            ]
          }
          eos
      end
    end
  end
end