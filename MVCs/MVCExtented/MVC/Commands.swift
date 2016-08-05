//
//  Commands.swift
//  MVC
//
//  Created by HungDo on 8/5/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

enum Command: String {
    case LIST_PEOPLE = "L: List People"
    case ADD_PERSON = "A: Add Person"
    case DELETE_PERSON = "D: Delete Person"
    case UPDATE_PERSON = "U: Update Person"
    case SEARCH = "S: Search"
    case LIST_CITIES = "LC: List Cities"
    case SEARCH_CITIES = "SC: Search Cities"
    case DELETE_CITY = "DC: Delete City"
    
    static let ALL = [Command.LIST_PEOPLE, .ADD_PERSON, .DELETE_PERSON, .UPDATE_PERSON, .SEARCH, .LIST_CITIES, .SEARCH_CITIES, .DELETE_CITY]
    
    static func getFromInput(input: String) -> Command? {
        switch input.lowercaseString {
        case "l": return .LIST_PEOPLE
        case "a": return .ADD_PERSON
        case "d": return .DELETE_PERSON
        case "u": return .UPDATE_PERSON
        case "s": return .SEARCH
        case "lc": return .LIST_CITIES
        case "sc": return .SEARCH_CITIES
        case "dc": return .DELETE_CITY
        default: return nil
        }
    }
}