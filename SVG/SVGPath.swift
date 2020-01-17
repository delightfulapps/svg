//
//  SVGPath.swift
//  SVG
//
//  Created by Matthew Delves on 16/1/20.
//  Copyright © 2020 Delightful Apps PTY LTD. All rights reserved.
//

import SwiftUI
import SVGKit

struct SVGPath: View {
  let element: Node

  var body: some View {
    let strokeColor = Color(element.stroke ?? .black)
    let strokeWidth = element.strokeWidth ?? 1.0

    return SVGPathShape(element: element)
      .stroke(strokeColor, lineWidth: strokeWidth)
  }
}

struct SVGPathShape: Shape {
  let element: Node

  func path(in rect: CGRect) -> Path {
    var path = Path()

    element.pathCommands.forEach { command in
      switch command {
      case let .moveTo(point):
        path.move(to: point)
      case let .moveToRelative(dx: dx, dy: dy):
        let currentPoint = path.currentPoint ?? .zero
        let newPoint = CGPoint(
          x: currentPoint.x + dx,
          y: currentPoint.y + dy
        )
        path.move(to: newPoint)
      case let .lineTo(point):
        path.addLine(to: point)
      case let .lineToRelative(dx: dx, dy: dy):
        let currentPoint = path.currentPoint ?? .zero
        let newPoint = CGPoint(
          x: currentPoint.x + dx,
          y: currentPoint.y + dy
        )
        path.addLine(to: newPoint)
      case let .horizontalLine(x: x):
        let currentPoint = path.currentPoint ?? .zero
        let newPoint = CGPoint(
          x: x,
          y: currentPoint.y
        )
        path.addLine(to: newPoint)
      case let .horizontalLineRelative(dx: dx):
        let currentPoint = path.currentPoint ?? .zero
        let newPoint = CGPoint(
          x: currentPoint.x + dx,
          y: currentPoint.y
        )
        path.addLine(to: newPoint)
      case let .verticalLine(y: y):
        let currentPoint = path.currentPoint ?? .zero
        let newPoint = CGPoint(
          x: currentPoint.x,
          y: y
        )
        path.addLine(to: newPoint)
      case let .verticalLineRelative(dy: dy):
        let currentPoint = path.currentPoint ?? .zero
        let newPoint = CGPoint(
          x: currentPoint.x,
          y: currentPoint.y + dy
        )
        path.addLine(to: newPoint)
      case let .cubicBezierCurve(x1: x1, y1: y1, x2: x2, y2: y2, x: x, y: y):
        let endPoint = CGPoint(x: x, y: y)
        let control1 = CGPoint(x: x1, y: y1)
        let control2 = CGPoint(x: x2, y: y2)
        path.addCurve(to: endPoint, control1: control1, control2: control2)
      case let .cubicBezierCurveRelative(dx1: dx1, dy1: dy1, dx2: dx2, dy2: dy2, dx: dx, dy: dy):

        let currentPoint = path.currentPoint ?? .zero
        let endPoint = CGPoint(x: currentPoint.x + dx, y: currentPoint.y + dy)
        let control1 = CGPoint(x: currentPoint.x + dx1, y: currentPoint.y + dy1)
        let control2 = CGPoint(x: currentPoint.x + dx2, y: currentPoint.y + dy2)

        path.addCurve(to: endPoint, control1: control1, control2: control2)
      case let .smoothCubicBezierCurve(x2: x2, y2: y2, x: x, y: y):
        let endPoint = CGPoint(x: x, y: y)
        let control = CGPoint(x: x2, y: y2)
        path.addQuadCurve(to: endPoint, control: control)
      case let .smoothCubicBezierCurveRelative(dx2: dx2, dy2: dy2, dx: dx, dy: dy):

        let currentPoint = path.currentPoint ?? .zero
        let endPoint = CGPoint(
          x: currentPoint.x + dx,
          y: currentPoint.y + dy
        )
        let control = CGPoint(
          x: currentPoint.x + dx2,
          y: currentPoint.y + dy2
        )
        path.addQuadCurve(to: endPoint, control: control)
      case let .quadBezierCurve(x1: x1, y1: y1, x: x, y: y):
        let endPoint = CGPoint(x: x, y: y)
        let control = CGPoint(x: x1, y: y1)
        path.addQuadCurve(to: endPoint, control: control)
      case let .quadBezierCurveRelative(dx1: dx1, dy1: dy1, dx: dx, dy: dy):
        let currentPoint = path.currentPoint ?? .zero
        let endPoint = CGPoint(
          x: currentPoint.x + dx,
          y: currentPoint.y + dy
        )
        let control = CGPoint(
          x: currentPoint.x + dx1,
          y: currentPoint.y + dy1
        )
        path.addQuadCurve(to: endPoint, control: control)
      case let .smoothQuadBezierCurve(x: x, y: y):
        // TODO: Implement this
        break
      case let .smoothQuadBezierCurveRelative(dx: dx, dy: dy):
        // TODO: Implement this
        break
      case let .elipticalArcCurve(rx: rx, ry: ry, angle: angle, largeArcFlag: largeArcFlag, sweepFlag: sweepFlag, x: x, y: y):
        break
      case let .elipticalArcCurveRelative(rx: rx, ry: ry, angle: angle, largeArcFlag: largeArcFlag, sweepFlag: sweepFlag, dx: dx, dy: dy):
        break
      case .closePath:
        path.closeSubpath()
      default: break
      }
    }

    return path
  }
}

#if DEBUG
struct SVGPath_Previews: PreviewProvider {
  static var previews: some View {
//    SVGPath()
    Text("Preview content goes here")
  }
}
#endif
