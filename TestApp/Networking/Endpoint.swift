//
//  Endpoint.swift
//

import Foundation

public protocol Endpoint {
  var compositePath: String { get }       // только путь внутри API
  var headers: [String:String] { get }
  var parameters: [String:String]? { get }
}

public extension Endpoint {
  var parameters: [String:String]? { nil }
}

/// Пути **относительно** /api/v1
public enum EntityEndpoint: Endpoint {
  case events(page: Int)
  case eventDetail(id: Int)
  
  case meets(page: Int, userId: Int?)
  case meetDetail(id: Int)
  
  case faculties(page: Int)
  case facultyDetail(id: Int)
  
  case communities(page: Int)
  case communityDetail(id: Int)

  public var compositePath: String {
    switch self {
    case .events:              return "/events"
    case .eventDetail(let id): return "/events/\(id)"
      
    case .meets:               return "/meets"
    case .meetDetail(let id):  return "/meets/\(id)"
      
    case .faculties:           return "/faculties"
    case .facultyDetail(let id): return "/faculties/\(id)"
      
    case .communities:         return "/communities"
    case .communityDetail(let id): return "/communities/\(id)"
    }
  }

  public var parameters: [String:String]? {
    switch self {
    case .events(let page),
         .faculties(let page),
         .communities(let page):
      return ["page":"\(page)"]
    case .meets(let page, let userId):
      var p = ["page":"\(page)"]
      if let u = userId { p["user_id"] = "\(u)" }
      return p
    default:
      return nil
    }
  }

  public var headers: [String:String] {
    [
      "Content-Type": "application/json",
      "Accept":       "application/json"
    ]
  }
}

