//
//  NetworkManager.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 14/10/23.
//

import Alamofire

class NetworkManager {
        
    func fetchGitHubUser(url: String, result: @escaping (UserModel?, String) -> Void) {
        AF.request(StringConstant.baseUrl + url)
            .responseDecodable(of: UserModel.self) { response in
                if response.response?.statusCode == 200 {
                    if let user = response.value {
                        debugPrint("Debug Response: \(user)")
                        result(user, StringConstant.success)
                    } else {
                        result(nil, StringConstant.dataNotFound)
                        debugPrint(StringConstant.dataNotFound)
                    }
                } else if response.response?.statusCode == 404 {
                    result(nil, StringConstant.dataNotFound)
                    debugPrint(StringConstant.dataNotFound)
                } else {
                    if let error = response.error {
                        result(nil, error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    } else {
                        result(nil, StringConstant.somethingWentWrong)
                        debugPrint(StringConstant.somethingWentWrong)
                    }
                }
            }
    }
    
    func fetchFollowerList(url: String, result: @escaping ([FollowerModel]?, String) -> Void) {
        AF.request(url)
            .responseDecodable(of: [FollowerModel].self) { response in
                if response.response?.statusCode == 200 {
                    if let followers = response.value {
                        debugPrint("Debug Response: \(followers)")
                        result(followers, StringConstant.success)
                    } else {
                        result(nil, StringConstant.dataNotFound)
                        debugPrint(StringConstant.dataNotFound)
                    }
                } else if response.response?.statusCode == 404 {
                    result(nil, StringConstant.dataNotFound)
                    debugPrint(StringConstant.dataNotFound)
                } else {
                    if let error = response.error {
                        result(nil, error.localizedDescription)
                        debugPrint(error.localizedDescription)
                    } else {
                        result(nil, StringConstant.somethingWentWrong)
                        debugPrint(StringConstant.somethingWentWrong)
                    }
                }
            }
    }
    
}
