//
//  helper_functions.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation

// migration related

func printMigration(_ text: String, checked: Bool = false) {
    if !checked {
        print("MIGRATION: ", text)
    }
}

func printError(_ text: String) {
    print("ERROR: ", text)
}

func printLog(_ text: String) {
    print("NOTE: ", text)
}

// all rest

protocol DefaultValuable {
    static func defaultValue() -> Self
    static func defaultValue_InvalidAcess() -> Self
}

func sizeof<T>(_ t: T) -> Int {
    return MemoryLayout<T>.size
}


func to_string( _ value: Int) -> String {
    return String(value)
}
func to_string( _ value: Int32) -> String {
    return String(value)
}

extension String {
    func c_str() -> String {
        return self
    }
    
    func find(_ text: String) -> size_t? {
        let r = self.range(of: text)?.lowerBound.utf16Offset(in: self)
        printMigration("to check (UTF-16?)-> find('\(text)' in '\(self)' returns range '\(String(describing: r))')",checked: true)
        return self.range(of: text)?.lowerBound.utf16Offset(in: self)
    }
    
    func npos() -> Int? {
        return nil
    }
}

func load_json<T: Decodable>(dir: String, file: String) throws -> T? {
    
    let dirURL = URL(fileURLWithPath: dir)
    
    let fileURL = dirURL.appendingPathComponent(file)

    printMigration("Check if load_json<T: Decodable>(dir: String, file: String) returns valid file path")
    return try load_json(file: fileURL.absoluteString)
}

func load_json<T: Decodable>(file: String) throws -> T? {
    
    let fileURL = URL(fileURLWithPath: file)

    if let jsonFile:String = try? String(contentsOf: fileURL) {
        
        
        if let json = jsonFile.data(using: .utf8) {
            
            do {
                
                let myStruct = try JSONDecoder().decode(T.self, from: json) //{
                    
                    return myStruct
                
            }
            catch
            {
                printError(error.localizedDescription)
                print(error)
                
                throw error
            }
            
            
            
            
        } else {
            printError("Cannot convert to json text to json Data")
        }
        
    } else {
        printError("Cannot read json file at " + file)
        
    }
    return nil
}
