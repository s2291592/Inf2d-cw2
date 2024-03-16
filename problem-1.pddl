(define (problem block-problem)
    (:domain blocks-world)
    (:objects 
        Potato - ShoppingItem
        Ketchup - ShoppingItem
        Toothpaste - ShoppingItem
        Pizza - ShoppingItem
    )
    
    (:init
        (at A Table)
        (at B Table)
        (at C Table)
        (Clear A)
        (Clear B)
        (Clear C)
    )
    (:goal (and
        (checked_out Potato)
        (checked_out Ketchup)
        (checked_out Toothpaste)
        (checked_out Pizza)
    ))
)