//
//  SVGView.swift
//  SVG
//
//  Created by Matthew Delves on 15/1/20.
//  Copyright © 2020 Delightful Apps PTY LTD. All rights reserved.
//

import SwiftUI
import SVGKit

struct SVGView: View {
  let svg: Node
  var body: some View {
    return GeometryReader { proxy -> AnyView in
      let ratio = self.svg.ratio(in: proxy.size)

      return AnyView(
        self.draw(element: self.svg)
          .transformEffect(self.svg.appliedTransforms)
          .transformEffect(CGAffineTransform(scaleX: ratio.width, y: ratio.height))
          .drawingGroup()
      )
    }
  }

  private func draw(element: Node) -> some View {
    ZStack(alignment: .topLeading) {
      ForEach(element.children, id: \.self) { child in
        Group {
          self.rect(for: child)
          self.circle(for: child)
          self.group(for: child)
          self.ellipse(for: child)
          self.line(for: child)
          self.polyline(for: child)
          self.path(for: child)
        }
          .transformEffect(child.appliedTransforms)
      }
    }
  }

  private func rect(for element: Node) -> SVGRect? {
    guard case .rect = element.element else { return nil }

    return SVGRect(element: element)
  }

  private func circle(for element: Node) -> SVGCircle? {
    guard case .circle = element.element else { return nil }

    return SVGCircle(element: element)
  }

  private func group(for element: Node) -> AnyView? {
    guard case .group = element.element else { return nil }

    return AnyView(draw(element: element))
  }

  private func ellipse(for element: Node) -> SVGEllipse? {
    guard case .ellipse = element.element else { return nil }

    return SVGEllipse(element: element)
  }

  private func line(for element: Node) -> SVGLine? {
    guard case .line = element.element else { return nil }

    return SVGLine(element: element)
  }

  private func polyline(for element: Node) -> SVGPolyline? {
    guard case .polyline = element.element else { return nil }

    return SVGPolyline(element: element)
  }

  private func path(for element: Node) -> SVGPath? {
    guard case .path = element.element else { return nil }

    return SVGPath(element: element)
  }
}

#if DEBUG
struct SVGView_Previews: PreviewProvider {
  static var previews: some View {
    let url = Bundle.main.url(forResource: "pathline", withExtension: "svg")!
    let parser = Parser(url: url)

    let svg = parser.svg!

    return ZStack(alignment: .center) {
      SVGView(svg: svg)
        .frame(width: 300, height: 100)
    }
  }
}
#endif
