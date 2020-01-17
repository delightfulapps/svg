//
//  PathCommandTests.swift
//  
//
//  Created by Matthew Delves on 15/1/20.
//

import XCTest
import SVGKit

final class PathCommandTests: XCTestCase {
  func testMoveTo() {
    let expected: [PathCommand] = [.moveTo(CGPoint(x: 10, y: 10))]
    let result = PathCommand.commands(for: "M 10,10")
    XCTAssertEqual(expected, result)
  }

  func testMoveToRelative() {
    let expected: [PathCommand] = [.moveToRelative(dx: 10, dy: 10)]
    let result = PathCommand.commands(for: "m 10,10")
    XCTAssertEqual(expected, result)
  }

  func testLineTo() {
    let expected: [PathCommand] = [.lineTo(CGPoint(x: 100, y: 200))]
    let result = PathCommand.commands(for: "L 100,200")
    XCTAssertEqual(expected, result)
  }

  func testLineToRelative() {
    let expected: [PathCommand] = [.lineToRelative(dx: 100, dy: 100)]
    let result = PathCommand.commands(for: "l 100,100")
    XCTAssertEqual(expected, result)
  }

  func testHorizontalLine() {
    let expected: [PathCommand] = [.horizontalLine(x: 100)]
    let result = PathCommand.commands(for: "H 100")
    XCTAssertEqual(expected, result)
  }

  func testHorizontalLineRelative() {
    let expected: [PathCommand] = [.horizontalLineRelative(dx: 20)]
    let result = PathCommand.commands(for: "h 20")
    XCTAssertEqual(expected, result)
  }

  func testVerticalLine() {
    let expected: [PathCommand] = [.verticalLine(y: 20)]
    let result = PathCommand.commands(for: "V 20")
    XCTAssertEqual(expected, result)
  }

  func testVerticalLineRelative() {
    let expected: [PathCommand] = [.verticalLineRelative(dy: 100)]
    let result = PathCommand.commands(for: "v 100")
    XCTAssertEqual(expected, result)
  }

  func testCubicBezierCurve() {
    let expected: [PathCommand] = [.cubicBezierCurve(x1: 10, y1: 10, x2: 20, y2: 20, x: 5, y: 5)]
    let result = PathCommand.commands(for: "C 10,10 20,20 5,5")
    XCTAssertEqual(expected, result)
  }

  func testCubicBezierCurveRelative() {
    let expected: [PathCommand] = [
      .cubicBezierCurveRelative(dx1: 10, dy1: 10, dx2: 5, dy2: 5, dx: 100, dy: 100)
    ]
    let result = PathCommand.commands(for: "c 10,10 5,5 100,100")
    XCTAssertEqual(expected, result)
  }

  func testSmoothCubicBezierCurve() {
    let expected: [PathCommand] = [.smoothCubicBezierCurve(x2: 10, y2: 10, x: 20, y: 20)]
    let result = PathCommand.commands(for: "S 10,10 20,20")
    XCTAssertEqual(expected, result)
  }

  func testSmoothCubicBezierCurveRelative() {
    let expected: [PathCommand] = [.smoothCubicBezierCurveRelative(dx2: 10, dy2: 10, dx: 2, dy: 50)]
    let result = PathCommand.commands(for: "s 10,10 2,50")
    XCTAssertEqual(expected, result)
  }

  func testQuadBezierCurve() {
    let expected: [PathCommand] = [.quadBezierCurve(x1: 10, y1: 10, x: 20, y: 60)]
    let result = PathCommand.commands(for: "Q 10,10 20,60")
    XCTAssertEqual(expected, result)
  }

  func testQuadBezierCurveRelative() {
    let expected: [PathCommand] = [.quadBezierCurveRelative(dx1: 10, dy1: 20, dx: 4, dy: 80)]
    let result = PathCommand.commands(for: "q 10,20 4,80")
    XCTAssertEqual(expected, result)
  }

  func testSmoothQuadBezierCurve() {
    let expected: [PathCommand] = [.smoothQuadBezierCurve(x: 10, y: 50)]
    let result = PathCommand.commands(for: "T 10,50")
    XCTAssertEqual(expected, result)
  }

  func testSmoothQuadBezierCurveRelative() {
    let expected: [PathCommand] = [.smoothQuadBezierCurveRelative(dx: 10, dy: 543)]
    let result = PathCommand.commands(for: "t 10,543")
    XCTAssertEqual(expected, result)
  }

  func testElipticalArcCurve() {
    let expected: [PathCommand] = [
      .elipticalArcCurve(
        rx: 10,
        ry: 10,
        angle: 45,
        largeArcFlag: true,
        sweepFlag: false,
        x: 10,
        y: 10
      )
    ]
    let result = PathCommand.commands(for: "A 10 10 45 1 0 10,10")
    XCTAssertEqual(expected, result)
  }

  func testElipticalArcCurveRelative() {
    let expected: [PathCommand] = [
      .elipticalArcCurveRelative(
        rx: 10,
        ry: 10,
        angle: 45,
        largeArcFlag: true,
        sweepFlag: false,
        dx: 10,
        dy: 10
      )
    ]
    let result = PathCommand.commands(for: "a 10 10 45 1 0 10,10")
    XCTAssertEqual(expected, result)
  }

  func testClosePath() {
    let expected: [PathCommand] = [.closePath]
    let result = PathCommand.commands(for: "Z")
    XCTAssertEqual(expected, result)
  }

  func testClosePathRelative() {
    let expected: [PathCommand] = [.closePath]
    let result = PathCommand.commands(for: "z")
    XCTAssertEqual(expected, result)
  }
}
