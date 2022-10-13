//
//  Post.swift
//  sample
//
//  Created by Leandro Berli on 12/10/2022.
//

import Foundation

struct Post: Codable {
    var copyright: String?
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
}
