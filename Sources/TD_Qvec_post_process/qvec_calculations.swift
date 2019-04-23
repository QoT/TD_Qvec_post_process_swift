//
//  qvec_calculations.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 17/04/2019.
//

import Foundation

func write_file_with_border( _ b: tNi, _ dir: String, _ filename: String, _ data: Matrix2D<tQvec>, _ pp: PP_Dims) {
    var data = data
    let filepath: String = dir + "/" + filename;
    
    let fp_output: UnsafeMutablePointer<FILE>! = fopen(filepath.c_str(), "wb");

    printLog("WRITING FILE " + filepath)
    

    
    let elementSize = sizeof(tQvec(0))
    var ind = 0
    //TODO Should just write whole file directly from memory
    for col in b..<pp.total_width-b {
        
        for row in b..<pp.total_height-b {
            
            ind += 1

            fwrite(&data[col, row], elementSize, 1, fp_output);
            
        }}
    
    fclose(fp_output);
}


// not used
//func write_file_with_border_in_TEXT( _ b: tNi, _ dir: String, _ filename: String, _ data: inout tQvec, _ pp: inout PP_Dims) {
//
//
//    let filepath: String = dir + "/" + filename;
//
//    printLog("WRITING TEXT  FILE " + filepath)
//
//
////    std::ofstream myfile;
////    myfile.open (filepath);
//    let myfile: UnsafeMutablePointer<FILE>! = fopen(filepath.c_str(), "w");
//
//    //TODO Should just write whole file directly from memory
//    for col in b..<pp.total_width-b {
//
//        for row in b..<pp.total_height-b {
//
////            myfile << data[ twoD_colrow(col, row, pp.total_height) ] << ", ";
//            //    UnsafePointer<Int8>
//            fputs(data[ twoD_colrow(col, row, pp.total_height) ] + ", ", myfile)
//
//        }
////        myfile << std::endl;
//        fputs("\n", myfile)
//        fflush(myfile)
//    }
//
////    myfile.close();
//    fclose(myfile);
//}



@inline(__always) func calc_XY_vorticity( _ c: tNi, _ r: tNi, _ h: tNi, _ ux: Matrix2D_array<tQvec>, _ uy: Matrix2D_array<tQvec>, _ uz: Matrix2D_array<tQvec>, _ uxyz_log_vort: Matrix2D<tQvec>, _ uxx: inout tQvec, _ uxy: inout tQvec, _ uxz: inout tQvec, _ uyx: inout tQvec, _ uyy: inout tQvec, _ uyz: inout tQvec, _ uzx: inout tQvec, _ uzy: inout tQvec, _ uzz: inout tQvec) {

    uxx = 0.5*((ux[0][c+1, r]) - (ux[0][c-1, r]))
    uxy = 0.5*((ux[0][c  , r+1]) - (ux[0][c  , r-1]))
    uxz = 0.5*((ux[2][c  , r]) - (ux[1][c  , r]))
    
    uyx = 0.5*((uy[0][c+1, r]) - (uy[0][c-1, r]))
    uyy = 0.5*((uy[0][c  , r+1]) - (uy[0][c  , r-1]))
    uyz = 0.5*((uy[2][c  , r]) - (uy[1][c  , r]))
    
    uzx = 0.5*((uz[0][c+1, r]) - (uz[0][c-1, r]))
    uzy = 0.5*((uz[0][c  , r+1]) - (uz[0][c  , r-1]))
    uzz = 0.5*((uz[2][c  , r]) - (uz[1][c  , r]))
}



