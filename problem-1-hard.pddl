(define (problem supermarket-problem)
    (:domain supermarket)
    (:objects 
        p11 p12 p13 p14 p15 p16
        p21 p22 p23 p24 p25 p26 p27
        p31 p32 p33 p34 p35 p36 p37
        p41 p42 p43 p44 p45 p46 p47
        p51 p56 p57 - position

        Ice_Lolly Pizza Cabbage Potato ToothPaste Shampoo Bread Ketchup - ShoppingItem
        AisleCells shelves WeighingScale CheckoutStand - location


        a1 a2 a3 a4 a5 a6 a7 a8 a9 a10
        a11 a12 a13 a14 a15 a16 a17 a18 a19 a20 - AisleCells


    )
    
    (:init


        ; shelves location
        (at_location shelves p15) (at_location shelves p16) (at_location shelves p22) (at_location shelves p23) 
        (at_location shelves p35) (at_location shelves p36) (at_location shelves p42) (at_location shelves p43)

        
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


        ; adjacent relations
        (adjacent p11 p12) (adjacent p12 p13) (adjacent p13 p14) (adjacent p14 p15) (adjacent p15 p16)
        (adjacent p21 p22) (adjacent p22 p23) (adjacent p23 p24) (adjacent p24 p25) (adjacent p25 p26) (adjacent p26 p27)
        (adjacent p31 p32) (adjacent p32 p33) (adjacent p33 p34) (adjacent p34 p35) (adjacent p35 p36) (adjacent p36 p37)
        (adjacent p41 p42) (adjacent p42 p43) (adjacent p43 p44) (adjacent p44 p45) (adjacent p45 p46) (adjacent p46 p47)
        (adjacent p56 p57)

        (adjacent p12 p11) (adjacent p13 p12) (adjacent p14 p13) (adjacent p15 p14) (adjacent p16 p15)
        (adjacent p22 p21) (adjacent p23 p22) (adjacent p24 p23) (adjacent p25 p24) (adjacent p26 p25) (adjacent p27 p26)
        (adjacent p32 p31) (adjacent p33 p32) (adjacent p34 p33) (adjacent p35 p34) (adjacent p36 p35) (adjacent p37 p36)
        (adjacent p42 p41) (adjacent p43 p42) (adjacent p44 p43) (adjacent p45 p44) (adjacent p46 p45) (adjacent p47 p46)
        (adjacent p57 p56)
        

        (adjacent p11 p21) (adjacent p21 p11)
        (adjacent p12 p22) (adjacent p22 p12)
        (adjacent p13 p23) (adjacent p23 p13)
        (adjacent p14 p24) (adjacent p24 p14)
        (adjacent p15 p25) (adjacent p25 p15)
        (adjacent p16 p26) (adjacent p26 p16)

        (adjacent p21 p31) (adjacent p31 p21)
        (adjacent p22 p32) (adjacent p32 p22)
        (adjacent p23 p33) (adjacent p33 p23)
        (adjacent p24 p34) (adjacent p34 p24)
        (adjacent p25 p35) (adjacent p35 p25)
        (adjacent p26 p36) (adjacent p36 p26)
        (adjacent p27 p37) (adjacent p37 p27)

        (adjacent p31 p41) (adjacent p41 p31)
        (adjacent p32 p42) (adjacent p42 p32)
        (adjacent p33 p43) (adjacent p43 p33)
        (adjacent p34 p44) (adjacent p44 p34)
        (adjacent p35 p45) (adjacent p45 p35)
        (adjacent p36 p46) (adjacent p46 p36)
        (adjacent p37 p47) (adjacent p47 p37)

        (adjacent p41 p51) (adjacent p51 p41)
        (adjacent p46 p56) (adjacent p56 p46)
        (adjacent p47 p57) (adjacent p57 p47)


        ; where AisleCells 
        (at_location a1 p12) (at_location a2 p13) (at_location a3 p14) (at_location a4 p21) (at_location a5 p24) (at_location a6 p25) (at_location a7 p26) (at_location a8 p27) (at_location a9 p31) (at_location a10 p32)
        (at_location a11 p33) (at_location a12 p34) (at_location a13 p37) (at_location a14 p41) (at_location a15 p44) (at_location a16 p45) (at_location a17 p46) (at_location a18 p47) (at_location a19 p56) (at_location a20 p57)

        ; important places
        (at_bot ShopBot p57) 
        (at_location CheckoutStand p51)
        (at_location WeighingScale p11)
        
        ; init the AisleCells clear
        (Clear a1) (Clear a2) (Clear a3) (Clear a4) (Clear a5) (Clear a6) (Clear a7) (Clear a8) (Clear a9) (Clear a10)
        (Clear a11) (Clear a12) (Clear a13) (Clear a14) (Clear a15) (Clear a16) (Clear a17) (Clear a18) (Clear a19) (not (Clear a20)) 

        ; shelves place but all ShoppingItem
        (at_item Ice_Lolly p15) (at_item Pizza p16) (at_item Cabbage p22) (at_item Potato p23) (at_item ToothPaste p35) (at_item Shampoo p36) (at_item Bread p42) (at_item Ketchup p43)

    )
    (:goal (and
        (checked_out Potato)
        (checked_out Ketchup)
        (checked_out ToothPaste)
        (checked_out Pizza)
        (at_bot ShopBot p27)
        (at_item Ice_Lolly p12) (at_item Pizza p13) (at_item Bread p14) (at_item ToothPaste p37) (at_item Ketchup p47)
    ))
)