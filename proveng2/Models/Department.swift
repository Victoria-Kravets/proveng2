//
//  Department.swift
//  proveng2
//
//  Created by Pavel Nikitinsky on 8/27/17.
//  Copyright © 2017 Provectus. All rights reserved.
//


import Foundation
import RealmSwift
import ObjectMapper

class Department: BaseModel {

    @objc dynamic var url: String? = nil
    @objc dynamic var name: String? = nil

    override class func objectForMapping(map: Map) -> BaseMappable? {
        return Department()
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        if let context = map.context as? ContextType{
            switch context {
            case .write:
                url          <- map["url"]
                name         <- map["name"]
            case .short:
                break
            }
        } else {
            url           <- map["url"]
            name          <- map["name"]
        }
    }
}