@inline(__always) func calc_XZ_vorticity( _ c: tNi, _ r: tNi, _ h: tNi, _ ux: Matrix2D_array<tQvec>, _ uy: Matrix2D_array<tQvec>, _ uz: Matrix2D_array<tQvec>, _ uxyz_log_vort: Matrix2D<tQvec>, _ uxx: inout tQvec, _ uxy: inout tQvec, _ uxz: inout tQvec, _ uyx: inout tQvec, _ uyy: inout tQvec, _ uyz: inout tQvec, _ uzx: inout tQvec, _ uzy: inout tQvec, _ uzz: inout tQvec) {
    
    uxx = 0.5*((ux[0][c+1, r]) - (ux[0][c-1, r]))
    uxy = 0.5*((ux[2][c  , r]) - (ux[1][c  , r]))
    uxz = 0.5*((ux[0][c  , r+1]) - (ux[0][c  , r-1]))

    uyx = 0.5*((uy[0][c+1, r]) - (uy[0][c-1, r]))
    uyy = 0.5*((uy[2][c  , r]) - (uy[1][c  , r]))
    uyz = 0.5*((uy[0][c  , r+1]) - (uy[0][c  , r-1]))

    uzx = 0.5*((uz[0][c+1, r]) - (uz[0][c-1, r]))
    uzy = 0.5*((uz[2][c  , r]) - (uz[1][c  , r]))
    uzz = 0.5*((uz[0][c  , r+1]) - (uz[0][c  , r-1]))
}



@inline(__always) func calc_YZ_vorticity( _ c: tNi, _ r: tNi, _ h: tNi, _ ux: Matrix2D_array<tQvec>, _ uy: Matrix2D_array<tQvec>, _ uz: Matrix2D_array<tQvec>, _ uxyz_log_vort: Matrix2D<tQvec>, _ uxx: inout tQvec, _ uxy: inout tQvec, _ uxz: inout tQvec, _ uyx: inout tQvec, _ uyy: inout tQvec, _ uyz: inout tQvec, _ uzx: inout tQvec, _ uzy: inout tQvec, _ uzz: inout tQvec) {
    
    uxx = 0.5*((ux[2][c  , r]) - (ux[1][c  , r]))
    uxy = 0.5*((ux[0][c, r+1]) - (ux[0][c,   r-1]))
    uxz = 0.5*((ux[0][c+1  , r]) - (ux[0][c-1, r]))

    uyx = 0.5*((uy[2][c  , r]) - (uy[1][c  , r]))
    uyy = 0.5*((uy[0][c  , r+1]) - (uy[0][c  , r-1]))
    uyz = 0.5*((uy[0][c+1, r]) - (uy[0][c-1, r]))

    uzx = 0.5*((uz[2][c  , r]) - (uz[1][c  , r]))
    uzy = 0.5*((uz[0][c  , r+1]) - (uz[0][c  , r-1]))
    uzz = 0.5*((uz[0][c+1, r]) - (uz[0][c-1, r]))
    
}





@inline(__always) func calc_ROTATIONAL_vorticity( _ c: tNi, _ r: tNi, _ h: tNi, _ ux: Matrix2D_array<tQvec>, _ uy: Matrix2D_array<tQvec>, _ uz: Matrix2D_array<tQvec>, _ uxyz_log_vort: Matrix2D<tQvec>, _ uxx: inout tQvec, _ uxy: inout tQvec, _ uxz: inout tQvec, _ uyx: inout tQvec, _ uyy: inout tQvec, _ uyz: inout tQvec, _ uzx: inout tQvec, _ uzy: inout tQvec, _ uzz: inout tQvec) {
    
    
    //col is i
    //    row is z or y depending
    
    
    //    dir[0] = load_dir; root[0] = "Qvec";
    //
    //    dir[1] = load_dir; root[1] = "Qvec.im1";
    //    dir[2] = load_dir; root[2] = "Qvec.ip1";
    //
    //    dir[3] = load_dir; root[3] = "Qvec.km1";
    //    dir[4] = load_dir; root[4] = "Qvec.kp1";
    
    
    
    uxx = 0.5*((ux[2][c,   r]) - (ux[1][c,   r]))
    uxy = 0.5*((ux[0][c,   r+1]) - (ux[0][c,   r-1]))
    uxz = 0.5*((ux[4][c,   r]) - (ux[3][c  , r]))

    uyx = 0.5*((uy[2][c,   r]) - (uy[1][c,   r]))
    uyy = 0.5*((uy[0][c,   r+1]) - (uy[0][c,   r-1]))
    uyz = 0.5*((uy[4][c  , r]) - (uy[3][c  , r]))


    uzx = 0.5*((uz[2][c,   r]) - (uz[1][c,   r]))
    uzy = 0.5*((uz[0][c,   r+1]) - (uz[0][c,   r-1]))
    uzz = 0.5*((uz[4][c  , r]) - (uz[3][c  , r]))
    
    
}





