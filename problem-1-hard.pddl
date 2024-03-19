(define (problem supermarket-problem)
    (:domain supermarket)
    (:objects 


        Ice_Lolly Pizza Cabbage Potato ToothPaste Shampoo Bread Ketchup - ShoppingItem
        AisleCells shelves WeighingScale CheckoutStand - location
        shelf1 shelf2 shelf3 shelf4 shelf5 shelf6 shelf7 shelf8 - shelves


        a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
        a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 - AisleCells


    )
    
    (:init

        
        ; weighable items
        (weighable Cabbage)
        (weighable Potato)

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


        ; adjacent relations
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
        (at ShopBot a20) 

    )
    (:goal (and
        (checked_out Potato)
        (checked_out Ketchup)
        (checked_out ToothPaste)
        (checked_out Pizza)
        (at_item Potato a8)
        (at_item Cabbage shelf6)
        (at ShopBot a8)
    ))
)