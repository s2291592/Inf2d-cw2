(define (domain supermarket)

  (:requirements :adl)




  (:types 
  AisleCells shelves WeighingScale CheckoutStand - location
  position
  shopbot 
  ShoppingItem
  )





  (:predicates
      (at_item ?item - ShoppingItem ?pos - position) ;; ShoppingItem is at a position, and all at are positions
      (at_bot ?bot - shopbot ?pos - position)
      (at_location ?loc - location ?pos - position)
      (adjacent ?x ?y - position)
      (Clear ?ac - AisleCells)
      (holding ?bot - shopbot) ;; ShopBot is holding an item
      (hold ?bot - shopbot ?item - ShoppingItem) ;; hold the item
      (weighable ?item - ShoppingItem) ;; Item can be weighed
      (checked_out ?item - ShoppingItem) ;; Item has been checked out 
  )





  (:constants ShopBot - shopbot)





  (:action MOVE
      :parameters (?x - position ?y - position ?from - AisleCells ?to - AisleCells)
      :precondition (and (at_location ?from ?x) (at_location ?to ?y) (at_bot ShopBot ?x) (adjacent ?x ?y) (Clear ?to) (not (Clear ?from)) (not (= ?x ?y)) (not (= ?from ?to)))
      :effect (and (at_bot ShopBot ?y) (Clear ?from) (not (at_bot ShopBot ?x)) (not (Clear ?to)))
  )



  (:action pick_up
    :parameters (?item - ShoppingItem ?x - position ?y - position ?stand - AisleCells ?place - AisleCells)
    :precondition (and (at_bot ShopBot ?x) (at_location ?stand ?x) (at_item ?item ?y) (at_location ?place ?y) (not (Clear ?place)) (adjacent ?x ?y) (not (holding ShopBot)))
    :effect (and (holding ShopBot) (hold ShopBot ?item) (Clear ?place) (not (at_item ?item ?y)))
  )



  (:action pick_up_shelves
    :parameters (?item - ShoppingItem ?x - position ?y - position ?stand - AisleCells ?place - shelves)
    :precondition (and (at_bot ShopBot ?x) (at_location ?stand ?x) (at_item ?item ?y) (at_location ?place ?y) (adjacent ?x ?y) (not (holding ShopBot)))
    :effect (and (holding ShopBot) (hold ShopBot ?item))
  )



  (:action drop
    :parameters (?item - ShoppingItem ?x - position ?y - position ?stand - AisleCells ?place - AisleCells)
    :precondition (and (at_bot ShopBot ?x) (at_location ?stand ?x) (Clear ?place) (adjacent ?x ?y) (holding ShopBot) (hold ShopBot ?item))
    :effect (and (at_item ?item ?y) (at_bot ShopBot ?x) (not (holding ShopBot)) (not (Clear ?place)))
  )



  (:action weigh
    :parameters (?item - ShoppingItem ?x - position ?y -  position ?stand - AisleCells ?place - WeighingScale)
    :precondition (and (weighable ?item) (holding ShopBot) (hold ShopBot ?item) (at_bot ShopBot ?x) (at_location ?stand ?x) (at_location ?place ?y) (adjacent ?x ?y))
    :effect (and (at_item ?item ?y) (not(weighable ?item)))
  )



  (:action check_out
    :parameters (?item - ShoppingItem ?x - position ?y -  position ?stand - AisleCells ?place - CheckoutStand)
    :precondition (and (at_bot ShopBot ?x) (at_location ?stand ?x) (at_location ?place ?y) (adjacent ?x ?y) (holding ShopBot) (hold ShopBot ?item) (not(weighable ?item)))
    :effect (and (at_item ?item ?y) (checked_out ?item) (not(holding ShopBot)))
  )
)