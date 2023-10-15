//
//  FollowerModel.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 15/10/23.
//

import Foundation

struct FollowerModel : Codable {
    let login : String?
    let id : Int?
    let avatarUrl : String?
    let htmlUrl : String?

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
    }

}
