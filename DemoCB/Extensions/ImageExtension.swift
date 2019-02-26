//
//  UIImageViewExtension.swift
//  DemoCB
//
//  Created by himanshu.ahuja on 19/02/19.
//  Copyright © 2019 himanshu.ahuja. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func toData(compressionQuality: CGFloat = 1.0) -> Data? {
        
        let imageData = self.jpegData(compressionQuality: compressionQuality)
        return imageData
    }
    
    func toBase64(compressionQuality: CGFloat) -> String {
        
        let imageData = self.jpegData(compressionQuality: compressionQuality)
        let base64String = imageData!.base64EncodedString(options: [])
        
        return base64String
        
    }
    
    func color(color: UIColor) -> UIImage {
        
        var s = self.size // CGSize
        s.height *= self.scale
        s.width *= self.scale
        
        UIGraphicsBeginImageContext(s)
        
        var contextRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: s)
        
        // Retrieve source image and begin image context
        let itemImageSize = s //CGSize
        
        let xVal = (contextRect.size.width - itemImageSize.width)/2
        let yVal = (contextRect.size.height - itemImageSize.height)
        
        //let itemImagePosition = CGPoint(x: ceilf(xFloatVal), y: ceilf(yVal)) //CGPoint
        
        let itemImagePosition = CGPoint(x: xVal, y: yVal) //CGPoint
        
        UIGraphicsBeginImageContext(contextRect.size)
        
        let c = UIGraphicsGetCurrentContext() //CGContextRef
        
        // Setup shadow
        // Setup transparency layer and clip to mask
        c?.beginTransparencyLayer(auxiliaryInfo: nil)
        c?.scaleBy(x: 1.0, y: -1.0)
        
        //CGContextRotateCTM(c, M_1_PI)
        
        c?.clip(to: CGRect(x: itemImagePosition.x, y: -itemImagePosition.y, width: itemImageSize.width, height: -itemImageSize.height), mask: self.cgImage!)
        
        // Fill and end the transparency layer
        let colorSpace = color.cgColor.colorSpace //CGColorSpaceRef
        let model = colorSpace?.model //CGColorSpaceModel
        
        let colors = color.cgColor.components
        
        if (model == .monochrome) {
            c?.setFillColor(red: (colors?[0])!, green: (colors?[0])!, blue: (colors?[0])!, alpha: (colors?[1])!)
        } else {
            c?.setFillColor(red: (colors?[0])!, green: (colors?[1])!, blue: (colors?[2])!, alpha: (colors?[3])!)
        }
        
        contextRect.size.height = -contextRect.size.height
        contextRect.size.height -= 15
        c?.fill(contextRect)
        c?.endTransparencyLayer()
        
        let img = UIGraphicsGetImageFromCurrentImageContext() //UIImage
        
        let img2 = UIImage(cgImage: (img?.cgImage!)!, scale: self.scale, orientation: self.imageOrientation)
        
        UIGraphicsEndImageContext()
        
        return img2
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func textToImage(drawText: String, atPoint: CGPoint = CGPoint.zero) -> UIImage {
        
        // Setup the font specific variables
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        // Setup the image context using the passed image
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedString.Key.font.rawValue: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [AnyHashable : Any]
        
        // Put the image into a rectangle as large as the original image
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        // Create a point within the space that is as bit as the image
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: self.size.width, height: self.size.height)
        
        
        // Draw the text into an image
        drawText.draw(in: rect, withAttributes: (textFontAttributes as! [NSAttributedString.Key : Any]))
        
        // Create a new image out of the images we have created
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context now that we have the image we need
        UIGraphicsEndImageContext()
        
        //Pass the image back up to the caller
        return newImage!
        
    }
    
    public class func gif(data: Data) -> UIImage? {
        // Create source from data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("SwiftGif: Source for the image does not exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gif(url: String) -> UIImage? {
        // Validate URL
        guard let bundleURL = URL(string: url) else {
            print("SwiftGif: This image named \"\(url)\" does not exist")
            return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    public class func gif(name: String) -> UIImage? {
        // Check for existance of gif
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        
        // Validate data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gif(data: imageData)
    }
    
    @available(iOS 9.0, *)
    public class func gif(asset: String) -> UIImage? {
        // Create source from assets catalog
        guard let dataAsset = NSDataAsset(name: asset) else {
            print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
            return nil
        }
        
        return gif(data: dataAsset.data)
    }
    
    internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        // Get dictionaries
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
        if CFDictionaryGetValueIfPresent(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque(), gifPropertiesPointer) == false {
            return delay
        }
        
        let gifProperties:CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
        
        // Get delay time
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as? Double ?? 0
        
        if delay < 0.1 {
            delay = 0.1 // Make sure they're not too fast
        }
        
        return delay
    }
    
    internal class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        // Check if one of them is nil
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        // Swap for modulo
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        // Get greatest common divisor
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b! // Found it
            } else {
                a = b
                b = rest
            }
        }
    }
    
    internal class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        // Fill arrays
        for i in 0..<count {
            // Add image
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            // At it's delay in cs
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        // Calculate full duration
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        // Get frames
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        // Heyhey
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 1000.0)
        
        return animation
    }
    
}

extension UIImageView {
    
    public func loadGif(name: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(name: name)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    @available(iOS 9.0, *)
    public func loadGif(asset: String) {
        DispatchQueue.global().async {
            let image = UIImage.gif(asset: asset)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
}
