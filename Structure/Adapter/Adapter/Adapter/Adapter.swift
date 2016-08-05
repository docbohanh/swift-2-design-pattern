//
//  Adapter.swift
//  Adapter
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

extension NewCoDirectory: EmployeeDataSource {
    
    var employees: [Employee] {
        return getStaff().values.map { sv -> Employee in Employee(name: sv.getName(), title: sv.getJob()) }
    }
    
    func searchByName(name: String) -> [Employee] {
        return createEmployees { $0.getName().rangeOfString(name) != nil }
    }
    
    func searchByTitle(title: String) -> [Employee] {
        return createEmployees { $0.getJob().rangeOfString(title) != nil }
    }
    
    private func createEmployees(filter filterClosure: NewCoStaffMember -> Bool) -> [Employee] {
        return getStaff().values
            .filter(filterClosure)
            .map { entry -> Employee in Employee(name: entry.getName(), title: entry.getJob()) }
    }
    
}