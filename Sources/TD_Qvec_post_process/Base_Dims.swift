//
//  Base_Dims.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation
import CoreFoundation

class Base_Dims<T: DefaultValuable> {

    internal func get_name() -> String {return "Error-should-be-overwritten";}
    
    var dim: T;
    
    
    //    Base_Dims(){}
    init()
    {
        dim = T.defaultValue()
    }
    
    init(_dim: T)
    {
        dim = _dim;
    }
    
    
    func set_dim(_dim: T){
        dim = _dim;
    }
    
    func get_dim() -> T {
        return dim;
    }
    
    
    
    
    func get_base_filepath( _ idi: t3d, _ idj: t3d, _ idk: t3d, _ dir: String=".") -> String {
        return dir + "/" + get_name() + "_dims." + to_string(idi) + "." + to_string(idj) + "." + to_string(idk);
    }
    
    
    func get_filepath(_ idi: t3d, _ idj: t3d, _ idk: t3d, _ dir: String=".") -> String {
        return get_base_filepath(idi, idj, idk, dir) + ".V4.json";
    }
    
    
    func get_bin_filepath_v3(_ idi: t3d, _ idj: t3d, _ idk: t3d, _ dir: String=".") -> String {
        return get_base_filepath(idi, idj, idk, dir) + ".V3.bin";
    }
    
    
    
    
    func path_exists(_ path: String) -> Bool {
        if let file = fopen(path.c_str(), "r") {
            fclose(file);
            return true;
        } else {
            return false;
        }
    }
    
    
    func file_exists(_ path: String) -> Bool {
        return path_exists(path);
    }
    
    
    
    
    
    
    //Loading
    func get_from_file( _ idi: t3d, _ idj: t3d, _ idk: t3d, _ dir: String=".")->T{
        
        var filepath: String = get_filepath(idi, idj, idk, dir);
        if (file_exists(filepath)) {
            return  get_from_json_filepath(filepath);
        }
        
        //Try V3
        filepath = get_bin_filepath_v3(idi, idj, idk, dir);
        if (file_exists(filepath)) {
            return get_from_bin_filepath(filepath);
        }
        
        //ERROR
        printError("File does not exist for " + dir)
        let empty: T = T.defaultValue();
        return empty;
    }
    
    func get_from_json_filepath( _ filepath: String) -> T
    {
        let result: T = T.defaultValue();
        
        printError("virtual get_from_json_filepath() should neve be called")
        return result
        
    }
    
    
    func get_from_bin_filepath( _ filepath: String) -> T {
        let fp: UnsafeMutablePointer<FILE>! = fopen(filepath.c_str(), "r");

        let size = MemoryLayout<T>.size
        printMigration("get_from_bin_filepath() (DEBUG) memory size for \(T.self) is \(size)")
        
        let resultPointer = UnsafeMutableRawPointer.allocate(byteCount: size, alignment: 1)
        fread(resultPointer, 1, size, fp)
        let resultLoaded = resultPointer as? T
        fclose(fp);
        printMigration("get_from_bin_filepath() UNFINISHED - copy memeber values from resultLoaded into result")
        
        return resultLoaded!
    }
    
    func get_from_node000_from_filepath( _ dir:String = ".") -> T {
        return get_from_file(0, 0, 0, dir);
    }
    
    
    
    //    not used
    //    //Set from file
    //    func set_from_filepath( filepath:String){
    //    dim = get_from_file(filepath);
    //    }
    
    func set_from_dir(_ idi: t3d, _ idj: t3d, _ idk: t3d, _ dir:String = ".") {
        dim = get_from_file(idi, idj, idk, dir);
    }
    
    func set_from_node000_from_filepath(_ dir: String="."){
        dim = get_from_file(0, 0, 0, dir);
    }
    
    
    
    
    
    //Will be overloaded
    //    virtual
    func save_json_to_filepath( _ filepath: String) -> Int
    {
        printError( "BASE_Dim:  Error: hould have been provided by child")
        return 0;
    };
    
    
    //Will be overloaded
    //    virtual
    func save_public_json_to_filepath( _ filepath: String) -> Int
    {
        printError("BASE_Dim:  Error: should have been provided by child")
        return 0;
    };
    
    
    
    func save_json_to_dir(_ idi: t3d, _ idj: t3d, _ idk: t3d, _ dir: String = ".") -> Int{
        
        if (!path_exists(dir)) {
            mkdir(dir.c_str(), 0775);
        }
        
        let filepath: String = get_filepath(idi, idj, idk, dir);
        //        std::cout << "BASE_Dim:  Saving json to " << filepath << std::endl;
        
        return save_json_to_filepath(filepath);
        
    }
    
    func save_json_as_node000_to_dir(_ dir: String="."){
        let _ = save_json_to_dir(0, 0, 0, dir);
    }
    
    
    
    
    
    
    func save_public_json_to_dir(_ idi: t3d, _ idj: t3d, _ idk: t3d, _ dir: String = ".") -> Int {
        
        if (!path_exists(dir)) {
            mkdir(dir.c_str(), 0775);
        }
        
        let filepath: String = get_filepath(idi, idj, idk, dir);
        //        std::cout << "BASE_Dim:  Saving json to " << filepath << std::endl;
        
        return save_public_json_to_filepath(filepath);
        
    }
    
    func save_public_json_as_node000_to_dir(_ dir: String="."){
        let _ = save_public_json_to_dir(0, 0, 0, dir);
    }
    
    
    
};

