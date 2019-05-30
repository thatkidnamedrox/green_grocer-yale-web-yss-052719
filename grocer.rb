def consolidate_cart(cart)
  # code here

  items = cart.uniq
  consolidated = {}
  items.map do |item|
     name = item.keys.first
     info = item.values.first
     consolidated[name] = {}
     consolidated[name][:price] = info[:price]
     consolidated[name][:clearance] = info[:clearance]
     consolidated[name][:count] = cart.count(item)
  end
  consolidated

end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    item = coupon[:item]
    cart[item] ? nil : break
    cart[item][:count] -= coupon[:num]

    new_item = item + " W/COUPON"
    cart[new_item] ? nil : cart[new_item] = {}
    cart[new_item][:price] = coupon[:cost]
    cart[new_item][:clearance] = cart[item][:clearance]
    if cart[new_item][:count]
      cart[new_item][:count] += 1
    else
      cart[new_item][:count] = 1
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  discount = 0.2
  cart.each do |item, info|
    #puts info.inspect
    info[:clearance] ? info[:price] *= (1.0 - discount) : nil
    info[:price] = info[:price].round(1)
  end
end

def checkout(cart, coupons)
  # code here
  puts "CART" + "\n\t" + cart.inspect
  puts "COUPONS"  + "\n\t" + coupons.inspect
  consolidated = consolidate_cart(cart)
  puts "CONSOLIDATED"  + "\n\t" + consolidated.inspect
  # # # #puts consolidated.inspect
  # coupons_applied = apply_coupons(consolidated, coupons)
  # puts "COUPONS_APPLIED" + "\n\t" + coupons_applied.inspect
  # # # #puts consolidated.inspect
  # clearance_applied = apply_clearance(coupons_applied)
  # puts "CLEARANCE_APPLIED" + "\n\t" + clearance_applied.inspect
  #
  # total = 0.0
  # clearance_applied.each {|item, info| total += info[:price]}
  # total
end
