//
//  Inline.swift
//  TD_Qvec_post_process
//
//  Created by vedran on 15/04/2019.
//

import Foundation

@inline(__always) func cmpf( _ A: Float, _ B: Float, _ epsilon: Float = 0.05) -> Bool
{
    return (abs(A - B) < epsilon);
}

@inline(__always) func grid_ijk_on_node( _ gi: tNi, _ gj: tNi, _ gk: tNi, _ f: Node_Bounds) -> Bool {
    
    if (gi >= f.i0 && gi <= f.i1 && gj >= f.j0 && gj <= f.j1 && gk >= f.k0 && gk <= f.k1) {
        return true;
    }
    
    return false;
    
}

@inline(__always) func get_node_bounds( _ node: Node_Dims, _ grid: Grid_Dims) -> Node_Bounds{
    
    var ret: Node_Bounds = Node_Bounds();
    
    ret.i0 = (node.x * tNi(node.idi))
    if (node.idi>0) {
        ret.i0 += 1;
    }
    
    ret.i1 = (node.x * (tNi(node.idi) + node.x))
    if (node.idi == grid.ngx-1) {
        ret.i1 += 1;
    }
    
    ret.j0 = (node.y * tNi(node.idj))
    if (node.idj>0) {
        ret.j0 += 1;
    }
    
    ret.j1 = (node.y * (tNi(node.idj) + node.y))
    if (node.idj == grid.ngy-1) {
        ret.j1 += 1;
    }
    
    ret.k0 = (node.z * tNi(node.idk))
    if (node.idk > 0) {
        ret.k0 += 1;
    }
    
    ret.k1 = (node.z * (tNi(node.idk) + node.z))
    if (node.idk == grid.ngz - 1) {
        ret.k1 += 1;
    }
    
    return ret;
}
