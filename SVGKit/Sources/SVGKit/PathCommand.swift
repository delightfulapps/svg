//
//  PathCommand.swift
//  
//
//  Created by Matthew Delves on 15/1/20.
//

import UIKit

public enum PathCommand: Equatable {
  case moveTo(CGPoint) // M
  case moveToRelative(dx: CGFloat, dy: CGFloat) // m
  case lineTo(CGPoint) // L
  case lineToRelative(dx: CGFloat, dy: CGFloat) // l
  case horizontalLine(x: CGFloat) // H
  case horizontalLineRelative(dx: CGFloat) // h
  case verticalLine(y: CGFloat) // V
  case verticalLineRelative(dy: CGFloat) // v
  case cubicBezierCurve(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, x: CGFloat, y: CGFloat) // C
  case cubicBezierCurveRelative(dx1: CGFloat, dy1: CGFloat, dx2: CGFloat, dy2: CGFloat, dx: CGFloat, dy: CGFloat) // c
  case smoothCubicBezierCurve(x2: CGFloat, y2: CGFloat, x: CGFloat, y: CGFloat) // S
  case smoothCubicBezierCurveRelative(dx2: CGFloat, dy2: CGFloat, dx: CGFloat, dy: CGFloat) // s
  case quadBezierCurve(x1: CGFloat, y1: CGFloat, x: CGFloat, y: CGFloat) // Q
  case quadBezierCurveRelative(dx1: CGFloat, dy1: CGFloat, dx: CGFloat, dy: CGFloat) // q
  case smoothQuadBezierCurve(x: CGFloat, y: CGFloat) // T
  case smoothQuadBezierCurveRelative(dx: CGFloat, dy: CGFloat) // t
  case elipticalArcCurve(rx: CGFloat, ry: CGFloat, angle: CGFloat, largeArcFlag: Bool, sweepFlag: Bool, x: CGFloat, y: CGFloat) // A
  case elipticalArcCurveRelative(rx: CGFloat, ry: CGFloat, angle: CGFloat, largeArcFlag: Bool, sweepFlag: Bool, dx: CGFloat, dy: CGFloat) // a
  case closePath // Zz

  public static func ==(lhs: PathCommand, rhs: PathCommand) -> Bool {
    switch (lhs: lhs, rhs: rhs) {
    case let (lhs: .moveTo(lhsPoint), rhs: .moveTo(rhsPoint)):
      return lhsPoint == rhsPoint
    case let (lhs: .moveToRelative(dx: lhsDx, dy: lhsDy), rhs: .moveToRelative(dx: rhsDx, dy: rhsDy)):
      return lhsDx == rhsDx && lhsDy == rhsDy
    case let (lhs: .lineTo(lhsPoint), rhs: .lineTo(rhsPoint)):
      return lhsPoint == rhsPoint
    case let (lhs: .lineToRelative(dx: lhsDx, dy: lhsDy), rhs: .lineToRelative(dx: rhsDx, dy: rhsDy)):
      return lhsDx == rhsDx && lhsDy == rhsDy
    case let (lhs: .horizontalLine(x: lhsX), rhs: .horizontalLine(x: rhsX)):
      return lhsX == rhsX
    case let (lhs: .horizontalLineRelative(dx: lhsDx), rhs: .horizontalLineRelative(dx: rhsDx)):
      return lhsDx == rhsDx
    case let (lhs: .verticalLine(y: lhsY), rhs: .verticalLine(y: rhsY)):
      return lhsY == rhsY
    case let (lhs: .verticalLineRelative(dy: lhsDy), rhs: .verticalLineRelative(dy: rhsDy)):
      return lhsDy == rhsDy
    case let (lhs: .cubicBezierCurve(lhsCurve), rhs: .cubicBezierCurve(rhsCurve)):
      return lhsCurve == rhsCurve
    case let (lhs: .cubicBezierCurveRelative(lhsCurve), rhs: .cubicBezierCurveRelative(rhsCurve)):
      return lhsCurve == rhsCurve
    case let (lhs: .smoothCubicBezierCurve(lhsCurve), rhs: .smoothCubicBezierCurve(rhsCurve)):
      return lhsCurve == rhsCurve
    case let (lhs: .smoothCubicBezierCurveRelative(lhsCurve), rhs: .smoothCubicBezierCurveRelative(rhsCurve)):
      return lhsCurve == rhsCurve
    case let (lhs: .quadBezierCurve(lhsCurve), rhs: .quadBezierCurve(rhsCurve)):
      return lhsCurve == rhsCurve
    case let (lhs: .quadBezierCurveRelative(lhsCurve), rhs: .quadBezierCurveRelative(rhsCurve)):
      return lhsCurve == rhsCurve
    case let (lhs: .smoothQuadBezierCurve(lhsCurve), rhs: .smoothQuadBezierCurve(rhsCurve)):
      return lhsCurve == rhsCurve
    case let (lhs: .smoothQuadBezierCurveRelative(lhsCurve), rhs: .smoothQuadBezierCurveRelative(rhsCurve)):
      return lhsCurve == rhsCurve
    case let (lhs: .elipticalArcCurve(lhsArc), rhs: .elipticalArcCurve(rhsArc)):
      return lhsArc.rx == rhsArc.rx &&
        lhsArc.ry == rhsArc.ry &&
        lhsArc.angle == rhsArc.angle &&
        lhsArc.largeArcFlag == rhsArc
          .largeArcFlag &&
        lhsArc.sweepFlag == rhsArc.sweepFlag &&
        lhsArc.x == rhsArc.x &&
        lhsArc.y == rhsArc.y
    case let (lhs: .elipticalArcCurveRelative(lhsArc), rhs: .elipticalArcCurveRelative(rhsArc)):
      return lhsArc.rx == rhsArc.rx &&
        lhsArc.ry == rhsArc.ry &&
        lhsArc.angle == rhsArc.angle &&
        lhsArc.largeArcFlag == rhsArc
          .largeArcFlag &&
        lhsArc.sweepFlag == rhsArc.sweepFlag &&
        lhsArc.dx == rhsArc.dx &&
        lhsArc.dy == rhsArc.dy
    case (lhs: .closePath, rhs: .closePath):
      return true
    default:
      return false
    }
  }

