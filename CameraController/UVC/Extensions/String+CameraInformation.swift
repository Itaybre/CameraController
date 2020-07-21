//
//  String+CameraInformation.swift
//  CameraController
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import Foundation

extension String {
    static let regexPattern = "^UVC\\s+Camera\\s+VendorID\\_([0-9]+)\\s+ProductID\\_([0-9]+)$"

    func extractCameraInformation() throws -> CameraInformation {
        let regex: NSRegularExpression = try NSRegularExpression(pattern: String.regexPattern,
                                                                 options: [])
        let range = NSRange(location: 0, length: count)

        guard let match: NSTextCheckingResult = regex.firstMatch(in: self,
                                                                 options: [],
                                                                 range: range), 3 == match.numberOfRanges,
            let vendorIDRange: Range<String.Index> = Range<String.Index>(match.range(at: 1), in: self),
            let vendorID: Int = Int(self[vendorIDRange]),
            let productIDRange: Range<String.Index> = Range<String.Index>(match.range(at: 2), in: self),
            let productID: Int = Int(self[productIDRange]) else {
                throw NSError(domain: #file, code: #line, userInfo: ["query": self])
        }
        return CameraInformation(productId: productID, vendorId: vendorID)
    }
}
