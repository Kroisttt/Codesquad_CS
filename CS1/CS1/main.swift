//
//  main.swift
//  CS1
//
//  Created by 이진영 on 03/04/2019.
//  Copyright © 2019 Kroist. All rights reserved.
//

import Foundation

func nand (paramA: Bool, paramB: Bool) -> Bool {
    return !(paramA && paramB)
}

func nor (paramA: Bool, paramB: Bool) -> Bool {
    return !(paramA || paramB)
}

func and (paramA: Bool, paramB: Bool) -> Bool {
    return paramA && paramB
}

func or (paramA: Bool, paramB: Bool) -> Bool {
    return paramA || paramB
}

func xor (paramA: Bool, paramB: Bool) -> Bool {
    let a = nand(paramA: paramA, paramB: paramB)
    let b = nand(paramA: paramA, paramB: a)
    let c = nand(paramA: a, paramB: paramB)
    
    return nand(paramA: b, paramB: c)
}

func halfadder(_ bitA: Bool, _ bitB: Bool) -> [Bool] {
    let sum = xor(paramA: bitA, paramB: bitB)
    let carry = and(paramA: bitA, paramB: bitB)
    return [carry, sum]
}

func fulladder(_ bitA: Bool, _ bitB: Bool, _ carry: Bool) -> [Bool] {
    let half = halfadder(bitA, bitB)
    let sum = halfadder(carry, half[1])
    let carry = or(paramA: half[0], paramB: sum[0])
    
    return [carry, sum[1]]
}

//print(fulladder(true, false, true))

func byteadder(_ byteA:[Bool], _ byteB:[Bool]) -> [Bool] {
    var carry = false
    var array: [Bool] = []
    var full: [Bool]
    
    for i in 0..<byteA.count {
        full = fulladder(byteA[i], byteB[i], carry)
        carry = full[0]
        array.append(full[1])
    }
    
    array.append(carry)

    return array
}

let byteA = [true, true, false, true, true, false, true, false]
let byteB = [true, false, true, true, false, false, true, true]

//print(byteadder(byteA, byteB))

func dec2bin(_ decimal:Int) -> [Bool] {
    var binary: [Bool] = []
    var intArray: [Int] = []
    var rest = 0
    var value = decimal
    
    while true {
        if 0...1 ~= value {
            intArray.append(value)
            break
        } else {
            rest = value % 2
            value /= 2
            
            intArray.append(rest)
        }
    }
    
    for i in intArray {
        if i == 0 {
            binary.append(false)
        } else {
            binary.append(true)
        }
    }
    
    return binary
}

print(dec2bin(173))

func bin2dec(_ bin: [Bool]) -> Int {
    var decimal = 0
    var square = 1
    
    for i in bin {
        if i == true {
            decimal += square
        }
        
        square *= 2
    }
    
    return decimal
}

print(bin2dec([false, true, true, true]))
