//
//  main_Qvec_pp.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation
import Utility


//
//  main_Qvec_pp.cpp
//  TD-Qvec-post-process
//
//  Created by Nile Ó Broin on 02/01/2019.
//  Copyright © 2019 Nile Ó Broin. All rights reserved.
//

func main(argc: Int, argv: [String]) -> Int {

    printLog("main")


    var requested_threads: Int = 0;
    var overwrite: Bool = false
    var print_to_screen: Bool = false

    var vort: Bool = false
    var single: Bool = false

    var temporal_data_points_path: String = "";

//    std::vector<std::string> dirs;
    var dirs: [Substring] = [Substring]()
    
//    cxxopts::Options options("MyProgram", "Turbulent Dynamics Qvec Post Processing");
//
//    options.add_options()
//    ("n,nthreads", "Request number of OpenMP threads", cxxopts::value<int>())
//    ("o,overwrite", "Overwrite files if they exist", cxxopts::value<bool>())
//    ("p,print", "Print to screen", cxxopts::value<bool>())
//
//    ("v,vort", "Vorticity (use center plane cut directory)", cxxopts::value<bool>())
//    ("u,uxuyuz", "Single Vector Files", cxxopts::value<bool>())
//
//
//    ("t,temporal_data_points_path", "Temporal Data Points file for Spectrum", cxxopts::value<std::string>())
//
//
//    ("d,dirs", "Directories", cxxopts::value<std::vector<std::string>>(), "FILE")
//
//    ("h,help", "Print help")
//    ;
//
//    auto result = options.parse(argc, argv);
//
//
//
//    if (result.count("nthreads")) {
//        requested_threads = result["nthreads"].as<int>();
//    }
//    if (result.count("overwrite")) {
//        overwrite = result["overwrite"].as<bool>();
//    }
//    if (result.count("print")) {
//        print_to_screen = result["print"].as<bool>();
//    }
//
//    if (result.count("vort")) {
//        vort = result["vort"].as<bool>();
//    }
//    if (result.count("uxuyuz")) {
//        single = result["uxuyuz"].as<bool>();
//    }
//
//    if (result.count("temporal_data_points_path")) { temporal_data_points_path = result["temporal_data_points_path"].as<std::string>();
//    }
//
//    if (result.count("dirs")) {
//        dirs = result["dirs"].as<std::vector<std::string>>();
//    }
//
//
//    //-------------------------------------------------------------



    var nthreads: Int = 1;
    
    // The first argument is always the executable, drop it
    let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())
    
    let parser = ArgumentParser(usage: "<options>", overview: "Turbulent Dynamics Qvec Post Processing")
    
    let nthreadsArg: OptionArgument<Int> = parser.add(option: "-nthreads", shortName: "-n", kind: Int.self, usage: "Request number of OpenMP threads")
    let overwriteArg: OptionArgument<Bool> = parser.add(option: "-overwrite", shortName: "-o", kind: Bool.self, usage: "Overwrite files if they exist")
    let printArg: OptionArgument<Bool> = parser.add(option: "-print", shortName: "-p", kind: Bool.self, usage: "Print to screen")
    let vortArg: OptionArgument<Bool> = parser.add(option: "-vort", shortName: "-v", kind: Bool.self, usage: "Vorticity (use center plane cut directory)")
    
    // PathArgument
    let uxuyuzArg: OptionArgument<Bool> = parser.add(option: "-uxuyuz", shortName: "-u", kind: Bool.self, usage: "Single Vector Files")

//    StringEnumArgument
    let temporal_data_points_pathArg: OptionArgument<String> = parser.add(option: "-temporal_data_points_path", shortName: "-t", kind: String.self, usage: "Temporal Data Points file for Spectrum")
    
    printMigration("check Directories to accept array od Strings")
    let dirsArg: OptionArgument<String> = parser.add(option: "-dirs", shortName: "-d", kind: String.self, usage: "Directories")
    
    let helpArg: OptionArgument<String> = parser.add(option: "-help", shortName: "-h", kind: String.self, usage: "Print Help")
    
    func processArguments(arguments: ArgumentParser.Result) {
        //    unsupported
        if let integer = arguments.get(nthreadsArg) {
            requested_threads = integer
        }
        if arguments.get(overwriteArg) == true {
            overwrite = true
        }
        if arguments.get(printArg) == true {
            print_to_screen = true
        }
        if arguments.get(vortArg) == true {
            vort = true
        }
        if arguments.get(uxuyuzArg) == true {
            single = true
        }
        if let string = arguments.get(temporal_data_points_pathArg) {
            temporal_data_points_path = string
        }
        
        printMigration("check if dirs can accept multiple strings")
        if let string = arguments.get(dirsArg) {
            printMigration("Check if splitting dirs is okay")
            dirs = string.split(separator: " ")
        }
    }
    
    do {
        let parsedArguments = try parser.parse(arguments)
        processArguments(arguments: parsedArguments)
    }
    catch let error as ArgumentParserError {
        printError(error.description)
    }
    catch let error {
        printError(error.localizedDescription)
    }
    
//    unsupported
//    #if _OPENMP
//    int avail_nthreads = omp_get_max_threads();
//
//
//    if (requested_threads == 0) nthreads = avail_nthreads;
//    else if (requested_threads > avail_nthreads) nthreads = avail_nthreads;
//    else nthreads = requested_threads;
//
//    //Too many threads can crash because of disk access
//    omp_set_num_threads(nthreads);
//
//    //Necessary for the "collapse" for loop openmp parts to work
//    omp_set_nested(1);
//
//    #endif
//    std::cout << "nthreads " << nthreads << std::endl;
    





