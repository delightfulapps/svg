//
//  File.swift
//  
//
//  Created by Matthew Delves on 6/1/20.
//

import XCTest
import SVGKit

final class ParserTests: XCTestCase {
  func testParsesGroup() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("group.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)
    XCTAssertEqual(result?.children.count, 3)
    let groupsCount = result?.children.filter { $0.element == .group }.count ?? 0
    XCTAssertEqual(groupsCount, 2)
  }

  func testParsesTransforms() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("rect02.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)
    XCTAssertEqual(result?.children.count, 3)
  }

  func testParsesSimpleRect() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("simple_rect.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)
    XCTAssertEqual(result?.children.count, 5)
  }

  func testParsesCircle01() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("circle01.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)
    let circles = result?.children.filter { $0.element == .circle }.count ?? 0
    XCTAssertEqual(circles, 1)
  }

  func testParsesEllipse01() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("ellipse01.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)
    let ellipses = result?.children.filter { $0.element == .ellipse }.count ?? 0
    XCTAssertEqual(ellipses, 1)
  }

  func testParsesLine01() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("line01.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)
    let lines = result?.children.filter { $0.element == .group }.first?.children.filter { $0.element == .line }.count
    XCTAssertEqual(lines, 5)
  }

  func testParsesPolyline01() {
    let url = URL(fileURLWithPath: #file).deletingLastPathComponent().appendingPathComponent("polyline01.svg")
    let parser = Parser(url: url)
    let result = parser.svg
    XCTAssertNotNil(result)
    let polylines = result?.children.filter { $0.element == .polyline }.count
    XCTAssertEqual(polylines, 1)
  }
}

