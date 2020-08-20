//
//  Item.swift
//  Qiushibaike
//
//  Created by MJ Lee on 2019/8/10.
//  Copyright © 2019 MJ Lee. All rights reserved.
//
import KakaJSON

struct Item: Convertible {
    let content: String = ""
    let commentsCount: Int = 0
    let lowUrl: String = ""
    let highUrl: String = ""
    let originUrl: String = ""
    let publishedAt: Int = 0
    let user: User! = nil
    let hotComment: Comment? = nil
    
    func kj_modelKey(from property: Property) -> ModelPropertyKey {
        return property.name.kj.underlineCased()
    }
}
