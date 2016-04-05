//
//  ViewControllerExtension.swift
//  Project-7-Memory
//
//  Created by g tokman on 4/5/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

extension UIViewController {
    func execAfter(delay: Double, block: ()-> Void) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), block)
    }
}
