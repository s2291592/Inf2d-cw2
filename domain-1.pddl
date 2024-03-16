(define (domain supermarket)

  (:requirements :adl)

  (:types 
  AisleCells shelves WeighingScale CheckoutStand - location 
  ShopBot ShoppingItem - object)

  ;; Predicates
  (:predicates
      (at ?obj - object ?loc - location) ;; Object is at a location
      (holding ?bot - ShopBot ?item - ShoppingItem) ;; ShopBot is holding an item
      (weighable ?item - ShoppingItem) ;; Item can be weighed
      (weighed ?item - ShoppingItem) ;; Item has been weighed
      (checked_out ?item - ShoppingItem) ;; Item has been checked out
  )

  (:constants Table - table)

  (:action MOVE
      :parameters (?x - AisleCells ?y - AisleCells)
      :precondition (and (at ShopBot ?x) (adjacent ?x ?y) (Clear ?y) (not (Clear ?x)) (not (= ?x ?y)))
      :effect (and (at ShopBot ?y) (Clear ?x) (not (at ShopBot ?x)) (not (Clear ?y)))
  )

  (:action pick_up
    :parameters (?obj - ShoppingItem ?x - AisleCells ?y - location)
    :precondition (and (at ShopBot ?x) (at ?obj ?y) (adjacent ?x ?y) (not (holding ShopBot)))
    :effect (and (holding ShopBot) (hold ShopBot ?obj) (not (at ?obj ?y)))
  )

  (:action drop
    :parameters (?obj - item ?x - AisleCells ?y - AisleCells)
    :precondition (and (at ShopBot ?x) (Clear ?y) (adjacent ?x ?y) (holding ShopBot) (hold ShopBot ?obj))
    :effect (and (at ?obj ?y) (at ShopBot ?x) (not (holding ShopBot)) (not (Clear ?y)))
  )

  (:action weigh
    :parameters (?obj - ShoppingItem ?x - AisleCells ?y - WeighingScale)
    :precondition (and (weighable ?obj) (holding ShopBot) (hold ShopBot ?obj) (at ShopBot ?x) (weighing_scale ?y) (adjacent ?x ?y))
    :effect (and (item_weighed ?obj) (not(weighable ?obj)))
  )

  (:action check_out
    :parameters (?obj - ShoppingItem ?x - AisleCells ?c - CheckoutStand)
    :precondition (and (at ShopBot ?x) (checkout_stand ?c) (at ?obj ?c) (not(holding ShopBot)) (not(weighable ?obj)))
    :effect (and (checked_out ?obj) (at ?obj ?c))
  )
)