//
//  PostProcessing_Dims.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation

extension PP_Dims : DefaultValuable {
    static func defaultValue() -> PP_Dims {
        return PP_Dims()
    }
    static func defaultValue_InvalidAcess() -> PP_Dims {
        return defaultValue()
    }
}


struct PP_Dims: Decodable {
    
    
    var function: String = "";
    var dirname: String = "";
    var cut_at:tNi = 0;
    var Q_output_length: Int = 0;
    
    
    var note: String = "";
    
    
    var ngx: t3d = 0;
    var ngy: t3d = 0;
    var ngz: t3d = 0;
    
    var grid_x: tNi = 0;
    var grid_y: tNi = 0;
    var grid_z: tNi = 0;
    
    
    var file_height: tNi = 0;
    var file_width: tNi = 0;
    var total_height: tNi = 0;
    var total_width: tNi = 0;
    
    
    var step: tStep = 0;
    var teta: tGeomShape = 0;
    
    
    var initial_rho:tQvec = 0;
    var re_m_nondimensional:tQvec = 0;
    var uav: tGeomShape = 0;
    
    init() {
        
    }

    
};







struct PostProcess_Data_V3 {
    var total_height, total_width: tNi;
    var file_height, file_width: tNi;
    
    var matrix_size: tNi;
    
    var save_ijk_grid, save_row_cols: Int;
    var half_float: Int;
    
    var nu: tQvec;
    var uav: tGeomShape;
};

class Handle_PP_Dims: Base_Dims<PP_Dims>{

    internal override func get_name() -> String {return "Post_Processing_Dims";}
    
    override init()
    {
        super.init()
    }

    override init( _dim: PP_Dims)
    {
        super.init(_dim: _dim)
        dim = _dim;
    }
    
    
    func set_dims( ngx: t3d, ngy: t3d, ngz: t3d, x: tNi, y: tNi, z: tNi){
        
        dim.ngx = ngx;
        dim.ngy = ngy;
        dim.ngz = ngz;
        
        dim.grid_x = x;
        dim.grid_y = y;
        dim.grid_z = z;
    }
    
    
    func set_height_width( file_height: tNi,  file_width: tNi, total_height: tNi, total_width: tNi){
        dim.file_height = file_height;
        dim.file_width = file_width;
        dim.total_height = total_height;
        dim.total_width = total_width;
    }
    
    
    func set_running( step: tStep,  teta: tGeomShape){
        dim.teta = teta;
        dim.step = step;
    }
    
    
    func set_flow( initial_rho: tQvec, re_m_nondimensional: tQvec,  uav: tGeomShape){
        dim.initial_rho = initial_rho;
        dim.re_m_nondimensional = re_m_nondimensional;
        dim.uav = uav;
    }
    
    
    func set_note(note: String){
        dim.note = note;
    }
    
    
    
    func set_plot( function: String, dirname: String, Q_output_length: Int = 4, cut_at: tNi = 0){
        dim.function = function;
        dim.dirname = dirname;
        dim.cut_at = cut_at;
        dim.Q_output_length = Q_output_length;
    }
    
    override func get_from_json_filepath( _ filepath: String) -> PP_Dims {
        
        var d: PP_Dims = PP_Dims()
        
        do
        {
            
            if let result: PP_Dims = try load_json(file: filepath) {
                d = result
            }
            
            
            printMigration("migrate json decode PP_Dims",checked: true)
            
            return d;
        }
        catch
        {
            printError("Unhandled Exception reached parsing arguments: " + error.localizedDescription + ", application will now exit")
            return d;
        }
    }
    
    
    
