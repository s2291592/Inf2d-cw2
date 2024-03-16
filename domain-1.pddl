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
    :parameters (?obj - weighable ?c - cell)
    :precondition (and (weighable_item ?obj) (holding ?obj) (weighing_scale ?c) (at ShopBot ?c))
    :effect (and (item_weighed ?obj))
  )

  (:action check_out
    :parameters (?obj - item ?c - cell)
    :precondition (and (at ?obj ?c) (checkout_stand ?c) (at ShopBot ?c) (not (holding ?obj)) (or (nonweighable ?obj) (and (weighable ?obj) (item_weighed ?obj))))
    :effect (and (item_checked_out ?obj))
  )
)










(define (domain supermarket)
  (:requirements :strips :typing)
  (:types
    cell item - object
    weighable nonweighable - item
  )

  (:predicates
    (aisle ?c - cell)
    (shelf ?c - cell)
    (weighing_scale ?c - cell)
    (checkout_stand ?c - cell)
    (connected ?c1 ?c2 - cell)
    (at ?obj - object ?c - cell)
    (holding ?obj - item)
    (weighable_item ?obj - weighable)
    (item_weighed ?obj - weighable)
    (item_checked_out ?obj - item)
  )

  (:action move
    :parameters (?from ?to - cell)
    :precondition (and (aisle ?from) (aisle ?to) (connected ?from ?to) (at ShopBot ?from))
    :effect (and (at ShopBot ?to) (not (at ShopBot ?from)))
  )

  (:action pick_up
    :parameters (?obj - item ?c - cell)
    :precondition (and (at ?obj ?c) (at ShopBot ?c) (not (holding ?obj)))
    :effect (and (holding ?obj) (not (at ?obj ?c)))
  )

  (:action drop
    :parameters (?obj - item ?c - cell)
    :precondition (and (holding ?obj) (at ShopBot ?c))
    :effect (and (not (holding ?obj)) (at ?obj ?c))
  )

  (:action weigh
    :parameters (?obj - weighable ?c - cell)
    :precondition (and (weighable_item ?obj) (holding ?obj) (weighing_scale ?c) (at ShopBot ?c))
    :effect (and (item_weighed ?obj))
  )

  (:action check_out
    :parameters (?obj - item ?c - cell)
    :precondition (and (at ?obj ?c) (checkout_stand ?c) (at ShopBot ?c) (not (holding ?obj)) (or (nonweighable ?obj) (and (weighable ?obj) (item_weighed ?obj))))
    :effect (and (item_checked_out ?obj))
  )
)
