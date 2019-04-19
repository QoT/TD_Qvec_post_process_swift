//
//  define_datastructures.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation

//
//  Header.h
//  TD_GeomInput_Rushton_Turbine
//
//  Created by Nile Ó Broin on 13/02/2019.
//  Copyright © 2019 Nile Ó Broin. All rights reserved.
//

struct Node_Bounds {
    var i0: tNi = 0;
    var i1: tNi = 0;
    
    var j0: tNi = 0;
    var j1: tNi = 0;
    
    var k0: tNi = 0;
    var k1: tNi = 0;    
};

struct Matrix1D<T: DefaultValuable>: TypeResolving {
    
//    // this relates to Matrix content, not Matrix itself
//    static func defaultValue() -> Matrix1D<T> {
//        return Matrix1D<T>(rows: 1)
//    }
    
    static func contentType() -> Any.Type {
        return T.self
    }

    let rows: Int
    var grid: [T]
    
    init() {
        self.init(rows: 0)
    }
    
    init(rows: Int) {
        
        self.rows = rows
        
        grid = Array(repeating: T.defaultValue(), count: rows)
    }
    func indexIsValid(row: Int) -> Bool {
        return row >= 0 && row < rows
    }
    subscript(row: Int) -> T {
        
        get {
            assert(indexIsValid(row: row), "Index out of range")
            
            let rowOffset = row
            
            return grid[rowOffset]
        }
        set {
            assert(indexIsValid(row: row), "Index out of range")
            
            let rowOffset = row

            grid[rowOffset] = newValue
        }
    }
    
}

struct Matrix2D<T: DefaultValuable> {
    
    let rows: Int, columns: Int
    var grid: [T]
    init(rows: Int, columns: Int) {
        
        printMigration("use Matrix as 2D")
        self.rows = rows
        self.columns = columns
        
//        grid = Array(repeating: T.defaultValue(), count: rows * columns)
        
        printMigration("Matrix2D - It seems quite strange since col,row goes beyond array dim so fix it - add +2 for all axis")
        grid = Array(repeating: T.defaultValue(), count: (rows+2) * (columns+2))

    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row_column: Int32) -> T {
        
        // 1D by now
        
        get {
//            assert(indexIsValid(row: row, column: column), "Index out of range")
            
            return grid[Int(row_column)]
        }
        set {
//            assert(indexIsValid(row: row, column: column), "Index out of range")
            
            grid[Int(row_column)] = newValue
        }
    }
    subscript(row: Int, column: Int) -> T {
        
        // 2D at the end
        
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            
            let rowOffset = row * columns
            
            return grid[rowOffset + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            
            let rowOffset = row * columns
            
            grid[rowOffset + column] = newValue
        }
    }
    
}

struct Matrix3D<T: DefaultValuable> {

    let rows: Int, columns: Int, planes: Int
    var grid: [T]
    init(rows: Int, columns: Int, planes: Int) {
        
        printMigration("use Matrix as 3D")
        self.rows = rows
        self.columns = columns
        self.planes = planes
        
//        grid = Array(repeating: T.defaultValue(), count: rows * columns * planes)
        
        printMigration("Matrix3D - It seems quite strange since col,row goes beyond array dim so fix it - add +2 for all axis")
        grid = Array(repeating: T.defaultValue(), count: (rows+2) * (columns+2) * (planes+2))
    }
    func indexIsValid(row: Int, column: Int, plane: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns && plane >= 0 && plane < planes
    }
    subscript(row_column_plane: Int32) -> T {
        
        // 1D by now
        
        get {
            return grid[Int(row_column_plane)]
        }
        set {
            grid[Int(row_column_plane)] = newValue
        }
    }
    subscript(row: Int, column: Int, plane: Int) -> T {
        
        // 1D by now, 3D at the end
        // try 3D now...

        get {
            assert(indexIsValid(row: row, column: column, plane: plane), "Index out of range")
            
            let rowOffset = row * columns
            let planeOffset = plane * rows * columns
            
            return grid[planeOffset + rowOffset + column]
        }
        set {
            assert(indexIsValid(row: row, column: column, plane: plane), "Index out of range")
            
            let rowOffset = row * columns
            let planeOffset = plane * rows * columns
            
            grid[planeOffset + rowOffset + column] = newValue
        }
    }
    
}

