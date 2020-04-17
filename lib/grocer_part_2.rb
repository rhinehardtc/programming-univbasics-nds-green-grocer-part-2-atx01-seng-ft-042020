require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  
  coupon_items = []
  coupons.each do |object|
    coupon_items << object[:item]
  end
  pp coupon_items
  #-----------------------------------------------#
  
  cart.each do |object|
    if coupon_items.include?(object[:item]) == true
      new_object = object
      new_object[:item] = new_object[:item] + " W/COUPON"
      
    end
    pp new_object
  end
  #-----------------------------------------------#
  i = 0
  while i < cart.length do
    ci = 0
    while ci < coupons.length do
      
      if cart[i][:item].include?(coupons[ci][:item]) == true
        cart[i][:count] = coupons[ci][:num]
        cart[i][:price] = (coupons[ci][:cost] / coupons[ci][:num]).round(2)
      end
      ci += 1
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