    func save_json_to_filepath(filepath: String) -> Int {
    do
{
    
    
    let b = ["name": "ss"]
    let a = JSONEncoder()
//    print("a \(a)")
    let c = try a.encode(b)
//    print("c \(c)")
    try c.write(to: URL(fileURLWithPath: filepath))
    
    
    printMigration("migrate json encode")
//    var dim_json = [String:String];
//
//    dim_json["name"] = get_name();
//
//    dim_json["function"] = dim.func;
//    dim_json["dirname"] = dim.dirname;
//    dim_json["cut_at"] = (int)dim.cut_at;
//    dim_json["Q_output_length"] = (int)dim.Q_output_length;
//
//
//    dim_json["note"] = dim.note;
//
//
//    dim_json["ngx"] = (int)dim.ngx;
//    dim_json["ngy"] = (int)dim.ngy;
//    dim_json["ngz"] = (int)dim.ngz;
//
//    dim_json["grid_x"] = (int)dim.grid_x;
//    dim_json["grid_y"] = (int)dim.grid_y;
//    dim_json["grid_z"] = (int)dim.grid_z;
//
//
//    dim_json["file_height"] = (int)dim.file_height;
//    dim_json["file_width"] = (int)dim.file_width;
//    dim_json["total_height"] = (int)dim.total_height;
//    dim_json["total_width"] = (int)dim.total_width;
//
//
//    dim_json["step"] = (int)dim.step;
//    dim_json["teta"] = (double)dim.teta;
//
//
//    dim_json["initial_rho"] = (double)dim.initial_rho;
//    dim_json["re_m_nondimensional"] = (double)dim.re_m_nondimensional;
//    dim_json["uav"] = (double)dim.uav;
    
    
//    std::ofstream out(filepath.c_str(), std::ofstream::out);
//    out << dim_json;
//    out.close();
    
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
        
        printMigration("simplify expression")
        printLog("" +
            " name:" + get_name()
//            " func:" + function +
//            " dirname:" + dim.dirname +
//            " cut_at:" + dim.cut_at +
//            " note:" + dim.note +
//            " Q_output_length:" + dim.Q_output_length +
//
//
//            " ngx:" + dim.ngx +
//            " ngx:" + dim.ngy +
//            " ngx:" + dim.ngz +
//
//            " grid_x:" + dim.grid_x +
//            " grid_y:" + dim.grid_y +
//            " grid_z:" + dim.grid_z +
//
//            " file_height:" + dim.file_height +
//            " file_width:" + dim.file_width +
//            " total_height:" + dim.total_height +
//            " total_width:" + dim.total_width +
//
//            " step:" + dim.step +
//            " teta:" + dim.teta +
//
//
//            " initial_rho:" + dim.initial_rho +
//            " re_m_nondimensional:" + dim.re_m_nondimensional +
//            " uav:" + dim.uav
        )
    }

    
    
    
    
    
    func read_Qvec_pp_dim_V3( dir: String, teta: inout tGeomShape) -> PostProcess_Data_V3 {
    
    //Deprecated, however many files exist in tape archive of this type
    
        var q: PostProcess_Data_V3;
    
//    //TODO Change to std::string
//    char filename_PP[200];
//    sprintf(filename_PP, "%s/pp_dim.0.0.0.V3.bin", dir.c_str());
        let filename_PP = dir.c_str() + "/pp_dim.0.0.0.V3.bin"
        
//    FILE *fp_Qvec_PP = fopen(filename_PP, "r");
    let fp_Qvec_PP: UnsafeMutablePointer<FILE>! = fopen(filename_PP.c_str(), "r");

    
    
//        var unused_float: Float = 0.0;
//        var unused_int: Int = 0;
    
        printMigration("migrate read data")
//    //Size of file
//    fread(&q.file_height, sizeof(long int), 1, fp_Qvec_PP);
//    fread(&q.file_width, sizeof(long int), 1, fp_Qvec_PP);
//
//    //The size of the full slice/axis
//    fread(&q.total_height, sizeof(long int), 1, fp_Qvec_PP);
//    fread(&q.total_width, sizeof(long int), 1, fp_Qvec_PP);
//
//
//
//    fread(teta, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//    fread(&unused_float, sizeof(float), 1, fp_Qvec_PP);
//
//
//
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
//    fread(&q.half_float, sizeof(int), 1, fp_Qvec_PP);
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
//    fread(&unused_int, sizeof(int), 1, fp_Qvec_PP);
    
    
    fclose(fp_Qvec_PP);
    
    printMigration("migrate q")
//    q.matrix_size = (q.total_height) * (q.total_width);
    q = PostProcess_Data_V3(total_height: 0, total_width: 0, file_height: 0, file_width: 0, matrix_size: 0, save_ijk_grid: 0, save_row_cols: 0, half_float: 0, nu: 0, uav: 0)
        
    return q;
    }
    
    
    
    
    
    

};
