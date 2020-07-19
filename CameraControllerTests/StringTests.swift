//
//  StringTests.swift
//  CameraControllerTests
//
//  Created by Itay Brenner on 7/19/20.
//  Copyright © 2020 Itaysoft. All rights reserved.
//

import XCTest
@testable import CameraController

class StringTests: XCTestCase {
    func testExtractProductAndVendor() throws {
        let modelInfo = "UVC Camera VendorID_1452 ProductID_34068"

        let result = try modelInfo.extractCameraInformation()

        XCTAssertEqual(result.productId, 34068)
        XCTAssertEqual(result.vendorId, 1452)
    }

    func testExtractInvalid() throws {
        let modelInfo = "Some random string"

        XCTAssertThrowsError(try modelInfo.extractCameraInformation())
    }
}
