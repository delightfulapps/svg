//
//  SVGCircle.swift
//  SVG
//
//  Created by Matthew Delves on 16/1/20.
//  Copyright © 2020 Delightful Apps PTY LTD. All rights reserved.
//

import SwiftUI
import SVGKit

struct SVGCircle: View {
  let element: Node

  var body: some View {
    let fill = Color(element.fill ?? .black)
    let strokeColor = Color(element.stroke ?? .black)
    let strokeWidth = element.strokeWidth ?? 0.0

    let offset = CGPoint(
      x: element.cx ?? 0.0,
      y: element.cy ?? 0.0
    )

    return ZStack {
      Group {
        Circle()
          .fill(fill)
        Circle()
          .stroke(strokeColor, lineWidth: strokeWidth)
      }
    }
    .position(offset)
    .frame(width: element.radius ?? 0.0, height: element.radius ?? 0.0)
  }
}

#if DEBUG
struct SVGCircle_Previews: PreviewProvider {
  static var previews: some View {
//    SVGCircle()
    Text("Placeholder goes here")
  }
}
#endif
