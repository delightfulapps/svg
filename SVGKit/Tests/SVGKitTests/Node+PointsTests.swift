//
//  Node+PointsTests.swift
//  
//
//  Created by Matthew Delves on 15/1/20.
//

import XCTest
import SVGKit

final class NodePointsTests: XCTestCase {
  func testPoints() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("polyline01.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)
    let polyline = result?.children.filter { $0.element == .polyline }.first
    XCTAssertNotNil(polyline)

    let expected: [CGPoint] = [
      CGPoint(x: 50, y: 375),
      CGPoint(x: 150, y: 375),
      CGPoint(x: 150, y: 325),
      CGPoint(x: 250, y: 325),
      CGPoint(x: 250, y: 375),
      CGPoint(x: 350, y: 375),
      CGPoint(x: 350, y: 250),
      CGPoint(x: 450, y: 250),
      CGPoint(x: 450, y: 375),
      CGPoint(x: 550, y: 375),
      CGPoint(x: 550, y: 175),
      CGPoint(x: 650, y: 175),
      CGPoint(x: 650, y: 375),
      CGPoint(x: 750, y: 375),
      CGPoint(x: 750, y: 100),
      CGPoint(x: 850, y: 100),
      CGPoint(x: 850, y: 375),
      CGPoint(x: 950, y: 375),
      CGPoint(x: 950, y: 25),
      CGPoint(x: 1050, y: 25),
      CGPoint(x: 1050, y: 375),
      CGPoint(x: 1150, y: 375)
    ]

    XCTAssertEqual(polyline?.points, expected)
  }
}
