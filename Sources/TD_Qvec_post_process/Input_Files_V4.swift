//
//  main.swift
//  td_Qvec_swift_pp
//
//  Created by Nile Ó Broin on 24/01/2019.
//  Copyright © 2019 Nile Ó Broin. All rights reserved.
//

import Foundation



class Input_Files_V4 {

    let version = 4


    private func get_Qvec_fileroot(_ dir: String, _ name: String, _ idi: t3d, _ idj: t3d, _ idk: t3d) -> String {
        return "\(dir)/\(name).node.\(idi).\(idj).\(idk).V\(version)"
    }


    func get_Qvec_filename(dir: String, name: String, idi: t3d, idj: t3d, idk: t3d) -> String {

        return get_Qvec_fileroot(dir, name, idi, idj, idk) + ".bin"
    }

    //    func get_my_Qvec_filename(dir: String, name: String) {
    //        return get_Qvec_filename(dir: dir, name: name, idi: node.idi, idj: node.idj, idk: node.idk);
    //    }

    func get_node000_Qvec_filename(dir: String, name: String) -> String {

        return get_Qvec_filename(dir: dir, name: name, idi: 0, idj: 0, idk: 0)
    }








    private func get_dir_start(_ dir_root: String, _ name: String, _ plot_type: String, _ Q_length: Int, _ step: tStep) -> String {

        return "\(dir_root)/\(name).\(plot_type).V_\(version).Q_\(Q_length).step_" + format_step(step)
    }

    private func format_step(_ step: tStep) -> String {
        return String(format: "%02d", step)
    }


    func get_XY_plane_dir(step: tStep, at_k: tNi, Q_length: Int, name: String="plot", dir_root: String=".") -> String {

        return get_dir_start(dir_root, name, "XYplane", Q_length, step) + ".cut_\(at_k)"
    }

    //Formally Axis
    func get_XZ_plane_dir(step: tStep, at_j: tNi, Q_length: Int, name: String="plot", dir_root: String=".") -> String {

        return get_dir_start(dir_root, name, "XZplane", Q_length, step) + ".cut_\(at_j)"
    }

    //Formally Slice
    func get_YZ_plane_dir(step: tStep, at_i: tNi, Q_length: Int, name: String="plot", dir_root: String=".") -> String {

        return get_dir_start(dir_root, name, "YZplane", Q_length, step) + ".cut_\(at_i)"
    }

    func get_volume_dir(step: tStep, Q_length: Int, name: String="plot", dir_root: String=".") -> String {
        return get_dir_start(dir_root, name, "volume", Q_length, step)
    }



    func get_capture_at_blade_angle_dir(step: tStep, angle: Int, blade_id: Int, Q_length: Int, name: String="plot_", dir_root: String=".") -> String {

        return get_dir_start(dir_root, name, "rotational_capture", Q_length, step) + ".angle_\(angle).blade_id_\(blade_id)"
    }


    func get_axis_when_blade_angle_dir(step: tStep, angle: Int, Q_length: Int, name: String="plot", dir_root: String=".") -> String {

        return get_start(dir_root: dir_root, name: name, plot_type: "YZplane", Q_length: Q_length, step: step) + ".angle_\(angle)"
    }



    func get_rotating_sector_dir(step: tStep, angle: Int, Q_length: Int, name: String="plot", dir_root: String=".") -> String {

        return "Not Implemented Yet"
    }





    //TODO
    func get_version_from_directory(dir: String) -> tNi {return 0}
    func get_name_from_directory(dir: String) -> String {return "Not Implemented"}
    func get_step_from_directory(dir: String) -> tNi {return 0}



    func get_plot_type_from_directory(dir: String) -> String? {

        if dir.contains("XYplane") {return "XYplane"}
        if dir.contains("XZplane") {return "XZplane"}
        if dir.contains("YZplane") {return "YZplane"}
        if dir.contains("volume") {return "volume"}
        if dir.contains("rotational_capture") {return "rotational_capture"}
        //        if dir.contains("sector") {return "sector"}

        return nil
    }


    func get_cut_from_directory(dir: String) -> Int? {

        if let rangeOfCut = dir.range(of: "cut_") {

            //TOFIX should get cars until "." or the end
            let x = Int(String(dir[rangeOfCut.upperBound...]))

            return x
        }

        return nil
    }




    func plot_type_in_dir(plot_type: String, dir: String) -> Bool {
        return dir.contains(plot_type)
    }


    func get_dir_delta(delta: Int, dir: String) -> String? {

        //    example load_dir = plot_slice.XZplane.V_4.Q_4.step_00002100.cut_276
        //    should return 276 plus or minus delta

        if let x = get_cut_from_dir(dir: dir) {

            let new_cut = String(x + delta)
            var new_dir = dir

            if let cutRange = new_dir.range(of: String(x)) {
                new_dir.replaceSubrange(cutRange, with: new_cut)
                return new_dir
            }
        }
        return nil
    }












} //end of class
