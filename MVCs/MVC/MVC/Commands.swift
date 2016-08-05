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
    
    static let ALL = [Command.LIST_PEOPLE, .ADD_PERSON, .DELETE_PERSON, .UPDATE_PERSON, .SEARCH]
    
    static func getFromInput(input: String) -> Command? {
        switch input.lowercaseString {
        case "l": return .LIST_PEOPLE
        case "a": return .ADD_PERSON
        case "d": return .DELETE_PERSON
        case "u": return .UPDATE_PERSON
        case "s": return .SEARCH
        default: return nil
        }
    }
}