func calc_vorticity( _ input: inout Input_FILES_V4, _ load_dir: inout String, _ pp: inout PP_Dims, _ ux: Matrix2D_array<tQvec>, _ uxyz_log_vort: inout Matrix2D<tQvec>, _ uy: Matrix2D_array<tQvec>, _ uz: Matrix2D_array<tQvec>) {
    
    
    let h: tNi = pp.total_height;
    
    let plotname: String = input.get_plot_type_from_directory(&load_dir);
    
//    unsupported
//    #pragma omp parallel for
    
    printMigration("calc_vorticity() - This seems quite strange since col,row goes beyond array dim so fix it")

    for c in 1..<pp.total_width {
        for r in 1..<pp.total_height {
            
            var uxx: tQvec = 0.0, uxy: tQvec = 0.0, uxz: tQvec = 0.0;
            
            var uyx: tQvec = 0.0, uyy: tQvec = 0.0, uyz: tQvec = 0.0;
            
            var uzx: tQvec = 0.0, uzy: tQvec = 0.0, uzz: tQvec = 0.0;

            
            
            if (plotname == "XYplane") {
                calc_XY_vorticity(c, r, h, ux, uy, uz, uxyz_log_vort, &uxx, &uxy, &uxz, &uyx, &uyy, &uyz, &uzx, &uzy, &uzz);
            }
            
            
            else if (plotname == "XZplane") {
                calc_XZ_vorticity(c, r, h, ux, uy, uz, uxyz_log_vort,
            &uxx, &uxy, &uxz, &uyx, &uyy, &uyz, &uzx, &uzy, &uzz);
            }
                
            
            else if (plotname == "YZplane") {
                calc_YZ_vorticity(c, r, h, ux, uy, uz, uxyz_log_vort,
            &uxx, &uxy, &uxz, &uyx, &uyy, &uyz, &uzx, &uzy, &uzz);
            }
            
            
            
            else if (plotname == "rotational_capture") {
                calc_ROTATIONAL_vorticity(c, r, h, ux, uy, uz, uxyz_log_vort, &uxx, &uxy, &uxz, &uyx, &uyy, &uyz, &uzx, &uzy, &uzz);
            }
            
            
            else {
                printError("Cant deal with: " + plotname)
                return;
            }
            
            let uyz_uzy: tQvec = uyz - uzy;
            let uzx_uxz: tQvec = uzx - uxz;
            let uxy_uyx: tQvec = uxy - uyx;
            uxyz_log_vort[c, r] = log((uyz_uzy) * (uyz_uzy) + (uzx_uxz) * (uzx_uxz) + (uxy_uyx) * (uxy_uyx))
            
        }}

}





func calc_rho_ux_uy_uz( _ num_layers: Int, _ Q_plane: Matrix3D_array<tQvec>, _ F_plane: Matrix3D_array<tForce>, _ rho: inout Matrix2D_array<tQvec>, _ ux: inout Matrix2D_array<tQvec>, _ uy: inout Matrix2D_array<tQvec>, _ uz: inout Matrix2D_array<tQvec>, _ pp: inout PP_Dims) {
    
    printMigration("calc_rho_ux_uy_uz() - This seems quite strange since col,row goes beyond array dim so fix it")

    for layer in 0..<num_layers {
        
//        unsupported
//        #pragma omp parallel for

//        migration: this seems quite strange since col,row goes beyond array dim
        for col in 0...pp.total_width {
            for row in 0...pp.total_height {
                
                rho[layer][col, row] = Q_plane[layer][col, row, 0];
                
                ux[layer][col, row] = (Q_plane[layer][col, row, 1] + 0.5 * (F_plane[layer][col, row, 0])) / rho[layer][col, row]
                uy[layer][col, row] = (Q_plane[layer][col, row, 2] + 0.5 * (F_plane[layer][col, row, 1])) / rho[layer][col, row]
                uz[layer][col, row] = (Q_plane[layer][col, row, 3] + 0.5 * (F_plane[layer][col, row, 2])) / rho[layer][col, row]
                
                //                    std::cout << "calc_rho_ux_uy_uz  " << plane[layer][posPl + 0] << "  rho[]  " << rho[layer][pos] << std::endl;
                
            }
        }
        
    }
}
