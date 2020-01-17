//
//  Node+AttributeTests.swift
//  
//
//  Created by Matthew Delves on 14/1/20.
//

import XCTest
import SVGKit

final class NodeAttributeTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testColor() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let rect = result?.children.first { $0.element == .rect }
    let color = rect?.stroke

    // Expect there to be a UIColor
    XCTAssertEqual(color, UIColor.blue)
  }

  func testStrokeWidth() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let rect = result?.children.first { $0.element == .rect }
    let strokeWidth = rect?.strokeWidth

    XCTAssertEqual(strokeWidth, 2.0)
  }

  func testFill() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let rect = result?.children.first { $0.element == .rect }
    XCTAssertEqual(rect?.fill, .clear)
  }

  func testX() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let rect = result?.children.last { $0.element == .rect }
    XCTAssertEqual(rect?.x, 100)
  }

  func testY() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let rect = result?.children.last { $0.element == .rect }
    XCTAssertEqual(rect?.y, 100)
  }

  func testWidth() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let rect = result?.children.last { $0.element == .rect }
    XCTAssertEqual(rect?.width, 400)
  }

  func testHeight() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let rect = result?.children.last { $0.element == .rect }
    XCTAssertEqual(rect?.height, 200)
  }

  func testCornerRadius() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let rect = result?.children.last { $0.element == .rect }
    XCTAssertEqual(rect?.cornerRadius, 50)
  }

  func testFillRule() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("alrt-triangle-fill.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)

    let path = result?.children.first { $0.element == .path  }
    XCTAssertEqual(path?.fillRule, Node.FillRule.evenOdd)
  }
}
