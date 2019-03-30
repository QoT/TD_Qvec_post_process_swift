//
//  main.swift
//  td_Qvec_swift_pp
//
//  Created by Nile Ó Broin on 24/01/2019.
//  Copyright © 2019 Nile Ó Broin. All rights reserved.
//

import Foundation



//TODO should return correct types
struct PP_Dim: Decodable {

    let name: String
    let function: String
    let dirname: String
    let cut_at: String
    let Q_output_length: String
    let note: String

    let ngx: String
    let ngy: String
    let ngz: String
    let grid_x: String
    let grid_y: String
    let grid_z: String

    let file_height: String
    let file_width: String
    let total_height: String
    let total_width: String

    let step: String
    let teta: String
    let initial_rho: String
    let re_m_nondimensional: String
    let uav: String
}





func load_json(dir: String = ".", file: String) -> PP_Dim? {



    let dirURL = URL(fileURLWithPath: dir)

    let fileURL = dirURL.appendingPathComponent(file)


    if let jsonFile:String? = try? String(contentsOf: fileURL) {


        if let json = jsonFile!.data(using: .utf8) {



            if let myStruct = try? JSONDecoder().decode(PP_Dim.self, from: json) {


                print(myStruct)
                return myStruct


            } else {print("Cannot decode json file")}


        } else {print("Cannot convert to json text to json Data")}

    } else {print("Cannot read json file at " + file)}

}


load_json(file: "Post_Processing_Dims_dims.0.0.0.V4.json")



