def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs

  item = nil

  collection.each { |element|
    if element[:item] == name
      item = element
    end
   }

  item
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []

  cart.each { |element|

    new_item = find_item_by_name_in_collection(element[:item], new_cart)

    if new_item
      new_item[:count] +=1
    else
      element[:count] = 1
      new_cart << element
    end
   }

  new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each { |item_with_coupon|
    found_item = find_item_by_name_in_collection(item_with_coupon[:item], cart)
    couponed_item_name = "#{item_with_coupon[:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)

    if found_item && found_item[:count] >= item_with_coupon[:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += item_with_coupon[:num]
        found_item[:count] -= item_with_coupon[:num]
      else
        cart_item_with_coupon = {
            item: couponed_item_name,
            count: item_with_coupon[:num],
            price: item_with_coupon[:cost] / item_with_coupon[:num],
            clearance: found_item[:clearance]
        }
        cart << cart_item_with_coupon
        found_item[:count] -= item_with_coupon[:num]
      end
    end
  }

 cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  cart.each { |item|
    if item[:clearance]
      item[:price] -= (item[:price] * 0.2).round(2)
    end
   }
   cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0

  consolidate_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(consolidate_cart, coupons)
  final_cart = apply_clearance(cart_with_coupons_applied)

  final_cart.each { |element|

    total+= element[:price] * element[:count]
    }

  total > 100 ? total -= (total * 0.1).round : total
end
