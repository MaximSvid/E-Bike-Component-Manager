//
//  Errors.swift
//  E-Bike Manager
//
//  Created by Maxim Svidrak on 14.05.25.
//

enum Errors: Error {
    case observeError, testError, deleteError, updateError
    
    var message: String {
        switch self {
        case .observeError:
            return "Observation failed"
        case .testError:
            return "Test error"
        case .deleteError:
            return "Delete error"
        case .updateError:
            return "Update error"
        }
    }
}
