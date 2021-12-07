//
//  Array.swift
//  KeyCommandsBugDemo
//
//  Created by Natalia Osiecka on 07/12/2021.
//

import UIKit

extension Array where Element: UIKeyCommand {

    var topPrioritised: [UIKeyCommand] {
        if #available(iOS 15, *) {
            forEach { $0.wantsPriorityOverSystemBehavior = true }
        }
        return self
    }
}
