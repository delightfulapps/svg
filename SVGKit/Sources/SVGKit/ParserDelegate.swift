//
//  ParserDelegate.swift
//  
//
//  Created by Matthew Delves on 6/1/20.
//

import Foundation

final public class ParserDelegate: NSObject, XMLParserDelegate {
  var rootNode: Node?
  var currentNode: Node?

  public func parserDidStartDocument(_ parser: XMLParser) {
  }

  public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
  }

  public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
  }

  public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

    guard let type = Node.Element(rawValue: elementName) else { return }

    let element = Node(element: type, attributes: attributeDict, parent: currentNode)

    let parent = currentNode ?? rootNode
    parent?.children.append(element)
    currentNode = element

    if rootNode == nil {
      rootNode = element
    }
  }

  public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    currentNode = currentNode?.parent
  }
}
