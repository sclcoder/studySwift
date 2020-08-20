//
//  User.swift
//  Qiushibaike
//
//  Created by MJ Lee on 2019/8/10.
//  Copyright © 2019 MJ Lee. All rights reserved.
//
import KakaJSON
struct User: Convertible {
    let thumb: String = ""
    let medium: String = ""
    let age: Int = 0
    let id: String = ""
    let name: String = ""
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        if property.name == "name" { return "login" }
        return property.name
    }
}
