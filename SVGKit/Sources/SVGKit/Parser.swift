//
//  Parser.swift
//  
//
//  Created by Matthew Delves on 6/1/20.
//

import Foundation

public final class Parser {
  var xmlDelegate: ParserDelegate
  var url: URL

  public init(url: URL) {
    xmlDelegate = ParserDelegate()
    self.url = url
  }

  public var svg: Node? {
    guard let parser = XMLParser(contentsOf: url) else { return nil }

    parser.delegate = xmlDelegate
    parser.parse()

    return xmlDelegate.rootNode
  }
}
