//
//  main.swift
//  Adapter
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

let search = SearchTool(dataSources: SalesDataSource(), DevelopmentDataSource(), NewCoDirectory())

print("--List--")
for e in search.employees {
    print("Name: \(e.name)")
}

print("--Search--")
for e in search.search("VP", type: SearchTool.SearchType.TITLE) {
    print("Name: \(e.name), Title: \(e.title)")
}