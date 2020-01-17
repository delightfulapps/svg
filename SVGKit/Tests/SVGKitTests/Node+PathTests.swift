//
//  Node+PathTests.swift
//  
//
//  Created by Matthew Delves on 15/1/20.
//

import XCTest
import SVGKit

final class NodePathTests: XCTestCase {
  func testComplex() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("arc01.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let path = result?.children.first { $0.element == .path }
    let commands = path?.pathCommands
    print(commands ?? [])
    XCTAssertEqual(commands?.count, 2)

    // look at the commands
    let arc = commands?.filter {
      if case .elipticalArcCurve = $0 {
        return true
      }

      return false
    }.first

    // A 6 4 10 1 0 14,10
    let expected = PathCommand.elipticalArcCurve(
      rx: 6,
      ry: 4,
      angle: 10,
      largeArcFlag: true,
      sweepFlag: false,
      x: 14,
      y: 10
    )

    XCTAssertNotNil(arc)
    XCTAssertEqual(arc, expected)
  }
}
