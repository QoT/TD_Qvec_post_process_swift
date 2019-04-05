//
//  main.swift
//  TD_Qvec_PP_swift
//
//  Created by Nile Ó Broin on 29/03/2019.
//  Copyright © 2019 Nile Ó Broin. All rights reserved.
//

import Foundation

//import define_typealias
//import Input_Files_V4
//import PostProcessing_Dims

typealias t3d = Int
typealias tNi = Int32
typealias tQvec = Float32
typealias tGeomShape = Float32
typealias tStep = Int16
//typealias





let vort: Bool = CommandLine.arguments.contains("-v")
let print_log: Bool = CommandLine.arguments.contains("-p")
let uxuyuz: Bool = CommandLine.arguments.contains("-u")
let overwrite: Bool = CommandLine.arguments.contains("-o")


//String temporal_data_points_path = CommandLine.contains("-t")
//Int nthreads = CommandLine.contains("-n")


var dirs = [String]()


if let indexOfD = CommandLine.arguments.firstIndex(of: "-d") {

    //TOFIX probably many directories
    dirs.append(CommandLine.arguments[indexOfD + 1])

}


let dir = dirs[0]

let PP_dim_filename = "Post_Processing_Dims_dims.0.0.0.V4.json"


let PP: PP_Dim = load_json(dir: dir, file: StringPP_dim_filename)

let plotname = Input_Files_V4.get_plot_type_from_directory(dir: dir);


var Q_plane = [[tQvec]]()
var F_plane = [[tQvec]]()

var rho = [tQvec]()
var ux = [tQvec]()
var uy = [tQvec]()
var uz = [tQvec]()















