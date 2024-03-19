(define (domain supermarket)

  (:requirements :adl)




  (:types 
  AisleCells shelves WeighingScale CheckoutStand - location
  shopbot 
  ShoppingItem
  )





  (:predicates
      (at_item ?item - ShoppingItem ?loc - location) ;; ShoppingItem is at a location: shelf or aisle cell
      (at ?bot - shopbot ?ac - AisleCells)
      (adjacent ?x - AisleCells ?y - location) ;; adjacent AisleCells or shelf 
      (holding ?bot - shopbot) ;; ShopBot is holding an item
      (hold ?bot - shopbot ?item - ShoppingItem) ;; hold the item
      (weighable ?item - ShoppingItem) ;; Item can be weighed
      (checked_out ?item - ShoppingItem) ;; Item has been checked out 
  )





  (:constants ShopBot - shopbot)





  (:action MOVE
      :parameters (?from - AisleCells ?to - AisleCells)
      :precondition (and (at ShopBot ?from) (adjacent ?from ?to))
      :effect (and (at ShopBot ?to) (not (at ShopBot ?from)))
  )



  (:action pick_up
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location)
    :precondition (and (at ShopBot ?x) (at_item ?item ?y) (adjacent ?x ?y) (not (holding ShopBot)))
    :effect (and (holding ShopBot) (hold ShopBot ?item) (not (at_item ?item ?y)))
  )



  (:action drop
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location)
    :precondition (and (at ShopBot ?x) (adjacent ?x ?y) (holding ShopBot) (hold ShopBot ?item))
    :effect (and (at_item ?item ?y) (at ShopBot ?x) (not (holding ShopBot)))
  )



  (:action weigh
    :parameters (?item - ShoppingItem ?x - AisleCells)
    :precondition (and (weighable ?item) (holding ShopBot) (hold ShopBot ?item) (at ShopBot ?x) (adjacent ?x WeighingScale))
    :effect (and (not(weighable ?item)))
  )

  (:action check_out
    :parameters (?item - ShoppingItem ?x - AisleCells)
    :precondition (and (at ShopBot ?x) (adjacent ?x CheckoutStand) (at_item ?item CheckoutStand) (not(holding ShopBot)))
    :effect (and (checked_out ?item))
  )
)