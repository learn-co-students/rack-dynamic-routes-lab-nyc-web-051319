class Application

  @@items = [Item.new("Apples", 3.42), Item.new("Pears", 10), Item.new("Candy", 5)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)

      search_item = req.path.split("/items/").last

      item_in_cart = @@items.find do |item|
        item.name == search_item
      end

      if item_in_cart
        resp.write item_in_cart.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

end
