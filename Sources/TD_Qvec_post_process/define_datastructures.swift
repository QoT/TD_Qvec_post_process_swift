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

func array<T>(grid: inout [T], generating t: () -> T, count: Int) {
    for _ in 0..<count {
        grid.append(t())
    }
}

struct Matrix1D<T: DefaultValuable> {
    
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
        
        grid = Array()
        array(grid: &grid, generating: T.defaultValue, count: rows)
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
        
        // this form of array creation is valid only for pass-by-value content types like Float, Int, structs but not for classes
        grid = Array(repeating: T.defaultValue(), count: (rows+2) * (columns+2))

    }
    
    static func array(rows: Int, columns: Int, count: Int) -> [Matrix2D<T>] {

        var array = Array<Matrix2D<T>>()
        for _ in 0..<count {
            array.append(Matrix2D<T>(rows: rows, columns: columns))
        }
        
        return array
    }
    
    func array<T>(grid: inout [T], generating t: () -> T, count: Int) {
        for _ in 0..<count {
            grid.append(t())
        }
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
        
        // this form of array creation is valid only for pass-by-value content types like Float, Int, structs but not for classes
        grid = Array(repeating: T.defaultValue(), count: (rows+2) * (columns+2) * (planes+2))
    }

    static func array(rows: Int, columns: Int, planes: Int, count: Int) -> [Matrix3D<T>] {
        
        var array = Array<Matrix3D<T>>()
        for _ in 0..<count {
            array.append(Matrix3D<T>(rows: rows, columns: columns, planes: planes))
        }
        
        return array
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
