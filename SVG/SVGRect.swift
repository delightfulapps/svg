//
//  SVGRect.swift
//  SVG
//
//  Created by Matthew Delves on 15/1/20.
//  Copyright © 2020 Delightful Apps PTY LTD. All rights reserved.
//

import SwiftUI
import SVGKit

struct SVGRect: View {
  let element: Node

  var body: some View {
    let width = element.width
    let height = element.height
    let fill = Color(element.fill ?? .black)
    let cornerRadius = element.cornerRadius ?? 0.0
    let strokeColor = Color(element.stroke ?? .black)
    let strokeWidth = element.strokeWidth ?? 0.0

    let offset = CGSize(
      width: element.x ?? 0.0,
      height: element.y ?? 0.0
    )

    return ZStack {
      Group {
        RoundedRectangle(cornerRadius: cornerRadius)
          .fill(fill)
        RoundedRectangle(cornerRadius: cornerRadius)
          .stroke(strokeColor, lineWidth: strokeWidth)
      }
    }
    .offset(offset)
    .frame(width: width, height: height)
  }
}

#if DEBUG
struct SVGRect_Previews: PreviewProvider {
  static var previews: some View {
//    SVGRect()
    Text("Place preview content here")
  }
}
#endif
