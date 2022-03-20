//
//  ValidationServiceTests.swift
//  Just Start Testing Tests
//
//  Created by Rafael Plinio on 19/03/22.

import XCTest
@testable import Just_Start_Testing

class ValidationServiceTests: XCTestCase {

    var validation: ValidationService!

    override func setUp() {
        super.setUp()
        validation = ValidationService()
    }
    
    override func tearDown() {
        super.tearDown()
        validation = nil
    }
    
    func test_isValidUsername() throws {
       XCTAssertNoThrow(try validation.validateUsername(username: "rafa test"))
    }
    
    func test_usernameIsNil() throws {
        let expectedError = ValidationError.invalidValue
        var error: ValidationError?
        
        XCTAssertThrowsError(try validation.validateUsername(username: nil)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_usernameTooLong() throws {
        let expectedError = ValidationError.usernameTooLong
        var error: ValidationError?
        let longUsername = "a very long username"
        
        XCTAssertTrue(longUsername.count == 20)
        
        XCTAssertThrowsError(try validation.validateUsername(username: longUsername)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_usernameTooShort() throws {
        let expectedError = ValidationError.usernameTooShort
        var error: ValidationError?
        let shortUsername = "abc"
        
        XCTAssertThrowsError(try validation.validateUsername(username: shortUsername)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_passwordTooLong() throws {
        let expectedError = ValidationError.passwordTooLong
        var error: ValidationError?
        let longPassword = "a very long password here"

        XCTAssertThrowsError(try validation.validatePassword(password: longPassword)) { thrownError in
            error = thrownError as? ValidationError
        }

        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_passwordTooShort() throws {
        let expectedError = ValidationError.passwordTooShort
        var error: ValidationError?
        let shortPassword = "123"
        
        XCTAssertThrowsError(try validation.validatePassword(password: shortPassword)) { thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
    
    func test_invalidCredentials() throws {
        let expectedError = LoginError.invalidCredentials
        var error: LoginError?
        let username = "rafael"
        let password = "my password is very long"
        
        XCTAssertThrowsError(try validation.validateCredentials(username: username, password: password)) { thrownError in
            error = thrownError as? LoginError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(expectedError.errorDescription, error?.errorDescription)
    }
}
