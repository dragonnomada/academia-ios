//
//  IntExtension.swift
//  7202_CustomAVPlayer
//
//  Created by Dragon on 17/01/23.
//

import Foundation

extension Int {
    
    func fixed(digits n: Int) -> String {
        
        var text = "\(self)"
        
        while text.count < n {
            text = "0" + text
        }
        
        return String(text.suffix(n))
        
    }
    
}
