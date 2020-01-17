//
//  File.swift
//  
//
//  Created by Matthew Delves on 14/1/20.
//

import UIKit
import XCTest
import SVGKit

final class UIColorInitWithHexTests: XCTestCase {
  func testFromHexRed() {
    XCTAssertEqual(UIColor(hex: "#FF0000"), .red)
  }

  func testFromHexGreen() {
    XCTAssertEqual(UIColor(hex: "#00FF00"), .green)
  }

  func testFromHexBlue() {
    XCTAssertEqual(UIColor(hex: "#0000FF"), .blue)
  }
}