//    std::vector<turbSpec_point> turbSpec_points;
    var turbSpec_points: [turbSpec_point] = []

    printMigration("unimplemented: temporal_data_points_path")
//    if (temporal_data_points_path != "")
//    {
//        load_temporal_spectrum(temporal_data_points_path, turbSpec_points);
//
//        search_and_output_turbSpec_points(dirs, print_to_screen, turbSpec_points);
//    }



    
    var input: Input_FILES_V4 = Input_FILES_V4()


//    for (auto load_dir : dirs) {
    for load_dir in dirs {

        var load_dir = String(load_dir)
        
//        std::cout<<load_dir<<std::endl;
        printLog(load_dir)
        
        let handle_pp: Handle_PP_Dims = Handle_PP_Dims()
        var pp: PP_Dims = handle_pp.get_from_node000_from_filepath(load_dir);

        let plotname: String = input.get_plot_type_from_directory(&load_dir);



//        tQvec* Q_plane[5];
//        tQvec* F_plane[5];
//
//        tQvec* rho[5];
//        tQvec* ux[5];
//        tQvec* uy[5];
//        tQvec* uz[5];
        
        let matrix_tQvec_3D = Matrix3D<tQvec>(rows: Int(pp.total_width), columns: Int(pp.total_height), planes: pp.Q_output_length)
        let matrix_tQvec_2D = Matrix2D<tQvec>(rows: Int(pp.total_width), columns: Int(pp.total_height))
        let matrix_tForce_3D = Matrix3D<tForce>(rows: Int(pp.total_width), columns: Int(pp.total_height), planes: 3)

        var Q_plane: Matrix3D_array<tQvec> = Array(repeating: matrix_tQvec_3D, count: 5)
        
        // C++ migration discrepancy: F_plane was initialised as *tForce while later silently transformed into *tQvec (which resloves to the same 'Float' type so no big deal)
        var F_plane: Matrix3D_array<tForce> = Array(repeating: matrix_tForce_3D, count: 5)
        
        var rho: Matrix2D_array<tQvec> = Array(repeating: matrix_tQvec_2D, count: 5)
        var ux: Matrix2D_array<tQvec> = Array(repeating: matrix_tQvec_2D, count: 5)
        var uy: Matrix2D_array<tQvec> = Array(repeating: matrix_tQvec_2D, count: 5)
        var uz: Matrix2D_array<tQvec> = Array(repeating: matrix_tQvec_2D, count: 5)


        var num_layers: Int = 1;
        if (vort && plotname == "rotational_capture") {
            num_layers = 5;
        }
        else if (vort) {
            num_layers = 3;
        }
        
//        for (int layer = 0; layer < num_layers; layer++){
//            Q_plane[layer] = (tQvec *)calloc(pp.total_height * pp.total_width * pp.Q_output_length, sizeof(tQvec));
//            F_plane[layer] = (tForce *)calloc(pp.total_height * pp.total_width * 3, sizeof(tForce));
//
//
//            rho[layer]  = (tQvec *)calloc(pp.total_height * pp.total_width, sizeof(tQvec));
//
//            ux[layer]   = (tQvec *)calloc(pp.total_height * pp.total_width, sizeof(tQvec));
//            uy[layer]   = (tQvec *)calloc(pp.total_height * pp.total_width, sizeof(tQvec));
//            uz[layer]   = (tQvec *)calloc(pp.total_height * pp.total_width, sizeof(tQvec));
//        }

//        tQvec* uxyz_log_vort = (tQvec *)malloc(sizeof(tQvec) * pp.total_height * pp.total_width);
        var uxyz_log_vort: Matrix2D<tQvec> = matrix_tQvec_2D



        input.load_plane(num_layers, &load_dir, &Q_plane, &F_plane, &pp);


        calc_rho_ux_uy_uz(num_layers, Q_plane, F_plane, &rho, &ux, &uy, &uz, &pp);



        if (vort) {
            calc_vorticity(&input, &load_dir, &pp, ux, &uxyz_log_vort, uy, uz);
        }




        var output: Int = 0;

        write_file_with_border(0, load_dir, "Qvec_rho.bin", &rho[output], &pp);

        write_file_with_border(0, load_dir, "Qvec_ux.bin", &ux[output], &pp);
        write_file_with_border(0, load_dir, "Qvec_uy.bin", &uy[output], &pp);
        write_file_with_border(0, load_dir, "Qvec_uz.bin", &uz[output], &pp);


        write_file_with_border(1, load_dir, "Qvec_uxyz_log_vort.bin", &uxyz_log_vort, &pp);






        //        write_file_with_border_in_TEXT(1, load_dir, "Qvec_rho.text", rho[output], pp);
        //
        //        write_file_with_border_in_TEXT(1, load_dir, "Qvec_ux.text", ux[output], pp);
        //        write_file_with_border_in_TEXT(1, load_dir, "Qvec_uy.text", uy[output], pp);
        //        write_file_with_border_in_TEXT(1, load_dir, "Qvec_uz.text", uz[output], pp);
        //
        //
        //        write_file_with_border_in_TEXT(1, load_dir, "Qvec_uxyz_log_vort.text", uxyz_log_vort, pp);



    }//end of dirs


    return 0
}//end of main









