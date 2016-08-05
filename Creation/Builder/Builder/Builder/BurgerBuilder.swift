//
//  BurgerBuilder.swift
//  Builder
//
//  Created by HungDo on 8/1/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import Foundation

class BurgerBuilder {
    private var veggie  = false
    private var pickles = false
    private var mayo    = true
    private var ketchup = true
    private var lettuce = true
    private var cooked  = Burger.Cooked.NORMAL
    private var patties = 2
    private var bacon   = true
    
    func setVeggie(choice: Bool)
    {
        self.veggie = choice
        if choice {
            self.bacon = false
        }
    }
    
    func setPickles(choice: Bool)   { self.pickles  = choice }
    func setMayo(choice: Bool)      { self.mayo     = choice }
    func setLettuce(choice: Bool)   { self.lettuce  = choice }
    func setCooked(choice: Burger.Cooked) { self.cooked = choice }
    func addParty(choice: Bool)     { self.patties  = choice ? 3 : 2 }
    func setBacon(choice: Bool)     { self.bacon    = choice }
    
    func buildObject(name: String) -> Burger {
        return Burger(name: name, veggie: veggie, patties: patties, pickles: pickles, mayo: mayo, ketchup: ketchup, lettuce: lettuce, cook: cooked, bacon: bacon)
    }
}