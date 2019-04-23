//
//  define_typealias.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation

//Indexing for the N matrix
typealias tNi = Int32; // long int
typealias  let_tNi = Int32;// const long int



typealias tQvec = Float;
typealias tForce = Float;

extension Float: DefaultValuable {
    
    static func defaultValue() -> Float {
        return 0.0
    }
    static func defaultValue_InvalidAcess() -> Float {
        return 0.0
        
// only for debugging purpose to detect out-of-array indicies
//        return 9.99
    }
}

//The 3d parameters
typealias t3d = Int; // int
typealias let_t3d = Int // const int


//Type for the Geometry Properties
typealias tGeomShape = Float; // float (variable)
typealias let_tGeomShape = Float; // const float


//type for Geom indexing
typealias tGeomIndex = Int32; // long int: Not smaller than int. At least 32 bits.


//The stepping vars
typealias tStep = Int;


// Migration ones by Vedran:

typealias ULongInt = UInt32// unsigned long int

typealias Matrix2D_array<T: DefaultValuable> = [Matrix2D<T>]
typealias Matrix3D_array<T: DefaultValuable> = [Matrix3D<T>]
