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
  coupons_applied = {}
  coupons_applied = coupons_applied.merge(cart)
  coupons.each do |coupon|
    item = coupon[:item]
    cart[item] ? nil : break

    item_coupon = "#{item} W/COUPON"
    info = cart[item]

    coupons_applied[item_coupon] ? nil : coupons_applied[item_coupon] = {}
    coupons_applied[item_coupon][:price] = coupon[:cost]
    coupons_applied[item_coupon][:clearance] = cart[item][:clearance]
    coupons_applied[item_coupon][:count] ? coupons_applied[item_coupon][:count] += 1 : coupons_applied[item_coupon][:count] = 1

    coupons_applied[item][:count] = cart[item][:count] - coupon[:num]
    coupons_applied[item][:count].clamp(0.._)
  end
  puts coupons_applied
  coupons_applied
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
