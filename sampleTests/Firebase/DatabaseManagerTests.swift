//
//  DatabaseManagerTests.swift
//  sampleTests
//
//  Created by Leandro Berli on 18/10/2022.
//

import XCTest
@testable import sample

final class DatabaseManagerTests: XCTestCase {
    
    var sut: DatabaseManager!

    override func setUpWithError() throws {
        sut = DatabaseManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testSaveUser() throws {
        sut.saveNameForUser(withId: "41AyJV24zHRS3xeU0CDsUtQl01S2", name: "Leandro")
    }
    

}
