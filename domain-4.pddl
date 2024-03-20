(define (domain supermarket)

  (:requirements :adl)




  (:types 
  AisleCells shelves WeighingScale CheckoutStand BasketPlace AddCredit - location
  basket
  shopbot 
  ShoppingItem
  )





  (:predicates
      (at_item ?item - ShoppingItem ?loc - location) ;; ShoppingItem is at a location: shelf or aisle cell
      (at ?bot - shopbot ?ac - AisleCells)
      (adjacent ?x - AisleCells ?y - location) ;; adjacent AisleCells or shelf 
      (holding ?bot - shopbot) ;; ?bot is holding an item
      (hold_basket ?bot - shopbot)
      (hold ?bot - shopbot ?item - ShoppingItem) ;; hold the item
      (hold_in  ?bot - shopbot ?item - ShoppingItem)
      (weighable ?item - ShoppingItem) ;; Item can be weighed
      (checked_out ?item - ShoppingItem ?bot - shopbot) ;; Item has been checked out 
  )

  (:functions
      (balance ?bot - shopbot) ; bot credit
      (price ?item - ShoppingItem) ; price of item
  )










  (:action MOVE
      :parameters (?from - AisleCells ?to - AisleCells ?bot - shopbot)
      :precondition (and (at ?bot ?from) (adjacent ?from ?to) (clear ?to) (not (clear ?from)))
      :effect (and (at ?bot ?to) (not (at ?bot ?from)) (clear ?from) (not (clear ?to)))
  )

  (:action top_up
      :parameters (?x - AisleCells ?bot - shopbot)
      :precondition (and (at ?bot ?x) (adjacent ?x AddCredit))
      :effect (and (increase (balance ?bot) 5))
  )

  (:action pick_up
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location ?bot - shopbot)
    :precondition (and (at ?bot ?x) (at_item ?item ?y) (adjacent ?x ?y) (not (holding ?bot)))
    :effect (and (holding ?bot) (hold ?bot ?item) (not (at_item ?item ?y)))
  )



  (:action drop
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location ?bot - shopbot)
    :precondition (and (at ?bot ?x) (adjacent ?x ?y) (holding ?bot) (hold ?bot ?item))
    :effect (and (at_item ?item ?y) (at ?bot ?x) (not (holding ?bot)) (not (hold ?bot ?item)))
  )


  (:action use_basket
    :parameters (?x - AisleCells ?bot - shopbot)
    :precondition (and (at ?bot ?x) (adjacent ?x BasketPlace) (not (holding ?bot)))
    :effect (and (holding ?bot) (hold_basket ?bot))
  )

  (:action pick_up_with_basket
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location ?bot - shopbot)
    :precondition (and (at ?bot ?x) (holding ?bot) (hold_basket ?bot) (at_item ?item ?y) (adjacent ?x ?y))
    :effect (and (hold_in ?bot ?item) (not (at_item ?item ?y)))
  )  

  (:action drop_basket_check
    :parameters (?x - AisleCells ?bot - shopbot ?item - ShoppingItem)
    :precondition (and (at ?bot ?x) (hold_basket ?bot) (adjacent ?x CheckoutStand) (hold_in ?bot ?item))
    :effect (and (at_item ?item CheckoutStand) (not (hold_in ?bot ?item)))
  ) 



  (:action return_basket
    :parameters (?x - AisleCells ?bot - shopbot)
    :precondition (and (at ?bot ?x) (adjacent ?x CheckoutStand) (hold_basket ?bot))
    :effect (and (not (hold_basket ?bot)) (not(holding ?bot)))
  ) 



  (:action weigh
    :parameters (?item - ShoppingItem ?x - AisleCells ?bot - shopbot)
    :precondition (and (weighable ?item) (holding ?bot)  (at ?bot ?x) (adjacent ?x WeighingScale) (or (hold_in ?bot ?item) (hold ?bot ?item)))
    :effect (and (not(weighable ?item)))
  )

  (:action check_out
    :parameters (?item - ShoppingItem ?x - AisleCells ?bot - shopbot)
    :precondition (and (>= (balance ?bot) (price ?item)) (at ?bot ?x) (adjacent ?x CheckoutStand) (at_item ?item CheckoutStand) (not(holding ?bot)) (not(weighable ?item)))
    :effect (and (checked_out ?item ?bot) (decrease (balance ?bot) (price ?item))) 
  )
)