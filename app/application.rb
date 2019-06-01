class Application

  @@items = [Item.new("Apples",20.00), Item.new("Oranges",30.00)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
        if found_item = @@items.find {|item| item.name == item_name}
          resp.write found_item.price
        else
          resp.status = 400
          resp.write "Item not found"
        end
    else
      resp.status = 404
      resp.write "Route not found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
