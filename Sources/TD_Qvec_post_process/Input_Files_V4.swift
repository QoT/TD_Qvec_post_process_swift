//
//  Input_FILES_V4.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation

////
////  Output_Qvec.hpp
////  stirred-tank-3d-xcode-cpp
////
////  Created by Niall OByrnes on 23/07/2018.
////  Copyright © 2018 Niall P. O'Byrnes. All rights reserved.
////

////https://stackoverflow.com/questions/12975341/to-string-is-not-a-member-of-std-says-g-mingw
//namespace patch
//{
//    template < typename T > String to_string( const T& n )
//    {
//        std::ostringstream stm ;
//        stm << n ;
//        return stm.str() ;
//    }
//}

typealias uint16_t = UInt16

typealias float3 = [Float] // 3 elements
typealias float4 = [Float] // 4 elements
typealias float19 = [Float] // 19 elements
typealias float27 = [Float] // 27 elements

// legacy...
////https://stackoverflow.com/questions/12975341/to-string-is-not-a-member-of-std-says-g-mingw
func patch_to_string(_ t: Int) -> String { return to_string(t) }
func patch_to_string(_ t: Int32) -> String { return to_string(t) }

class Serializable {
    
    func read( from file: UnsafeMutablePointer<FILE>) {
        printError("This should never be called - Serializable.read( from file:)")
    }
    
    func read<T>( value: inout T, from file: UnsafeMutablePointer<FILE>) {

        let readSize = fread(UnsafeMutableRawPointer(&value), 1, sizeof(value), file);
        if readSize == sizeof(value) {
        } else {
            printError("Could not read all elements of array. Read \(readSize) instead of \(sizeof(value))")
        }
    }
    
    func read<T>( array: inout [T], from file: UnsafeMutablePointer<FILE>) {
        
        for index in 0..<array.count {
            var element = array[index]
            let readSize = fread(UnsafeMutableRawPointer(&element), 1, sizeof(element), file);
            if readSize == sizeof(element) {
                array[index] = element
            } else {
                printError("Could not read all elements of array. Read \(readSize) instead of \(sizeof(element))")
            }
        }
    }
}

final class tDisk_grid_Q3_V4: Serializable {
    var i_grid: uint16_t = 0, j_grid: uint16_t = 0, k_grid: uint16_t = 0
    var s: float3 = float3(repeating: 0.0, count: 3)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &i_grid, from: file)
        read(value: &j_grid, from: file)
        read(value: &k_grid, from: file)
        
        read(array: &s, from: file)
    }
}
final class tDisk_colrow_Q3_V4: Serializable {
    var col: uint16_t = 0, row: uint16_t = 0
    var s: float3 = float3(repeating: 0.0, count: 3)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &col, from: file)
        read(value: &row, from: file)
        
        read(array: &s, from: file)
    }
}
final class tDisk_grid_colrow_Q3_V4: Serializable {
    var i_grid: uint16_t = 0, j_grid: uint16_t = 0, k_grid: uint16_t = 0
    var col: uint16_t = 0, row: uint16_t = 0
    var s: float3 = float3(repeating: 0.0, count: 3)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &i_grid, from: file)
        read(value: &j_grid, from: file)
        read(value: &k_grid, from: file)
        
        read(value: &col, from: file)
        read(value: &row, from: file)
        
        read(array: &s, from: file)
    }
}




final class tDisk_grid_Q4_V4: Serializable {
    var i_grid: uint16_t = 0, j_grid: uint16_t = 0, k_grid: uint16_t = 0
    var s: float4 = float4(repeating: 0.0, count: 4)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &i_grid, from: file)
        read(value: &j_grid, from: file)
        read(value: &k_grid, from: file)
        
        read(array: &s, from: file)
    }
};
final class tDisk_colrow_Q4_V4: Serializable {
    var col: uint16_t = 0, row: uint16_t = 0
    var s: float4 = float4(repeating: 0.0, count: 4)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &col, from: file)
        read(value: &row, from: file)
        
        read(array: &s, from: file)
    }
};
final class tDisk_grid_colrow_Q4_V4: Serializable {
    var i_grid: uint16_t = 0, j_grid: uint16_t = 0, k_grid: uint16_t = 0
    var col: uint16_t = 0, row: uint16_t = 0
    var s: float4 = float4(repeating: 0.0, count: 4)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &i_grid, from: file)
        read(value: &j_grid, from: file)
        read(value: &k_grid, from: file)
        
        read(value: &col, from: file)
        read(value: &row, from: file)
        
        read(array: &s, from: file)
    }
};



