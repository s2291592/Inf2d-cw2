(define (domain supermarket)

  (:requirements :adl)




  (:types 
  AisleCells shelves WeighingScale CheckoutStand BasketPlace AddCredit RechargeStation - location
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
      (clear ?ac - AisleCells)
  )

  (:functions
      (balance ?bot - shopbot) ; bot credit
      (price ?item - ShoppingItem) ; price of item
      (battery ?bot - shopbot) ; the battery capacity of the robot
  )










  (:action MOVE
      :parameters (?from - AisleCells ?to - AisleCells ?bot - shopbot)
      :precondition (and 
      (at ?bot ?from) (adjacent ?from ?to) (clear ?to) (not (clear ?from))
      (or 
      (and (not(holding ?bot)) (>= (battery ?bot) 1))
      (and (holding ?bot) (>= (battery ?bot) 2))
      )
      )
      :effect (and (at ?bot ?to) (not (at ?bot ?from)) (clear ?from) (not (clear ?to))
      (when (not(holding ?bot)) (decrease (battery ?bot) 1))
      (when (holding ?bot) (decrease (battery ?bot) 2))
      )
  )

  (:action trans_item
      :parameters (?x - AisleCells ?y - AisleCells ?item - ShoppingItem ?bot1 - shopbot ?bot2 - shopbot)
      :precondition (and (at ?bot1 ?x) (at ?bot2 ?y) (adjacent ?x ?y) (not (hold ?bot2 ?item)) (not (hold_in ?bot2 ?item))
      (or (hold ?bot1 ?item) (hold_in ?bot1 ?item))
      )
      :effect (and 
      (when 
      (and (hold ?bot1 ?item) (not (hold_basket ?bot2))) 
      (and (not (hold ?bot1 ?item)) (hold ?bot2 ?item) (holding ?bot2))
      )
      
      (when 
      (and (hold ?bot1 ?item) (hold_basket ?bot2)) 
      (and (not (hold ?bot1 ?item)) (hold_in ?bot2 ?item))
      )

      (when 
      (and (hold_in ?bot1 ?item) (not (hold_basket ?bot2))) 
      (and (not (hold_in ?bot1 ?item)) (hold ?bot2 ?item) (holding ?bot2))
      )      

      (when 
      (and (hold_in ?bot1 ?item) (hold_basket ?bot2)) 
      (and (not (hold_in ?bot1 ?item)) (hold_in ?bot2 ?item))
      )
      (decrease (balance ?bot2) (price ?item))
      (increase (balance ?bot1) (price ?item))
      )
  )

  (:action top_up
      :parameters (?x - AisleCells ?bot - shopbot)
      :precondition (and (at ?bot ?x) (adjacent ?x AddCredit))
      :effect (and (increase (balance ?bot) 5))
  )

  (:action recharge_bot
      :parameters (?x - AisleCells ?bot - shopbot)
      :precondition (and (at ?bot ?x) (adjacent ?x RechargeStation))
      :effect (assign (battery ?bot) 20)
  )

  (:action pick_up
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location ?bot - shopbot)
    :precondition (and (at ?bot ?x) (>= (balance ?bot) (price ?item)) (at_item ?item ?y) (adjacent ?x ?y) (>= (battery ?bot) 1) (not (holding ?bot)))
    :effect (and (holding ?bot) (hold ?bot ?item) (decrease (battery ?bot) 1) (decrease (balance ?bot) (price ?item)))
  )



  (:action drop
    :parameters (?item - ShoppingItem ?x - AisleCells ?bot - shopbot)
    :precondition (and (at ?bot ?x) (adjacent ?x CheckoutStand) (holding ?bot) (or (hold ?bot ?item) (hold_in ?bot ?item)))
    :effect (and (at_item ?item CheckoutStand) (at ?bot ?x) 
    (when (not (hold_basket ?bot)) (and (not (holding ?bot)) (not (hold ?bot ?item))))
    (when (hold_basket ?bot) (not (hold_in ?bot ?item)))
    )
  )


  (:action use_basket
    :parameters (?x - AisleCells ?bot - shopbot)
    :precondition (and (at ?bot ?x) (adjacent ?x BasketPlace) (not (holding ?bot)))
    :effect (and (holding ?bot) (hold_basket ?bot))
  )

  (:action pick_up_with_basket
    :parameters (?item - ShoppingItem ?x - AisleCells ?y - location ?bot - shopbot)
    :precondition (and (at ?bot ?x) (holding ?bot) (>= (balance ?bot) (price ?item)) (>= (battery ?bot) 1) (hold_basket ?bot) (at_item ?item ?y) (adjacent ?x ?y))
    :effect (and (hold_in ?bot ?item) (decrease (battery ?bot) 1) (decrease (balance ?bot) (price ?item)))
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
    :precondition (and (at ?bot ?x) (adjacent ?x CheckoutStand) (at_item ?item CheckoutStand) (not(holding ?bot)) (not(weighable ?item)))
    :effect (and (checked_out ?item ?bot)) 
  )
)