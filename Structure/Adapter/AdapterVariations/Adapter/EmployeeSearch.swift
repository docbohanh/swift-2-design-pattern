//
//  EmployeeSearch.swift
//  Adapter
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class SearchTool {
    enum SearchType {
        case NAME; case TITLE;
    }
    
    private let sources: [EmployeeDataSource]
    
    init(dataSources: EmployeeDataSource...) {
        self.sources = dataSources
    }
    
    var employees: [Employee] {
        var results = [Employee]()
        for source in sources {
            results += source.employees
        }
        return results
    }
    
    func search(text: String, type: SearchType) -> [Employee] {
        var results = [Employee]()
        
        for source in sources {
            results += type == SearchType.NAME ? source.searchByName(text) : source.searchByTitle(text)
        }
        return results
    }
}