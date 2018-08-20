//
//  Table.swift
//  JSONParse
//
//  Created by GAURAV on 15/07/18.
//  Copyright © 2018 Jahnavi. All rights reserved.
//

import UIKit

class Table {

    var title: String?
    var imageURL: String?
    var textForLabel: String?
    
    
    init(imageURL: String?,textForLabel: String?,title: String?) {
        self.imageURL = imageURL
        self.textForLabel = textForLabel
        self.title = title
    }

}
