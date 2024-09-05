//
//  UIColor.swift
//  CocoaAsyncSocket
//
//  Created by BẢO HÀ on 12/09/2023.
//

import UIKit

extension UIImage {
    func setTintColor(_ color: UIColor) -> UIImage? {
        if #available(iOS 13.0, *) {
            return self.withTintColor(color, renderingMode: .alwaysOriginal)
        } else {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            // 1
            let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            // 2
            color.setFill()
            UIRectFill(drawRect)
            // 3
            draw(in: drawRect, blendMode: .destinationIn, alpha: 1)

            let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return tintedImage!
        }
    }

    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }

    func getFileSize(_ path: String) -> Int64? {
        // Remove "file://" prefix if it exists
        var cleanedPath = path
        if let url = URL(string: path), url.scheme == "file" {
            cleanedPath = url.path
        }
        
        let fileURL = URL(fileURLWithPath: cleanedPath)
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("Invalid file path.")
            return nil
        }
        
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: fileURL.path)
            if let fileSize = fileAttributes[.size] as? Int64 {
                return fileSize
            } else {
                print("File size attribute is not available.")
                return nil
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}
