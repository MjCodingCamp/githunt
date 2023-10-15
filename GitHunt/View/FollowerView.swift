//
//  FollowerView.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 15/10/23.
//

import SwiftUI
import Lottie

struct FollowerView: View {
    @ObservedObject private var viewModel = FollowerViewModel()
    let followerUrl: String
    private let loaderView = LottieView(animationView: LottieAnimationView(name: StringConstant.loader))
    private let dataNotFound = LottieView(animationView: LottieAnimationView(name: StringConstant.userNotFound))
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(StringConstant.followerList)
                .modifier(CustomTxtModifier(size: 20, weight: .bold))
                .padding(10)
            if (viewModel.followerDataStatus == .failed || viewModel.followerData?.isEmpty ?? false) {
                dataNotFound.onAppear(){
                    dataNotFound.playAnimation()
                }
            }
            if (viewModel.followerDataStatus == .success) {
                List {
                    ForEach(viewModel.followerData ?? [], id: \.id) { follower in
                        VStack(alignment: .leading) {
                            HStack {
                                AsyncImage(url: URL(string: follower.avatarUrl ?? "")) { phase in
                                    switch phase {
                                    case .empty:
                                        Image(StringConstant.avatar)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .foregroundColor(.gray)
                                        
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    case .failure(_):
                                        Image(StringConstant.avatar)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .foregroundColor(.gray)
                                            .clipShape(Circle())
                                    @unknown default:
                                        EmptyView()
                                    }
                                }.padding(.trailing, 10)
                                
                                VStack(alignment: .leading) {
                                    Text(follower.login ?? StringConstant.unknown)
                                        .modifier(CustomTxtModifier(size: 18, weight: .bold))
                                    HStack {
                                        Image(systemName: "link")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                        Text(follower.htmlUrl ?? StringConstant.unknown)
                                            .modifier(CustomTxtModifier(size: 14, weight: .light))
                                    }.onTapGesture {
                                        if let url = URL(string: follower.htmlUrl ?? "") {
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding(10)
                        .cornerRadius(6)
                        .background(ColorConstant.secondaryColor)
                        .transition(.slide)
                    }
                }.listStyle(.plain)
            }
            if (viewModel.followerDataStatus == .fetching) {
                loaderView.onAppear(){
                    loaderView.playAnimation()
                }
            }
        }.onAppear(){
            viewModel.fetchFollowers(url: followerUrl)
        }
    }

}

struct FollowerView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerView(followerUrl: "")
    }
}
