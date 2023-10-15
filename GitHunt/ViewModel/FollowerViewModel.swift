//
//  FollowerViewModel.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 15/10/23.
//

import SwiftUI

class FollowerViewModel: ObservableObject {
    @Published var followerData: [FollowerModel]?
    @Published var followerDataStatus: ApiStatus = .initial
    private let networkManager = NetworkManager()
    
    func fetchFollowers(url: String) {
        followerDataStatus = .fetching
        networkManager.fetchFollowerList(url: url) { followers, msg in
            if let followerData = followers {
                self.followerData = followerData
                withAnimation {
                    self.followerDataStatus = .success
                }
            } else {
                self.followerDataStatus = .failed
            }
        }
    }
}
