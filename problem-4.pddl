(define (problem supermarket-problem)
    (:domain supermarket)
    (:objects 


        Ice_Lolly Pizza Cabbage Potato ToothPaste Shampoo Bread Ketchup - ShoppingItem
        AisleCells shelves WeighingScale CheckoutStand BasketPlace AddCredit - location
        shelf1 shelf2 shelf3 shelf4 shelf5 shelf6 shelf7 shelf8 - shelves


        a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
        a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 - AisleCells

        botBlue botOran -shopbot


    )
    
    (:init


        ; Define clear to ensure that two bots will not collide in the same place
        (clear a1) (clear a2) (clear a3) (clear a4) (clear a5) 
        (clear a6) (clear a7) (clear a8) (clear a9) (clear a10) 
        (clear a11) (clear a12) (clear a13) (clear a14) (clear a15) 
        (clear a16) (clear a17) (clear a18) (not (clear a19)) (not (clear a20))

        
        ; weighable items
        (weighable Cabbage)
        (weighable Potato)

        ;what can bot pick up
        (on_list botBlue Potato)
        (on_list botBlue Ketchup)
        (on_list botBlue ToothPaste)
        (on_list botBlue Pizza)
        

        
        (on_list botOran Cabbage)
        (on_list botOran Bread)
        (on_list botOran Shampoo)
        (on_list botOran Ice_Lolly)
    

        ; non-weighable items
        (not (weighable Ice_Lolly))
        (not (weighable Pizza))
        (not (weighable ToothPaste))
        (not (weighable Shampoo))
        (not (weighable Bread))
        (not (weighable Ketchup))

        ; item place
        (at_item Ice_Lolly shelf1)
        (at_item Pizza shelf2)
        (at_item Cabbage shelf3)
        (at_item Potato shelf4)
        (at_item ToothPaste shelf5)
        (at_item Shampoo shelf6)
        (at_item Bread shelf7)
        (at_item Ketchup shelf8)

        ; item price
        (= (price Ice_Lolly) 4) (= (price Pizza) 6) (= (price Cabbage) 3) (= (price Potato) 4)
        (= (price ToothPaste) 7) (= (price Shampoo) 9) (= (price Bread) 5) (= (price Ketchup) 8)

        ; bot initial credit
        (= (balance botBlue) 15) (= (balance botOran) 11)


        ; adjacent relations
        (adjacent a8 AddCredit)
        (adjacent a16 BasketPlace) (adjacent a19 BasketPlace)
        (adjacent a1 WeighingScale) (adjacent a1 a2) (adjacent a1 shelf3)
        (adjacent a2 a1) (adjacent a2 a3) (adjacent a2 shelf4)
        (adjacent a3 a2) (adjacent a3 shelf1) (adjacent a3 a5)
        (adjacent a4 WeighingScale) (adjacent a4 shelf3) (adjacent a4 a9)
        (adjacent a5 a3) (adjacent a5 shelf4) (adjacent a5 a6) (adjacent a5 a12)
        (adjacent a6 shelf1) (adjacent a6 a5) (adjacent a6 a7) (adjacent a6 shelf5)
        (adjacent a7 shelf2) (adjacent a7 a6) (adjacent a7 a8) (adjacent a7 shelf6)
        (adjacent a8 a7) (adjacent a8 a13)
        (adjacent a9 a4) (adjacent a9 a10) (adjacent a9 a14)
        (adjacent a10 shelf3) (adjacent a10 a9) (adjacent a10 a11) (adjacent a10 shelf7)
        (adjacent a11 shelf4) (adjacent a11 a10) (adjacent a11 a12) (adjacent a11 shelf8)
        (adjacent a12 a5) (adjacent a12 a11) (adjacent a12 shelf5) (adjacent a12 a15)
        (adjacent a13 a8) (adjacent a13 shelf6) (adjacent a13 a18)
        (adjacent a14 a9) (adjacent a14 shelf7) (adjacent a14 CheckoutStand)
        (adjacent a15 a12) (adjacent a15 shelf8) (adjacent a15 a16)
        (adjacent a16 shelf5) (adjacent a16 a15) (adjacent a16 a17)
        (adjacent a17 shelf6) (adjacent a17 a16) (adjacent a17 a18) (adjacent a17 a19)
        (adjacent a18 a13) (adjacent a18 a17) (adjacent a18 a20)
        (adjacent a19 a17) (adjacent a19 a20)
        (adjacent a20 a18) (adjacent a20 a19)



        ; important places
        (at botBlue a20) (at botOran a19)

    )
    (:goal (and
        (checked_out Potato botBlue)
        (checked_out Ketchup botBlue)
        (checked_out ToothPaste botBlue)
        (checked_out Pizza botBlue)

        
        (checked_out Cabbage botOran)
        (checked_out Bread botOran)
        (checked_out Shampoo botOran)
        (checked_out Ice_Lolly botOran)
        (not (hold_basket botBlue))
        (not (hold_basket botOran))
    ))
)