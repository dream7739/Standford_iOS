//
//  URL.swift
//
//  Created by CS193p Instructor.
//  Copyright (c) 2016 Stanford University. All rights reserved.
//
 
import Foundation

struct DemoURL
{
    static let Stanford = "https://hanmiglobal.com/sabo/pc/2018_spring/images/pc/2018/spring/sub/img_5_3.jpg"

    static let NASA = [
        "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
        "Earth" : "https://image.kmib.co.kr/online_image/2014/1103/201411030916_61130008820668_1.jpg",
        "Saturn" : "http://cdn.dealbada.com/restapi/image/resizeWidth/1080/data/editor/1704/662da3deae4ce37323b05a7468bcd0e2_1491548875_5244.jpg"
    ]
    
    static func NASAImageNamed(imageName: String?) -> NSURL? {
        if let urlstring = NASA[imageName ?? ""] {
            return NSURL(string: urlstring)
        } else {
            return nil
        }
    }
}
