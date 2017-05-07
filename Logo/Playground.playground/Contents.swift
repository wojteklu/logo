//: Playground - noun: a place where people can play

import Logo

let code20 = "" +
"to qcircle :size " +
"repeat 90 [fd(:size) rt(1)] " +
"end " +
//"to petal :size " +
//"qcircle(:size) " +
//"rt(90) " +
//"qcircle(:size) " +
//"rt(90) " +
//"end " +
"qcircle(5) rt(90) qcircle(5)"

let code = "fd(100) rt(90) fd(100)"

//let code2 = "to wojtek fd(100) end wojtek() rt(90) wojtek()"

let code13 = "" +
    "to qcircle :size " +
    "repeat 90 [fd(:size) rt(1)] " +
    "end " +
    
    "to petal :size " +
    "qcircle(:size)  " +
    "rt(90) " +
    "qcircle(:size) " +
    "rt(90) " +
    "end " +
    
    "to flower :size  " +
    "repeat 10 [petal(:size) rt(360/10)] " +
    "end " +
    "to plant :size " +
    "flower(:size) " +
    "bk(135 * :size) " +
    "petal(:size) " +
    "bk(65 * :size) " +
    "end " +
"repeat 1 [ plant(2) ] "

let code3 = "" +
    "to tree :size " +
    "if (:size < 5) [fd(:size) bk(:size) ] else [" +
    "fd(:size/3) " +
    "lt(30) tree(:size*2/3) rt(30) " +
    "fd(:size/6) " +
    "rt(25) tree(:size/2) lt(25) " +
    "fd(:size/3) " +
    "rt(25) tree(:size/2) lt(25) " +
    "fd(:size/6) " +
    "bk(:size) ]" +
    "end " +
    "to qcircle :size " +
    "repeat 90 [fd(:size) rt(1)] " +
    "end " +
"bk(150) tree(250) "

let code4 = "" +
    "to fern :size :sign " +
    "if (:size > 1) [" +
    "fd(:size) " +
    "rt(70 * :sign) fern(:size * 1/2, :sign * 1) lt(70 * :sign) " +
    "fd(:size) " +
    "lt(70 * :sign) fern(:size * 1/2, :sign) rt(70 * :sign) " +
    "rt(7 * :sign) fern(:size - 1, :sign) lt(7 * :sign) " +
    "bk(:size * 2) ] " +
    "end " +
"fern(30, 1)"

let code10 = "" +
    "to line :count :length " +
    "if (:count = 1) [fd(:length)] " +
    "else [ " +
    "line(:count-1, :length) " +
    "lt(60) line(:count-1, :length) " +
    "rt(120) line(:count-1, :length) " +
    "lt(60) line(:count-1, :length) " +
    " ] end " +
    "to koch :count :length " +
    "rt(30) line(:count, :length) " +
    "rt(120) line(:count, :length) " +
    "rt(120) line(:count, :length) " +
    "end " +
"koch(5, 10)"


let code100 = "" +
"repeat 100 [" +
"repeat 8 [" +
"fd(80)" +
"rt(80)" +
"bk(80)" +
"] " +
"rt(45)" +
"]"

let code2 = "to square :length repeat 4 [ forward(:length) right(90) ] end repeat 220 [ square(random(200)) right(10) ]"

let interpreter = Interpreter()
interpreter.run(code: code2)