final class tDisk_grid_Q19_V4: Serializable {
    var i_grid: uint16_t = 0, j_grid: uint16_t = 0, k_grid: uint16_t = 0
    var s: float19 = float19(repeating: 0.0, count: 19)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &i_grid, from: file)
        read(value: &j_grid, from: file)
        read(value: &k_grid, from: file)
        
        read(array: &s, from: file)
    }
};
final class tDisk_colrow_Q19_V4: Serializable {
    var col: uint16_t = 0, row: uint16_t = 0
    var s: float19 = float19(repeating: 0.0, count: 19)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &col, from: file)
        read(value: &row, from: file)
        
        read(array: &s, from: file)
    }
};
final class tDisk_grid_colrow_Q19_V4: Serializable {
    var i_grid: uint16_t = 0, j_grid: uint16_t = 0, k_grid: uint16_t = 0
    var col: uint16_t = 0, row: uint16_t = 0
    var s: float19 = float19(repeating: 0.0, count: 19)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &i_grid, from: file)
        read(value: &j_grid, from: file)
        read(value: &k_grid, from: file)
        
        read(value: &col, from: file)
        read(value: &row, from: file)
        
        read(array: &s, from: file)
    }
};



final class tDisk_grid_Q27_V4: Serializable {
    var i_grid: uint16_t = 0, j_grid: uint16_t = 0, k_grid: uint16_t = 0
    var s: float27 = float27(repeating: 0.0, count: 27)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &i_grid, from: file)
        read(value: &j_grid, from: file)
        read(value: &k_grid, from: file)
        
        read(array: &s, from: file)
    }
};

final class tDisk_colrow_Q27_V4: Serializable {
    var col: uint16_t = 0, row: uint16_t = 0
    var s: float27 = float27(repeating: 0.0, count: 27)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &col, from: file)
        read(value: &row, from: file)
        
        read(array: &s, from: file)
    }
};

final class tDisk_grid_colrow_Q27_V4: Serializable {
    var i_grid: uint16_t = 0, j_grid: uint16_t = 0, k_grid: uint16_t = 0
    var col: uint16_t = 0, row: uint16_t = 0
    var s: float27 = float27(repeating: 0.0, count: 27)
    
    override func read( from file: UnsafeMutablePointer<FILE>) {
        read(value: &i_grid, from: file)
        read(value: &j_grid, from: file)
        read(value: &k_grid, from: file)
        
        read(value: &col, from: file)
        read(value: &row, from: file)
        
        read(array: &s, from: file)
    }
};



extension tDisk_grid_Q3_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_grid_Q3_V4 {
        return tDisk_grid_Q3_V4()
    }
}
extension tDisk_colrow_Q3_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_colrow_Q3_V4 {
        return tDisk_colrow_Q3_V4()
    }
}
extension tDisk_grid_colrow_Q3_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_grid_colrow_Q3_V4 {
        return tDisk_grid_colrow_Q3_V4()
    }
}



extension tDisk_grid_colrow_Q4_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_grid_colrow_Q4_V4 {
        return tDisk_grid_colrow_Q4_V4()
    }
}
extension tDisk_colrow_Q4_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_colrow_Q4_V4 {
        return tDisk_colrow_Q4_V4()
    }
}
extension tDisk_grid_Q4_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_grid_Q4_V4 {
        return tDisk_grid_Q4_V4()
    }
}



extension tDisk_grid_Q19_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_grid_Q19_V4 {
        return tDisk_grid_Q19_V4()
    }
}
extension tDisk_colrow_Q19_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_colrow_Q19_V4 {
        return tDisk_colrow_Q19_V4()
    }
}
extension tDisk_grid_colrow_Q19_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_grid_colrow_Q19_V4 {
        return tDisk_grid_colrow_Q19_V4()
    }
}



extension tDisk_grid_Q27_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_grid_Q27_V4 {
        return tDisk_grid_Q27_V4()
    }
}
extension tDisk_colrow_Q27_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_colrow_Q27_V4 {
        return tDisk_colrow_Q27_V4()
    }
}
extension tDisk_grid_colrow_Q27_V4 : DefaultValuable {
    static func defaultValue() -> tDisk_grid_colrow_Q27_V4 {
        return tDisk_grid_colrow_Q27_V4()
    }
}



