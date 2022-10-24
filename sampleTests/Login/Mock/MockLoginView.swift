//
//  MockLoginView.swift
//  sampleTests
//
//  Created by Leandro Berli on 24/10/2022.
//

import Foundation
@testable import sample

class MockLoginView: EmailLoginViewProtocol {
    var presenter: sample.LoginPresenterProtocol?
    
    func didReceivedAuthError() {
        
    }
}
