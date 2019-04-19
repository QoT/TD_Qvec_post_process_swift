//
//  Node_Dims.swift
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

struct Node_Dims
{
    
    var idi: t3d = 0
    var idj: t3d = 0
    var idk: t3d = 0
    
    var node000: Int = 0
    var ncpu: Int = 0
    var rank: Int = 0
    
    var nthreads: Int = 0
    var numprocs: Int = 0
    
    var x: tNi = 0
    var y: tNi = 0
    var z: tNi = 0
    
};
