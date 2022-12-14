//
//  LocalAuthPolicy.swift
//  local_auth_crypto
//
//  Created by M on 14/12/2565 BE.
//

import LocalAuthentication

class LocalAuthPolicy {
    
    static func evaluatePolicy(reason: String, completion: @escaping (Bool) -> ()) {
        let context = LAContext()

        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
            // Moves to the main thread because completion triggers UI changes
            DispatchQueue.main.async {
                if success {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
