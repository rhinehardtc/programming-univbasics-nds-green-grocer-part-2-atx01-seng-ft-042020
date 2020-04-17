require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  i = 0
  coupons.each do |coupon|
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_is_in_basket = !!item_with_coupon
    count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]
    if item_is_in_basket and count_is_big_enough_to_apply
      cart << { item: "#{item_with_coupon[:item]} W/COUPON", 
                price: coupon[:cost] / coupon[:num], 
                clearance: item_with_coupon[:clearance],
                count: coupon[:num]
              }
      item_with_coupon[:count] -= coupon[:num]
    end
    i += 1
  end
  cart
end

##

def apply_clearance(cart)
  cart.each do |object|
    object[:price] = (object[:price] * 0.8).round(2) if object[:clearance] == true
  end
end

##

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  #-----------------------------------------------#
  total = 0
  cart.each do |object|
    total += object[:price] * object[:count]
  end
  
  total = total * 0.9 if total >= 100
  total
end
