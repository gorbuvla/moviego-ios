//
//  File.swift
//  moviego-ios
//
//  Created by Vlad Gorbunov on 08/05/2019.
//  Copyright © 2019 Vlad Gorbunov. All rights reserved.
//

import Cloudinary

// any better way to do this?
extension CLDCloudinary {
    
    static var shared: CLDCloudinary {
        return CLDCloudinary(configuration: CLDConfiguration(cloudName: "do04iflqy"))
    }
}