class Input_FILES_V4 {

//    private:


    func get_Qvec_fileroot( _ dir: String, _ name: String, _ idi: t3d, _ idj: t3d, _ idk: t3d) -> String {
    return dir + "/" + name + ".node." + to_string(idi) + "." + to_string(idj) + "." + to_string(idk) + ".V4";
    }


    var Disk_grid_Q3: Matrix1D<tDisk_grid_Q3_V4> = Matrix1D()
    var Disk_colrow_Q3: Matrix1D<tDisk_colrow_Q3_V4> = Matrix1D()
    var Disk_grid_colrow_Q3: Matrix1D<tDisk_grid_colrow_Q3_V4> = Matrix1D()

    var Disk_grid_Q4: Matrix1D<tDisk_grid_Q4_V4> = Matrix1D()
    var Disk_colrow_Q4: Matrix1D<tDisk_colrow_Q4_V4> = Matrix1D()
    var Disk_grid_colrow_Q4: Matrix1D<tDisk_grid_colrow_Q4_V4> = Matrix1D()

    var Disk_grid_Q19: Matrix1D<tDisk_grid_Q19_V4> = Matrix1D()
    var Disk_colrow_Q19: Matrix1D<tDisk_colrow_Q19_V4> = Matrix1D()
    var Disk_grid_colrow_Q19: Matrix1D<tDisk_grid_colrow_Q19_V4> = Matrix1D()


//    public:

    var grid: Grid_Dims = Grid_Dims()
    var node: Node_Dims = Node_Dims()
    var pp_data: PP_Dims = PP_Dims()


//    let Input_FILES_V4() {};


    func Input_FILES_V4( _grid: Grid_Dims, _node: Node_Dims){
    grid = _grid;
    node = _node;
    };


    func format_step(_ step: tStep) -> String {

//    let String stream sstream;
//
//    sstream << std::setw(8) << std::setfill('0') << patch_to_string(step);
//
//    return sstream.str();
        
        let result = String(format: "%08d", step) // returns "00"

        printMigration("format_step() (DEBUG) convert Int: '\(step)' into String: '\(result)'")
        
        return result
    }





    func get_Qvec_filename(_ dir: String, _ name: String, _ idi: t3d, _ idj: t3d, _ idk: t3d) -> String {
    return get_Qvec_fileroot(dir, name, idi, idj, idk) + ".bin";
    }

    func get_my_Qvec_filename( _ dir: String, _ name: String) -> String {
    return get_Qvec_filename(dir, name, node.idi, node.idj, node.idk);
    }

    func get_node000_Qvec_filename( _ dir: String, _ name: String) -> String {
    return get_Qvec_filename(dir, name, 0, 0, 0);
    }



    func get_start(_ dir_root: String, _ name: String, _ plot_type: String, _ Q_length: Int, _ step: tStep) -> String {
    return dir_root + "/" + name + "." + plot_type + ".V_4.Q_" + patch_to_string(Q_length) + ".step_" + format_step(step);
    }




    func get_XY_plane_dir(_ step: tStep, _ at_k: tNi, _ Q_length: Int, _ name: String="plot", _ dir_root: String=".") -> String {

    return get_start(dir_root, name, "XYplane", Q_length, step) + ".cut_" + patch_to_string(at_k);
    }

    //Formally Axis
    func get_XZ_plane_dir( _ step: tStep, _ at_j: tNi, _ Q_length: Int, _ name: String="plot", _ dir_root: String=".") -> String{

    return get_start(dir_root, name, "XZplane", Q_length, step) + ".cut_" + patch_to_string(at_j);
    }

    //Formally Slice
    func get_YZ_plane_dir( _ step: tStep, _ at_i: tNi, _ Q_length: Int, _ name: String="plot", _ dir_root: String=".") -> String{

    return get_start(dir_root, name, "YZplane", Q_length, step) + ".cut_" + patch_to_string(at_i);
    }



    func get_volume_dir( _ step: tStep, _ Q_length: Int, _ name: String="plot", _ dir_root: String=".") -> String{
    return get_start(dir_root, name, "volume", Q_length, step);
    }






    func get_capture_at_blade_angle_dir( _ step: tStep, _ angle: Int, _ blade_id: Int, _ Q_length: Int, _ name: String="plot_", _ dir_root: String=".") -> String{

    return get_start(dir_root, name, "rotational_capture", Q_length, step) + ".angle_" + patch_to_string(angle) + ".blade_id_" + patch_to_string(blade_id);
    }


