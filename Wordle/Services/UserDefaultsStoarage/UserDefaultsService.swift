//
//  UserDefaultsService.swift
//  Wordle
//
//  Created by Екатерина Неделько on 20.05.22.
//

import Foundation

class UserDefaultsService {
    static let shared = UserDefaultsService()
    
    private init() { }
    
    func encodeObject<T: Encodable>(_ object: T, for key: UserDefaultsKey) {
        guard let encodedObject = try? JSONEncoder().encode(object) else {
            return
        }
        
        UserDefaults.standard.set(encodedObject, forKey: key.rawValue)
    }
    
    func decodeObject<T: Decodable>(type: T.Type, for key: UserDefaultsKey) -> T? {
        guard let objectData = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }
        
        guard let decodedObject = try? JSONDecoder().decode(type, from: objectData) else {
            return nil
        }
        
        return decodedObject
    }
}
