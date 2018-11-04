//
//  ExchangeRateTests.swift
//  ExchangeRateTests
//
//  Created by Linxmap on 04/11/2018.
//  Copyright © 2018 KM LTD. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import ExchangeRate

class ExchangeRateTests: QuickSpec {

    override func spec() {
        describe("Exchange Rate") {
            it("returns currenty") {
                expect(true).to(beTrue())
            }
        }
    }

}
