//
//  URL.swift
//
//  Created by CS193p Instructor.
//  Copyright (c) 2016 Stanford University. All rights reserved.
//
 
import Foundation

struct DemoURL
{
    static let Stanford = "http://news.samsungdisplay.com/wp-content/uploads/2018/08/8.jpg"

    static let NASA = [
        "Cassini" : "https://science.nasa.gov/wp-content/uploads/2023/09/PIA14582.jpg?w=1280&format=webp",
        "Earth" : "https://www.nasa.gov/wp-content/uploads/2015/07/187_1003705_americas_dxm.png?resize=1536,1536",
        "Saturn" : "https://science.nasa.gov/wp-content/uploads/2023/09/IMG003379.jpg?w=1280&format=webp"
    ]
    
    static func NASAImageNamed(imageName: String?) -> NSURL? {
        if let urlstring = NASA[imageName ?? ""] {
            return NSURL(string: urlstring)
        } else {
            return nil
        }
    }
}
