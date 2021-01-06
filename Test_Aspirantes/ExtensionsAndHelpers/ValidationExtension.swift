//
//  ValidationExtension.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 04/01/21.
//

import Foundation

extension String {
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    public var length: Int {
        return count
    }
}
