//
//  Constants.swift
//  Side-Menu-Swift
//
//  Created by SergeSinkevych on 23.04.16.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    static func titleTextColor(color: UIColor) -> [String:AnyObject] {
        return [NSForegroundColorAttributeName:color]
    }
    
    struct Colors {
        static let menuBackgroundColor = UIColor.sadGreen()
        static let selectedMenuItemColor = UIColor.darkSadGreen()
        static let separatorCGColor = UIColor.quarterWhite().CGColor
        static let menuTextColor = UIColor.halfWhite()
    }
}

extension UIColor {
    
    class func sadGreen() -> UIColor {
        return UIColor(red: 26/255, green: 110/255, blue: 109/255, alpha: 1.0)
    }

    class func darkSadGreen() -> UIColor {
        return UIColor(red: 17/255, green: 72/255, blue: 71/255, alpha: 1.0)
    }
    
    class func halfWhite() -> UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
    }
    
    class func quarterWhite() -> UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat.from1to255, green: CGFloat.from1to255, blue: CGFloat.from1to255, alpha: 1)
    }
    
    
}

extension CGFloat {
    static var from1to255 : CGFloat {
        return CGFloat(arc4random_uniform(255))/255
    }
}