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
    let cut_at: tNi
    let Q_output_length: Int
    let note: String

    let ngx: t3d
    let ngy: t3d
    let ngz: t3d
    let grid_x: tNi
    let grid_y: tNi
    let grid_z: tNi

    let file_height: tNi
    let file_width: tNi
    let total_height: tNi
    let total_width: tNi

    let step: tStep
    let teta: tGeomShape
    let initial_rho: tQvec
    let re_m_nondimensional: tQvec
    let uav: tQvec
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



