//
//  HomeViewModel.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 14/10/23.
//

import SwiftUI

class HomeViewModel : ObservableObject {
    @Published var userData: UserModel?
    @Published var userDataStatus: ApiStatus = .initial
    private let networkManager = NetworkManager()
    
    func fetchUserData(userName: String) {
        userDataStatus = .fetching
        networkManager.fetchGitHubUser(url: StringConstant.usersApi + userName) { userModel, msg in
            if var userModel = userModel {
                let date = self.dateConverter(dateString: userModel.updatedAt ?? "")
                userModel.updatedAt = date
                self.userData = userModel
                withAnimation {
                    self.userDataStatus = .success
                }
            } else {
                self.userDataStatus = .failed
            }
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func dateConverter(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC") // Ensure the time zone is set to UTC

        if let date = dateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "MMM dd, yyyy 'at' HH:mm:ss"
            outputDateFormatter.timeZone = TimeZone.current // Format in your local time zone
            let formattedDate = outputDateFormatter.string(from: date)
            return formattedDate
        } else {
            return StringConstant.unknown
        }
    }
}

enum ApiStatus {
    case initial, fetching, success, failed
}
