//
//  UIStuff.swift
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

import UIKit

extension UIView {
    
    @objc func frameMaxY() -> CGFloat {
        return frame.maxY
    }
    
    @objc func frameMaxX() -> CGFloat {
        return frame.maxX
    }
    
    @objc func frameMiddle() -> CGPoint {
        return CGPoint(x: frame.midX, y: frame.midY)
    }
    
    @objc func boundsMiddle() -> CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
}

extension NSNumberFormatter {
    
    // louzy date handling, I know 😔
    @objc class func dateStringForInterval(interval: NSTimeInterval) -> String {
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        
        let hours = Int(interval / 3600)
        let minutes = Int(interval % 3600) / 60
        
        guard let hoursString = formatter.stringFromNumber(hours) else { fatalError("😒") }
        guard let minutesString = formatter.stringFromNumber(minutes) else { fatalError("🙄") }
        
        return "\(hoursString):\(minutesString)"
    }
    
}

extension NSString {
    
    @objc func convertToTimeInterval() -> NSTimeInterval {
        
        let components = self.componentsSeparatedByString(":")
        
        if components.count != 2 {
            return -1
        }
        
        guard let hoursComponent = Double(components[0]) else { return -1 }
        guard let minutesComponent = Double(components[1]) else { return -1 }
        
        let hours = hoursComponent * 3600
        let minutes = minutesComponent * 60
        
        return hours + minutes
    }
    
}

extension UIFont {
    
    @objc enum GoEuroFont: Int {
        case Bold
        case Regular
        case Thin
        case Mono
    }
    
    @objc class func goEuroFont(fontIdentifier: GoEuroFont, size: CGFloat) -> UIFont {
        var font: UIFont? = nil
        
        // ugly as hell but then again, iOS 7
        switch fontIdentifier {
        case .Bold:
            if #available(iOS 8.2, *) {
                font = UIFont.systemFontOfSize(size, weight: UIFontWeightBold)
            } else {
                font = UIFont(name: "HelveticaNeue-Bold", size: size)
            }
        case .Regular:
            if #available(iOS 8.2, *) {
                font = UIFont.systemFontOfSize(size, weight: UIFontWeightRegular)
            } else {
                font = UIFont(name: "HelveticaNeue-Medium", size: size)
            }
        case .Thin:
            if #available(iOS 8.2, *) {
                font = UIFont.systemFontOfSize(size, weight: UIFontWeightThin)
            } else {
                font = UIFont(name: "HelveticaNeue-Thin", size: size)
            }
        case .Mono:
            if #available(iOS 9.0, *) {
                font = UIFont.monospacedDigitSystemFontOfSize(size, weight: UIFontWeightThin)
            } else {
                font = UIFont(name: "CourierNewPSMT", size: size)
            }
        }
        
        guard let returnFont = font else { fatalError("😒") }
        
        return returnFont
    }
    
}

extension NSURL {
    
    @objc static var documentsURL: NSURL {
        let pathString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        return NSURL(string: pathString)!
    }
    
}

extension UIImage {
    
    @objc func imageWithAlpha(alpha: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -area.height)
        
        CGContextSetBlendMode(context, .Multiply)
        
        CGContextSetAlpha(context, alpha)
        
        CGContextDrawImage(context, area, self.CGImage)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
}

extension UIViewController {
    
    @objc func showAlertViewWithTitle(title: String, message: String) {
        
        if #available(iOS 9.0, *) {
            let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .Alert)
            let action = UIAlertAction.init(title: "OK", style: .Cancel, handler: { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(action)
            presentViewController(alertController, animated: true, completion: nil)
        } else {
            let alertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
        
    }
    
}
