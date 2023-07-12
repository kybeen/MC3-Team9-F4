//
//  Utils.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/12.
//

import Foundation

class Utils: ObservableObject {
    func findGCD(_ num1: Int, _ num2: Int) -> Int {
        var x = 0
        
        // Finding maximum number
        var y: Int = max(num1, num2)
        
        // Finding minimum number
        var z: Int = min(num1, num2)
        
        while z != 0 {
            x = y
            y = z
            z = x % y
        }
        return y
    }
    
    // Function to find lcm of two numbers
    func findLCM(n1: Int, n2: Int)->Int{
        return (n1 * n2/findGCD(n1, n2))
    }
}
