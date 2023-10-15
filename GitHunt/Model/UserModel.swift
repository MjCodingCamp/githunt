//
//  UserModel.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 14/10/23.
//

import Foundation

struct UserModel : Codable {
    let login : String?
    let id : Int?
    let avatarUrl : String?
    let htmlUrl : String?
    let followersUrl : String?
    let name : String?
    let location : String?
    let publicRepos : Int?
    let publicGists : Int?
    let followers : Int?
    var updatedAt : String?

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case name = "name"
        case location = "location"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers = "followers"
        case updatedAt = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        login = try values.decodeIfPresent(String.self, forKey: .login)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        followersUrl = try values.decodeIfPresent(String.self, forKey: .followersUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        publicRepos = try values.decodeIfPresent(Int.self, forKey: .publicRepos)
        publicGists = try values.decodeIfPresent(Int.self, forKey: .publicGists)
        followers = try values.decodeIfPresent(Int.self, forKey: .followers)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }

}