    func get_axis_when_blade_angle_dir( _ step: tStep, _ angle: Int, _ Q_length: Int, _ name: String="plot", _ dir_root: String=".") -> String{

    return get_start(dir_root, name, "YZplane", Q_length, step) + ".angle_" + patch_to_string(angle);
    }



    func get_rotating_sector_dir( _ step: tStep, _ angle: Int, _ Q_length: Int, _ name: String="plot", _ dir_root: String=".") -> String{

        let ret: String = "";
        return ret;
    }



    func get_dir_delta( _ delta: Int, _  load_dir: inout basic_string)  -> String{
        //    using namespace std;


        if (!plot_type_in_dir("cut", load_dir)) {
            return "not_found";
        }

        var delta_load_dir: String = load_dir;

        let pattern = "cut_(.*)"
        if let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) {
        
            let range = regex.matches(in: delta_load_dir, options: [], range: NSMakeRange(0, delta_load_dir.count))
            if let tx = Range(range[0].range(at: 1), in: delta_load_dir) {
                let lastIndexAsString = delta_load_dir[tx]
                if let lastIndex = Int(String(lastIndexAsString)) {
                    let delta = String(lastIndex + 1)
                    if let range = Range(range[0].range(at: 1), in: delta_load_dir) {
                        delta_load_dir.replaceSubrange(range, with: delta)
                        printMigration("get_dir_delta() (DEBUG) - converted \(load_dir) -> \(delta_load_dir)",checked: true)
                    }
                    else {
                        printError("get_dir_delta() - cannot detect range \(range[0].range(at: 1)) in \(delta_load_dir)")
                    }
                }
                else {
                    printError("get_dir_delta() - cannot convert Int \(lastIndexAsString) to String")
                }
            }
            else {
                printError("get_dir_delta() - cannot instantiate Regular expression range: \(range[0].range(at: 1)) in load_dir \(delta_load_dir)")
            }
        }
        else {
            printError("get_dir_delta() - cannot instantiate Regular expression pattern: \(pattern)")
        }
    //    std::cout << "String" << load_dir << " Delta String   " << delta_load_dir << std::endl;

