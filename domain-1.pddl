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
      (Clear ?ac - AisleCells) ;; can move to there if clean
      (holding ?bot - shopbot) ;; ShopBot is holding an item
      (hold ?bot - shopbot ?item - ShoppingItem) ;; hold the item
      (weighable ?item - ShoppingItem) ;; Item can be weighed
      (checked_out ?item - ShoppingItem) ;; Item has been checked out 
  )





  (:constants ShopBot - shopbot)





  (:action MOVE
      :parameters (?from - AisleCells ?to - AisleCells)
      :precondition (and (at ShopBot ?from) (adjacent ?from ?to) (Clear ?to) (not (Clear ?from)))
      :effect (and (at ShopBot ?to) (Clear ?from) (not (at ShopBot ?from)) (not (Clear ?to)))
  )



  (:action pick_up_ac
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - AisleCells)
    :precondition (and (at ShopBot ?x) (at_item ?item ?y) (adjacent ?x ?y) (not (Clear ?y)) (not (holding ShopBot)))
    :effect (and (holding ShopBot) (hold ShopBot ?item) (Clear ?y) (not (at_item ?item ?y)))
  )



  (:action pick_up_shelves
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - shelves)
    :precondition (and (at ShopBot ?x) (at_item ?item ?y) (adjacent ?x ?y) (not (holding ShopBot)))
    :effect (and (holding ShopBot) (hold ShopBot ?item))
  )



  (:action drop
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - AisleCells)
    :precondition (and (at ShopBot ?x) (Clear ?y) (adjacent ?x ?y) (holding ShopBot) (hold ShopBot ?item))
    :effect (and (at_item ?item ?y) (at ShopBot ?x) (not (holding ShopBot)) (not (Clear ?y)))
  )



  (:action weigh
    :parameters (?item - ShoppingItem ?x - AisleCells ?y -  WeighingScale)
    :precondition (and (weighable ?item) (holding ShopBot) (hold ShopBot ?item) (at ShopBot ?x) (adjacent ?x ?y))
    :effect (and (not(weighable ?item)))
  )

  (:action puton_check
    :parameters (?item - ShoppingItem ?x - AisleCells ?y -  CheckoutStand)
    :precondition (and (at ShopBot ?x) (adjacent ?x ?y) (holding ShopBot) (hold ShopBot ?item) (not(weighable ?item)))
    :effect (and (at_item ?item ?y) (not(holding ShopBot)) (not (hold ShopBot ?item)))
  )

  (:action check_out
    :parameters (?item - ShoppingItem ?x - AisleCells ?y -  CheckoutStand)
    :precondition (and (at ShopBot ?x) (adjacent ?x ?y) (at_item ?item ?y) (not(holding ShopBot)))
    :effect (and (checked_out ?item))
  )
)