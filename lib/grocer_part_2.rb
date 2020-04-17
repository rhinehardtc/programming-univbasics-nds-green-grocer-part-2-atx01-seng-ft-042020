require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupons.each do |object|
    has_coupon = find_item_by_name_in_collection(object[:item], cart)
  
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