    return delta_load_dir;
    }




    func plot_type_in_dir( _ type: basic_string, _ load_dir:  basic_string) -> Bool {
        //    using namespace std;
        
        let found: size_t? = load_dir.find(type);
        if (found != load_dir.npos()) {
            //        cout << "found  " << type << " in " << load_dir << endl;
            return true;
        }
        return false;
    }


    func get_plot_type_from_directory( _ load_dir:inout basic_string)  -> String{
        
        if (plot_type_in_dir("XYplane", load_dir)) {
            return "XYplane";
        }
        else if (plot_type_in_dir("XZplane", load_dir)) {
            return "XZplane";
        }
        else if (plot_type_in_dir("YZplane", load_dir)) {
            return "YZplane";
        }
        else if (plot_type_in_dir("volume", load_dir)) {
            return "volume";
        }
            
        else if (plot_type_in_dir("rotational_capture", load_dir)) {
            return "rotational_capture";
        }
        
        
        return "";
    }





    //----------------------------



    func load_plane( _ num_layers: Int,  _ load_dir: inout basic_string, _ Q_plane: inout Matrix3D_array<tQvec>, _ F_plane: inout Matrix3D_array<tForce>, _ pp: inout PP_Dims)
    {
//    void Input_FILES_V4::load_plane(int num_layers, const std::basic_string<char> &load_dir, tQvec **Q_plane, tForce **F_plane, const PP_Dims &pp) {
    
    
        let plotname: String = get_plot_type_from_directory(&load_dir)
    
    
    var dir: [String] = ["", "", "", "", ""]
    var root: [String] =  ["", "", "", "", ""], root_F: [String] = ["", "", "", "", ""]
    
    
    if (plotname == "rotational_capture") {
    dir[0] = load_dir; root[0] = "Qvec"; root_F[0] = "Qvec.F3";
    
    dir[1] = load_dir; root[1] = "Qvec.im1"; root_F[1] = "Qvec.F3.im1";
    dir[2] = load_dir; root[2] = "Qvec.ip1"; root_F[2] = "Qvec.F3.ip1";
    
    dir[3] = load_dir; root[3] = "Qvec.km1"; root_F[3] = "Qvec.F3.km1";
    dir[4] = load_dir; root[4] = "Qvec.kp1"; root_F[4] = "Qvec.F3.kp1";
    
    } else {
    
    dir[0] = load_dir;                    root[0] = "Qvec"; root_F[0] = "Qvec.F3";
        dir[1] = get_dir_delta(-1, &load_dir); root[1] = "Qvec"; root_F[1] = "Qvec.F3";
        dir[2] = get_dir_delta(+1, &load_dir); root[2] = "Qvec"; root_F[2] = "Qvec.F3";
    }
    
    
    
    
    
//    #pragma omp parallel for collapse(3) schedule(dynamic)
    for idi in 0..<pp.ngx {
    for idj in 0..<pp.ngy {
    for idk in 0..<pp.ngz {
    
    
    for layer in 0..<num_layers {
    
    
    
    let Qvec_filepath: String = get_Qvec_filename(dir[layer], root[layer], idi, idj, idk);
    
    let F_filepath: String = get_Qvec_filename(dir[layer], root_F[layer], idi, idj, idk);
    
    
    //                    std::cout<<__func__ << " func trying "<< " " << Qvec_filepath << std::endl;
    
    
    if (xfile_exists(Qvec_filepath)) {
    
    
        allocate_and_orient_plane_from_filepath(plotname, pp, Qvec_filepath, &Q_plane[layer]);
    
    }
    if (xfile_exists(F_filepath)) {
    
        let is_F: Bool = true;
        allocate_and_orient_plane_from_filepath(plotname, pp, F_filepath, &F_plane[layer], is_F);
    
    
    }
    //                    else {
    //                        std::cout << "file " << Qvec_filepath << " or " << F_filepath << " does not exist." << std::endl;
    //                    }
    
    
    
    
    }//end of layer
    
    }}}
    
    
    
    }

    
    func allocate_and_orient_plane_from_filepath( _ plotname: String, _ pp: PP_Dims, _ filepath: String, _ plane: inout Matrix3D<tQvec>, _ is_F:Bool=false)
    {
//    void Input_FILES_V4::allocate_and_orient_plane_from_filepath(const std::string plotname, PP_Dims pp, const std::string filepath, tQvec *plane, bool is_F){
    
    
    
    
        let handle_q: Handle_Qvec_Dims = Handle_Qvec_Dims()
    
    if (handle_q.Qvec_json_file_exists(filepath)){
    
    printLog("Attempting to load " + filepath);
    
        let q: Qvec_Dims = handle_q.get_from_Qvec_filepath(filepath);
    
    
    
        if (q.struct_name == "tDisk_colrow_Q3_V4") {
            Disk_colrow_Q3 = malloc_and_load(q, filepath);
        }
        else if (q.struct_name == "tDisk_grid_colrow_Q3_V4") {
            Disk_grid_colrow_Q3 = malloc_and_load(q, filepath);
        }
        else if (q.struct_name == "tDisk_colrow_Q4_V4") {
            Disk_colrow_Q4 = malloc_and_load(q, filepath);
        }
        else if (q.struct_name == "tDisk_grid_colrow_Q4_V4") {
            Disk_grid_colrow_Q4 = malloc_and_load(q, filepath);
        }
        else if (q.struct_name == "tDisk_colrow_Q19_V4") {
            Disk_colrow_Q19 = malloc_and_load(q, filepath);
        }
        else if (q.struct_name == "tDisk_grid_colrow_Q19_V4") {
            Disk_grid_colrow_Q19 = malloc_and_load(q, filepath);
        }
    //        else if (q.struct_name == "tDisk_colrow_Q27_V4") Disk_colrow_Q27 = malloc_and_load<tDisk_colrow_Q27_V4>(q, filepath);
    //        else if (q.struct_name == "tDisk_grid_colrow_Q27_V4") Disk_grid_colrow_Q27 = malloc_and_load<tDisk_grid_colrow_Q27_V4>(q, filepath);
    
    
    
        else {
            printError("ERROR struct not found: " + q.struct_name)
        }
    
    
    
    for u in 0..<q.bin_file_size_in_structs {
    
    
    if (is_F){
        let length: tNi = 3;
    //                std::cout << "=======" << Disk_colrow_Q3[u].s[0] << " " << Disk_colrow_Q3[u].s[1] << " " << Disk_colrow_Q3[u].s[2] << std::endl;
    
    if (q.struct_name == "tDisk_colrow_Q3_V4"){
    
    
        let col: tNi = tNi(Disk_colrow_Q3[Int(u)].col);
        let row: tNi = tNi(Disk_colrow_Q3[Int(u)].row);
    
    
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 0] = Disk_colrow_Q3[Int(u)].s[0];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 1] = Disk_colrow_Q3[Int(u)].s[1];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 2] = Disk_colrow_Q3[Int(u)].s[2];
    
    }
    else if (q.struct_name == "tDisk_grid_colrow_Q3_V4"){
    
        let col: tNi = tNi(Disk_grid_colrow_Q3[Int(u)].col);
        let row: tNi = tNi(Disk_grid_colrow_Q3[Int(u)].row);
    
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 0] = Disk_grid_colrow_Q3[Int(u)].s[0];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 1] = Disk_grid_colrow_Q3[Int(u)].s[1];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 2] = Disk_grid_colrow_Q3[Int(u)].s[2];
    
    }
    
    
    }else{
    
        let length: tNi = tNi(pp.Q_output_length);
    
    //                std::cout <<"%%%%%" << Disk_colrow_Q4[u].s[0] << " " << Disk_colrow_Q4[u].s[1] << " " << Disk_colrow_Q4[u].s[2] << " " << Disk_colrow_Q4[u].s[3] <<std::endl;
    
    if (q.struct_name == "tDisk_colrow_Q4_V4"){
    
    
        let col: tNi = tNi(Disk_colrow_Q4[Int(u)].col);
        let row: tNi = tNi(Disk_colrow_Q4[Int(u)].row);
    
    
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 0] = Disk_colrow_Q4[Int(u)].s[0];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 1] = Disk_colrow_Q4[Int(u)].s[1];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 2] = Disk_colrow_Q4[Int(u)].s[2];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 3] = Disk_colrow_Q4[Int(u)].s[3];
    
    } else if (q.struct_name == "tDisk_grid_colrow_Q4_V4"){
    
    
        let col: tNi = tNi(Disk_grid_colrow_Q4[Int(u)].col);
        let row: tNi = tNi(Disk_grid_colrow_Q4[Int(u)].row);
    
    
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 0] = Disk_grid_colrow_Q4[Int(u)].s[0];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 1] = Disk_grid_colrow_Q4[Int(u)].s[1];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 2] = Disk_grid_colrow_Q4[Int(u)].s[2];
    plane[ twoD_colrow_len(col, row, pp.total_height, length) + 3] = Disk_grid_colrow_Q4[Int(u)].s[3];
    
    
    }
    
    }
    
    }
    
    
    
    
    
    
    }//end of for
    
    }//end of func

    
    //    func load_angle(int layers, std::basic_string<char> &load_dir, tQvec **plane, PP_Dims &pp);
    func load_angle( _ layers: Int, _ load_dir:inout basic_string, _ plane: inout [tQvec], _ pp: inout PP_Dims)
    {}



};









