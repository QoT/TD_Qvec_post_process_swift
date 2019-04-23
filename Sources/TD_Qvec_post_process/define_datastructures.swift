//
//  define_datastructures.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation

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

let toCorrectInvalidArrayIndicies = true

struct Matrix2D<T: DefaultValuable> {
    
    let rows: Int32, columns: Int32
    var grid: [T]
    init(rows: Int32, columns: Int32) {
        
        printMigration("use Matrix as 2D", checked: true)
        self.rows = rows
        self.columns = columns

        printMigration("Matrix2D - It seems quite strange since col,row goes beyond array dim so fix it - guard out-of-array access", checked: true)
        
        // this form of array creation is valid only for pass-by-value content types like Float, Int, structs but not for classes
        grid = Array(repeating: T.defaultValue(), count: Int(self.rows) * Int(self.columns))

    }
    
    static func array(rows: Int32, columns: Int32, count: Int32) -> [Matrix2D<T>] {

        var array = Array<Matrix2D<T>>()
        for _ in 0..<count {
            array.append(Matrix2D<T>(rows: rows, columns: columns))
        }
        
        return array
    }
    
    func array<T>(grid: inout [T], generating t: () -> T, count: Int32) {
        for _ in 0..<count {
            grid.append(t())
        }
    }
    func indexIsValid(row: Int32, column: Int32) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    func offset(column: Int32, row: Int32) -> Int {
        let columnOffset = column * rows
        
        return Int(columnOffset + row)

    }
    subscript(column: Int32, row: Int32) -> T {
        
        // 2D at the end
        
        get {

            if indexIsValid(row: row, column: column) {
                return grid[offset(column: column, row: row)]
            } else {
                if toCorrectInvalidArrayIndicies {
                    var column2 = column
                    var row2 = row
                    
                    if row2 == rows {
                        column2 += 1
                        row2 = 0
                    }
                    if indexIsValid(row: row2, column: column2) {
                        return grid[offset(column: column2, row: row2)]
                    } else {
                        return T.defaultValue_InvalidAcess()
                    }
                } else {
                    assert(indexIsValid(row: row, column: column), "Index out of range")
                    return T.defaultValue()
                }
            }
        }
        set {
            if indexIsValid(row: row, column: column) {
                grid[offset(column: column, row: row)] = newValue
            } else {
                if toCorrectInvalidArrayIndicies {
                    var column2 = column
                    var row2 = row
                    
                    if row2 == rows {
                        column2 += 1
                        row2 = 0
                    }
                    if indexIsValid(row: row2, column: column2) {
                        grid[offset(column: column2, row: row2)] = newValue
                    } else {
                    }
                } else {
                    assert(indexIsValid(row: row, column: column), "Index out of range")
                }
            }
        }
    }
    
}

struct Matrix3D<T: DefaultValuable> {

    let rows: Int32, columns: Int32, planes: Int32
    var grid: [T]
    init(rows: Int32, columns: Int32, planes: Int32) {
        
        printMigration("use Matrix as 3D", checked: true)
        printMigration("Matrix2D - It seems quite strange since col,row goes beyond array dim so fix it - guard out-of-array access", checked: false)
        self.rows = rows
        self.columns = columns
        self.planes = planes

        // this form of array creation is valid only for pass-by-value content types like Float, Int, structs but not for classes
        grid = Array(repeating: T.defaultValue(), count: Int((self.rows) * (self.columns) * (self.planes)))
    }

    static func array(rows: Int32, columns: Int32, planes: Int32, count: Int32) -> [Matrix3D<T>] {
        
        var array = Array<Matrix3D<T>>()
        for _ in 0..<count {
            array.append(Matrix3D<T>(rows: rows, columns: columns, planes: planes))
        }
        
        return array
    }
    

    func indexIsValid(row: Int32, column: Int32, plane: Int32) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns && plane >= 0 && plane < planes
    }
    func offset(column: Int32, row: Int32, plane: Int32) -> Int {
        let columnOffset = column * rows * planes
        let rowOffset = row * planes
        
        return Int(columnOffset + rowOffset + plane)
    }
    subscript(column: Int32, row: Int32, plane: Int32) -> T {
        
        // 1D by now, 3D at the end
        // try 3D now...

        get {
            if indexIsValid(row: row, column: column, plane: plane) {
                return grid[offset(column: column, row: row, plane: plane)]
            } else {
                if toCorrectInvalidArrayIndicies {
                    var column2 = column
                    var row2 = row
                    var plane2 = plane

                    if plane2 == planes {
                        row2 += 1
                        plane2 = 0
                    }
                    if row2 == rows {
                        column2 += 1
                        row2 = 0
                    }
                    if indexIsValid(row: row2, column: column2, plane: plane2) {
                        return grid[offset(column: column2, row: row2, plane: plane2)]
                    } else {
                        return T.defaultValue_InvalidAcess()
                    }
                    
                } else {
                    assert(indexIsValid(row: row, column: column, plane: planes), "Index out of range")
                    return T.defaultValue()
                }
            }

        }
        set {

            if indexIsValid(row: row, column: column, plane: plane) {
                grid[offset(column: column, row: row, plane: plane)] = newValue
            } else {
                if toCorrectInvalidArrayIndicies {
                    var column2 = column
                    var row2 = row
                    var plane2 = plane
                    
                    if plane2 == planes {
                        row2 += 1
                        plane2 = 0
                    }
                    if row2 == rows {
                        column2 += 1
                        row2 = 0
                    }
                    if indexIsValid(row: row2, column: column2, plane: plane2) {
                        grid[offset(column: column2, row: row2, plane: plane2)] = newValue
                    } else {
                    }
                    
                } else {
                    assert(indexIsValid(row: row, column: column, plane: planes), "Index out of range")
                }
            }
        }
    }
    
}
