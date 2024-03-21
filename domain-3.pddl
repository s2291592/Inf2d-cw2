(define (domain supermarket)

  (:requirements :adl)




  (:types 
  AisleCells shelves WeighingScale CheckoutStand BasketPlace AddCredit - location
  shopbot 
  ShoppingItem
  )





  (:predicates
      (at_item ?item - ShoppingItem ?loc - location) ;; ShoppingItem is at a location: shelf or aisle cell
      (at ?bot - shopbot ?ac - AisleCells)
      (adjacent ?x - AisleCells ?y - location) ;; adjacent AisleCells or shelf 
      (holding ?bot - shopbot) ;; ShopBot is holding an item
      (hold_basket ?bot - shopbot)
      (hold ?bot - shopbot ?item - ShoppingItem) ;; hold the item
      (hold_in ?bot - shopbot ?item - ShoppingItem)
      (weighable ?item - ShoppingItem) ;; Item can be weighed
      (checked_out ?item - ShoppingItem) ;; Item has been checked out 
  )

  (:functions
      (balance ?bot - shopbot) ; bot credit
      (price ?item - ShoppingItem) ; price of item
  )





  (:constants ShopBot - shopbot)





  (:action MOVE
      :parameters (?from - AisleCells ?to - AisleCells)
      :precondition (and (at ShopBot ?from) (adjacent ?from ?to))
      :effect (and (at ShopBot ?to) (not (at ShopBot ?from)))
  )

  (:action top_up
      :parameters (?x - AisleCells)
      :precondition (and (at ShopBot ?x) (adjacent ?x AddCredit))
      :effect (and (increase (balance ShopBot) 5))
  )

  (:action pick_up
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location)
    :precondition (and (at ShopBot ?x) (at_item ?item ?y) (>= (balance ShopBot) (price ?item)) (adjacent ?x ?y) (not (holding ShopBot)))
    :effect (and (holding ShopBot) (decrease (balance ShopBot) (price ?item)) (hold ShopBot ?item))
  )




  (:action drop
    :parameters (?item - ShoppingItem ?x - AisleCells)
    :precondition (and (at ShopBot ?x) (adjacent ?x CheckoutStand) (holding ShopBot) (or (hold ShopBot ?item) (hold_in ShopBot ?item)))
    :effect (and (at_item ?item CheckoutStand) (at ShopBot ?x) 
    (when (not (hold_basket ShopBot)) (and (not (holding ShopBot)) (not (hold ShopBot ?item))))
    (when (hold_basket ShopBot) (not (hold_in ShopBot ?item)))
    )
  )


  (:action use_basket
    :parameters (?x - AisleCells)
    :precondition (and (at ShopBot ?x) (adjacent ?x BasketPlace) (not (holding ShopBot)))
    :effect (and (holding ShopBot) (hold_basket ShopBot))
  )

  (:action pick_up_with_basket
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location)
    :precondition (and (at ShopBot ?x) (holding ShopBot) (hold_basket ShopBot) (at_item ?item ?y) (adjacent ?x ?y) (>= (balance ShopBot) (price ?item)))
    :effect (and (hold_in ShopBot ?item) (decrease (balance ShopBot) (price ?item)))
  )  



  (:action return_basket
    :parameters (?x - AisleCells)
    :precondition (and (at ShopBot ?x) (adjacent ?x CheckoutStand) (hold_basket ShopBot))
    :effect (and (not (hold_basket ShopBot)) (not(holding ShopBot)))
  )



  (:action weigh
    :parameters (?item - ShoppingItem ?x - AisleCells)
    :precondition (and (weighable ?item) (holding ShopBot)  (at ShopBot ?x) (adjacent ?x WeighingScale) (or (hold_in ShopBot ?item) (hold ShopBot ?item)))
    :effect (and (not(weighable ?item)))
  )

  (:action check_out
    :parameters (?item - ShoppingItem ?x - AisleCells)
    :precondition (and  (at ShopBot ?x) (adjacent ?x CheckoutStand) (at_item ?item CheckoutStand) (not(holding ShopBot)) (not(weighable ?item)))
    :effect (and (checked_out ?item)) 
  )
)