//protocol Streamable {
//    func allProperties() throws -> [String: Any]
//}

//extension Streamable {
//    func allProperties() throws -> [String: Any] {
//
//        var result: [String: Any] = [:]
//
//        let mirror = Mirror(reflecting: self)
//
//        // Optional check to make sure we're iterating over a struct or class
//        guard let style = mirror.displayStyle, style == .struct || style == .class else {
//            throw NSError()
//        }
//
//        for (property, value) in mirror.children {
//            guard var property = property else {
//                continue
//            }
//            result[property] = value
//        }
//
//        return result
//    }
//
//    func read( from file: UnsafeMutablePointer<FILE>) {
//
////        do {
////            print(try self.allProperties())
////        } catch {
////            printError(error.localizedDescription)
////        }
//
////        let fp: UnsafeMutablePointer<FILE>! = fopen(filename.c_str(), "r");
//
//        //    fread(tmp, sizeof(tDisk), q.bin_file_size_in_structs, fp);
//
//
//        var bytesPointer = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
////        bytesPointer.storeBytes(of: 0xFFFF_FFFF, as: UInt32.self)
////
////        // Load a value from the memory referenced by 'bytesPointer'
////        let x = bytesPointer.load(as: UInt8.self)       // 255
////
////        // Load a value from the last two allocated bytes
////        let offsetPointer = bytesPointer + 2
////        let y = offsetPointer.load(as: UInt16.self)     // 65535
//
//        var number: UInt8 = 3
//        var r2 = fread(UnsafeMutableRawPointer(&number), 1, sizeof(number), file);
//        print(number)
//         r2 = fread(UnsafeMutableRawPointer(&number), 1, sizeof(number), file);
//        print(number)
//         r2 = fread(UnsafeMutableRawPointer(&number), 1, sizeof(number), file);
//        print(number)
//         r2 = fread(UnsafeMutableRawPointer(&number), 1, sizeof(number), file);
//        print(number)
//        r2 = fread(UnsafeMutableRawPointer(&number), 1, sizeof(number), file);
//        print(number)
//
//        let r = fread(bytesPointer, 1, 16, file);
//
//
////        let u = UnsafeMutableRawPointer(&number)//.load(as: Int.self)
//        UnsafeMutableRawPointer(&number).copyMemory(from: bytesPointer, byteCount: sizeof(number))
//
//
//
//        var x = bytesPointer.load(as: UInt8.self)
//print(x)
//        bytesPointer = bytesPointer.advanced(by: 1)
//        x = bytesPointer.load(as: UInt8.self)
//        print(x)
//        bytesPointer = bytesPointer.advanced(by: 1)
//        x = bytesPointer.load(as: UInt8.self)
//        print(x)
//        bytesPointer = bytesPointer.advanced(by: 1)
//        x = bytesPointer.load(as: UInt8.self)
//        print(x)
//        bytesPointer = bytesPointer.advanced(by: 1)
//        x = bytesPointer.load(as: UInt8.self)
//        print(x)
//        bytesPointer = bytesPointer.advanced(by: 1)
//        x = bytesPointer.load(as: UInt8.self)
//        print(x)
//        bytesPointer = bytesPointer.advanced(by: 1)
//        x = bytesPointer.load(as: UInt8.self)
//        print(x)
////                let offsetPointer = bytesPointer + 2
////        x = offsetPointer.load(as: UInt8.self)
////        print(x)
//
////        var i: Int = 0
////        let a: UnsafeMutableRawPointer = UnsafeMutableRawPointer(0)
////        fread(a, sizeof(Int), 1, file);
////        i = *a
//
//        printMigration("read data from input file")
//        //    fread(resultPointer, 1, size, fp)
//
//        bytesPointer.deallocate()
////        fclose(fp);
//
//    }
//}
