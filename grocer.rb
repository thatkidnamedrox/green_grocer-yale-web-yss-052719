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
     consolidated[name][:count] = cart.count{|food| food == item}
  end
  #puts cart, "", consolidated
  consolidated

end

def apply_coupons(cart, coupons)
  # code here
  #puts cart
  coupons_applied = {}
  #coupons_applied = cart.select
  coupon_items = coupons.map {|coupon| coupon[:item]}
  cart.each do |item, info|
    if !coupon_items.find{|k,v| k == item}
      coupons_applied[item] ||= {}
      coupons_applied[item][:price] = cart[item][:price]
      coupons_applied[item][:clearance] = cart[item][:clearance]
      coupons_applied[item][:count] = cart[item][:count]
    end
  end

  coupons.each do |coupon|
    item = coupon[:item]
    cart[item] ? nil : break

    item_coupon = "#{item} W/COUPON"

    coupons_applied[item_coupon] ||= {}
    coupons_applied[item_coupon][:price] = coupon[:cost]
    coupons_applied[item_coupon][:clearance] = cart[item][:clearance]
    coupons_applied[item_coupon][:count] ? nil : coupons_applied[item_coupon][:count] = 0
    coupons_applied[item_coupon][:count] += 1

    coupons_applied[item] ||= {}
    coupons_applied[item][:price] = cart[item][:price]
    coupons_applied[item][:clearance] = cart[item][:clearance]
    coupons_applied[item][:count] ? nil : coupons_applied[item][:count] = cart[item][:count]
    coupons_applied[item][:count] -= coupon[:num]
  end

  coupons_applied == {} ? cart : coupons_applied
end

def apply_clearance(cart)
  # code here
  discount = 0.2
  clearance_applied = {}
  cart.each do |item, info|
    clearance_applied[item] = {}
    clearance_applied[item][:price] = info[:price]
    clearance_applied[item][:clearance] = info[:clearance]
    clearance_applied[item][:count] = info[:count]

    info[:clearance] ? clearance_applied[item][:price] *= (1.0 - discount) : nil
    clearance_applied[item][:price] = clearance_applied[item][:price].round(1)
  end
  #puts clearance_applied, "", cart
  clearance_applied
end

def checkout(cart, coupons)
  # code here
  #puts "CART", cart, ""
  #puts "COUPONS"  + "\n\t" + coupons.inspect
  consolidated = consolidate_cart(cart)
  #puts "", cart, "", consolidated
  #puts "CONSOLIDATED", consolidated, ""
  #puts "CONSOLIDATED"  + "\n\t" + consolidated.inspect
  # # # #puts consolidated.inspect
  coupons_applied = apply_coupons(consolidated, coupons)
  # puts "COUPONS_APPLIED" + "\n\t" + coupons_applied.inspect
  # # # #puts consolidated.inspect
  clearance_applied = apply_clearance(coupons_applied)
  # puts "CLEARANCE_APPLIED" + "\n\t" + clearance_applied.inspect
  #
  total = 0.0
  clearance_applied.each {|item, info| total += info[:price] * info[:count]}
  total
end
