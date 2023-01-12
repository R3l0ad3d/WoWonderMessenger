//
//  ChangeColor.swift
//  WoWonder
//
//  Created by Mac on 17/11/22.
//  Copyright © 2022 ScriptSun. All rights reserved.
//

import Foundation

struct ChangeColor {
    var ChangeColorHEX: String?
}

func DummYHexCodeData() -> [ChangeColor] {
    
    var objChangeColor: [ChangeColor] = []
    
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#C83747"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#5C8DF5"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#444B57"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#1E947A"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#833CA2"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#022539"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#FB991C"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#F03568"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#ED7440"))
    objChangeColor.append(ChangeColor(ChangeColorHEX: "#00AEEE"))
    
    
    return objChangeColor
}