  private static let formatter = NumberFormatter()

  public static func commands(for string: String) -> [PathCommand] {
    guard string.count >= 1 else { return [] }

    var command = string.replacingOccurrences(of: ",", with: " ")
    let action = command.removeFirst()

    /*
     MoveTo: M, m
     LineTo: L, l, H, h, V, v
     Cubic Bézier Curve: C, c, S, s
     Quadratic Bézier Curve: Q, q, T, t
     Elliptical Arc Curve: A, a
     ClosePath: Z, z
     */

    let scanner = Scanner(string: command)
    var numbers: [CGFloat] = []

    while let number = scanner.scanDouble() {
      numbers.append(CGFloat(number))
    }

    // Remember, this is case sensitive
    switch action {
    case "M":
      var previousNumber: CGFloat = 0

      let pairs: [(CGFloat, CGFloat)] = numbers.enumerated().reduce(into: []) { result, enumeration in
        if enumeration.offset == 0 || enumeration.offset.remainderReportingOverflow(dividingBy: 2).overflow {
          previousNumber = enumeration.element
          return
        }

        result.append((previousNumber, enumeration.element))
      }

      return pairs.map { pair -> PathCommand in
        .moveTo(CGPoint(x: pair.0, y: pair.1))
      }
    case "m":
      var previousNumber: CGFloat = 0

      let pairs: [(CGFloat, CGFloat)] = numbers.enumerated().reduce(into: []) { result, enumeration in
        if enumeration.offset == 0 || enumeration.offset.remainderReportingOverflow(dividingBy: 2).overflow {
          previousNumber = enumeration.element
          return
        }

        result.append((previousNumber, enumeration.element))
      }

      return pairs.map { pair -> PathCommand in
        .moveToRelative(dx: pair.0, dy: pair.1)
      }
    case "L":
      var previousNumber: CGFloat = 0

      let pairs: [(CGFloat, CGFloat)] = numbers.enumerated().reduce(into: []) { result, enumeration in
        if enumeration.offset == 0 || enumeration.offset.remainderReportingOverflow(dividingBy: 2).overflow {
          previousNumber = enumeration.element
          return
        }

        result.append((previousNumber, enumeration.element))
      }

      return pairs.map { pair -> PathCommand in
        .lineTo(CGPoint(x: pair.0, y: pair.1))
      }
    case "l":
      var previousNumber: CGFloat = 0

      let pairs: [(CGFloat, CGFloat)] = numbers.enumerated().reduce(into: []) { result, enumeration in
        if enumeration.offset == 0 || enumeration.offset.remainderReportingOverflow(dividingBy: 2).overflow {
          previousNumber = enumeration.element
          return
        }

        result.append((previousNumber, enumeration.element))
      }

      return pairs.map { pair -> PathCommand in
        .lineToRelative(dx: pair.0, dy: pair.1)
      }
    case "H":
      return numbers.map { x in
        return .horizontalLine(x: x)
      }
    case "h":
      return numbers.map { dx in
        return .horizontalLineRelative(dx: dx)
      }
    case "V":
      return numbers.map { y in
        return .verticalLine(y: y)
      }
    case "v":
      return numbers.map { dy in
        return .verticalLineRelative(dy: dy)
      }
    case "C":
      guard numbers.count == 6 else { return [] }

      return [
        .cubicBezierCurve(
          x1: numbers[0],
          y1: numbers[1],
          x2: numbers[2],
          y2: numbers[3],
          x: numbers[4],
          y: numbers[5]
        )
      ]
    case "c":
      guard numbers.count == 6 else { return [] }

      return [
        .cubicBezierCurveRelative(
          dx1: numbers[0],
          dy1: numbers[1],
          dx2: numbers[2],
          dy2: numbers[3],
          dx: numbers[4],
          dy: numbers[5]
        )
      ]
    case "S":
      guard numbers.count == 4 else { return [] }

      return [.smoothCubicBezierCurve(x2: numbers[0], y2: numbers[1], x: numbers[2], y: numbers[3])]
    case "s":
      guard numbers.count == 4 else { return [] }

      return [
        .smoothCubicBezierCurveRelative(
          dx2: numbers[0],
          dy2: numbers[1],
          dx: numbers[2],
          dy: numbers[3]
        )
      ]
    case "Q":
      guard numbers.count == 4 else { return [] }

      return [
        .quadBezierCurve(x1: numbers[0], y1: numbers[1], x: numbers[2], y: numbers[3])
      ]
    case "q":
      guard numbers.count == 4 else { return [] }

      return [
        .quadBezierCurveRelative(dx1: numbers[0], dy1: numbers[1], dx: numbers[2], dy: numbers[3])
      ]
    case "T":
      guard numbers.count == 2 else { return [] }

      return [
        .smoothQuadBezierCurve(x: numbers[0], y: numbers[1])
      ]
    case "t":
      guard numbers.count == 2 else { return [] }

      return [
        .smoothQuadBezierCurveRelative(dx: numbers[0], dy: numbers[1])
      ]
    case "A":
      guard numbers.count == 7 else { return [] }

      let rx = numbers[0]
      let ry = numbers[1]
      let angle = numbers[2]
      let arcFlag = numbers[3] == 1
      let sweepFlag = numbers[4] == 1
      let pointX = numbers[5]
      let pointY = numbers[6]

      return [
        .elipticalArcCurve(
          rx: rx,
          ry: ry,
          angle: angle,
          largeArcFlag: arcFlag,
          sweepFlag: sweepFlag,
          x: pointX,
          y: pointY
        )
      ]
    case "a":
      guard numbers.count == 7 else { return [] }

      let rx = numbers[0]
      let ry = numbers[1]
      let angle = numbers[2]
      let arcFlag = numbers[3] == 1
      let sweepFlag = numbers[4] == 1
      let pointX = numbers[5]
      let pointY = numbers[6]

      return [
        .elipticalArcCurveRelative(
          rx: rx,
          ry: ry,
          angle: angle,
          largeArcFlag: arcFlag,
          sweepFlag: sweepFlag,
          dx: pointX,
          dy: pointY
        )
      ]
    case "Z", "z":
      return [.closePath]
    default:
      return []
    }
  }
}

extension CharacterSet {
  public static let pathCommands = CharacterSet(charactersIn: "MmLlHhVvCcSsQqTtAaZz")
}