//
//  output_plots.cpp
//  stirred-tank-3d-xcode-cpp
//
//  Created by Niall P. O'Byrnes on 17/3/1.
//  Copyright © 2017 Niall P. O'Byrnes. All rights reserved.
//

//template <typename tDisk>
func malloc_and_load<tDisk: Serializable>( _ q: Qvec_Dims, _ qvec_path: String) -> Matrix1D<tDisk> {
    
    var tmp = Matrix1D<tDisk>(rows: Int(q.bin_file_size_in_structs))
    let fp: UnsafeMutablePointer<FILE>! = fopen(qvec_path.c_str(), "r");
    
    for index in 0..<tmp.rows {
        tmp[index].read(from: fp)
    }

    fclose(fp);
    print("Load \(q.bin_file_size_in_structs) of \(tmp[0])")
    
    return tmp;
}












func path_exists(_ path: String) -> Bool {
    if let file = fopen(path.c_str(), "r") {
        fclose(file);
        return true;
    } else {
        return false;
    }
}

func xpath_exists( _ path: String) -> Bool {
//    if (FILE *file = fopen(path.c_str(), "r")) {
//        fclose(file);
//        return true;
//    } else {
//        return false;
//    }
    return path_exists(path)
}


func xfile_exists( _ path: String) -> Bool {
    return xpath_exists(path);
}
