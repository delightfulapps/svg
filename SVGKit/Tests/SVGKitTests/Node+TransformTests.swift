//
//  Node+TransformTests.swift
//  
//
//  Created by Matthew Delves on 13/1/20.
//

import XCTest
import SVGKit

final class NodeTransformTests: XCTestCase {
  func testTranslates() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let group = result?.children.first { $0.element == .group }
    let transforms = group?.transforms

    XCTAssertEqual(transforms?.count, 2)

    let expected: [Node.Transform] = [
      .translate(x: 700, y: 210),
      .rotate(degrees: -30.0)
    ]

    XCTAssertEqual(expected, transforms)
  }

  func testCombinesTransforms() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let group = result?.children.first { $0.element == .group }

    let expected = CGAffineTransform.identity
      .translatedBy(x: 700, y: 210)
      .rotated(by: -30 * CGFloat.pi / 180.0)

    XCTAssertEqual(group?.appliedTransforms, expected)
  }
}
