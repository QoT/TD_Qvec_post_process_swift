//
//  Qvec_Dims.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation

//
//  define_datastructures.hpp
//  stirred-tank-3d-xcode-cpp
//
//  Created by Nile Ó Broin on 08/01/2019.
//  Copyright © 2019 Nile Ó Broin. All rights reserved.
//

extension Qvec_Dims : DefaultValuable {
    static func defaultValue() -> Qvec_Dims {
        return Qvec_Dims()
    }
}

struct Qvec_Dims: Decodable {
    
    var grid_x: tNi = 0;
    var grid_y: tNi = 0;
    var grid_z: tNi = 0;
    
    
    var ngx = 0;
    var ngy = 0;
    var ngz = 0;
    
    var idi = 0;
    var idj = 0;
    var idk = 0;
    
    
    var struct_name: String = ""
    var bin_file_size_in_structs: ULongInt = 0
    
    
    
    var coords_type: String = ""
    var has_grid_coords: Bool = false
    var has_col_row_coords: Bool = false
    
    
    
    var Q_data_type: String = ""
    var Q_output_length: Int = 0
    
    init() {
        
    }
};



//class Handle_Qvec_Dims: public Base_Dims<Qvec_Dims>{
class Handle_Qvec_Dims: Base_Dims<Qvec_Dims>{
//    private:
    override func get_name()-> String{return "Qvec_Dims";}
    
//    public:    
    override init()
    {
        super.init()
    }
    
    override init( _dim: Qvec_Dims)
    {
        super.init()
        
        dim = _dim;
    }
    
    
    
    
    func set_dims( _ ngx: t3d, _ ngy: t3d, _ ngz: t3d, _ snx: tNi, _ sny: tNi, _ snz: tNi){
        
        dim.ngx = ngx;
        dim.ngy = ngy;
        dim.ngz = ngz;
        
        dim.grid_x = snx;
        dim.grid_y = sny;
        dim.grid_z = snz;
    }
    
    func set_ids( _ idi: t3d, _ idj: t3d, _ idk: t3d){
        
        dim.idi = idi;
        dim.idj = idj;
        dim.idk = idk;
        
    }
    
    func set_file_content( _ struct_name: String, _ bin_file_size_in_structs: ULongInt,
                           _ coords_type: String, _ has_grid_coords: Bool, _ has_col_row_coords: Bool,
         Q_data_type: String, Q_output_length: Int)
    {
        
        dim.struct_name = struct_name;
        dim.bin_file_size_in_structs = bin_file_size_in_structs;
        
        dim.coords_type = coords_type;
        dim.has_grid_coords = has_grid_coords;
        dim.has_col_row_coords = has_col_row_coords;
        
        dim.Q_data_type = Q_data_type;
        dim.Q_output_length = Q_output_length;
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func get_json_filepath_from_Qvec_filepath( _ Qvec_filepath: String)-> String{
        return Qvec_filepath + ".json";
    }
    
    func Qvec_json_file_exists( _ Qvec_filepath: String)->Bool{
        let json_filepath: String = get_json_filepath_from_Qvec_filepath(Qvec_filepath);
        return file_exists(json_filepath);
    }
    
    
    
    
    
    
    func get_from_Qvec_filepath( _ Qvec_filepath: String)->Qvec_Dims{
        
        let json_filepath: String = get_json_filepath_from_Qvec_filepath(Qvec_filepath);
        
        return get_from_json_filepath(json_filepath);
    }
    
    
    
    
    
    
    
    
    
    
    
    

    override func get_from_json_filepath( _ filepath: String)->Qvec_Dims {
        
        
        var d: Qvec_Dims = Qvec_Dims()
        
        do
        {
            if let result: Qvec_Dims = try load_json(file: filepath) {
                d = result
            }
            
            
            printMigration("migrate json decode Qvec_Dims",checked: true)
            
            return d;
        }
        catch
        {
            printError("Unhandled Exception reached parsing arguments: " + error.localizedDescription + ", application will now exit")
            return d;
        }
    }
    
    
    
    func save_json_to_Qvec_filepath( _ qvec_filepath: String) -> Int
{
    
    //template <class Tpos, class Tdata>
//    int Handle_Qvec_Dims::save_json_to_Qvec_filepath(const std::string qvec_filepath){
    
    let json_filepath: String = get_json_filepath_from_Qvec_filepath(qvec_filepath);
    
    do
{
    printMigration("migrate json encode")
//    Json::Value dim_json;
//
//    dim_json["name"] = get_name();
//
//    dim_json["grid_x"] = (int)dim.grid_x;
//    dim_json["grid_y"] = (int)dim.grid_y;
//    dim_json["grid_z"] = (int)dim.grid_z;
//
//
//    dim_json["ngx"] = (int)dim.ngx;
//    dim_json["ngy"] = (int)dim.ngy;
//    dim_json["ngz"] = (int)dim.ngz;
//
//    dim_json["idi"] = (int)dim.idi;
//    dim_json["idj"] = (int)dim.idj;
//    dim_json["idk"] = (int)dim.idk;
//
//
//    dim_json["struct_name"] = dim.struct_name;
//    dim_json["bin_file_size_in_structs"] = (uint64_t)dim.bin_file_size_in_structs;
//
//
//    dim_json["coords_type"] = dim.coords_type;
//    dim_json["has_grid_coords"] = dim.has_grid_coords;
//    dim_json["has_col_row_coords"] = dim.has_col_row_coords;
//
//
//    dim_json["Q_data_type"] = dim.Q_data_type;
//    dim_json["Q_output_length"] = (int)dim.Q_output_length;
    
    
    return 0;
    }
    catch
    {
        printError("Unhandled Exception reached parsing arguments: " + error.localizedDescription + ", application will now exit")
        return 1;
    }
    return 0;
}

    
    
    
    
    func print() {
//    void Handle_Qvec_Dims::print(){
    printLog("")
        
    printMigration("simplify expression")
    printLog("" +
    "QvecBinFile_Dims "
//    " bin_file_size_in_structs:" + dim.bin_file_size_in_structs +
    
//    " grid_x:" + dim.grid_x +
//    " grid_y:" + dim.grid_y +
//    " grid_z:" + dim.grid_z +
//
//
//    " ngx:" + dim.ngx +
//    " ngx:" + dim.ngy +
//    " ngx:" + dim.ngz +
//
//
//    " idi:" + dim.idi +
//    " idj:" + dim.idj +
//    " idk:" + dim.idk +
//
//    " struct_name:" + dim.struct_name +
//    " bin_file_size_in_structs:" + dim.bin_file_size_in_structs +
//
//
//    " coords_type:" + dim.coords_type +
//    " has_grid_coords:" + dim.has_grid_coords +
//    " has_col_row_coords:" + dim.has_col_row_coords +
//
//
//    " Q_data_type:" + dim.Q_data_type +
//    " Q_output_length:" + dim.Q_output_length
)
        
    
        printLog("")
        printLog("")
    }
    
    
    
    

};



//
//  Grid_Dims.hpp
//  lb-halo-3dmpi
//
//  Created by Nile Ó Broin on 08/01/2019.
//  Copyright © 2019 Nile Ó Broin. All rights reserved.
//
