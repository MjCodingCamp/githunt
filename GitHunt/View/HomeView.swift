//
//  HomeView.swift
//  GitHunt
//
//  Created by Mohammad Jeeshan on 14/10/23.
//

import SwiftUI
import Lottie

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var textField = ""
    private let loaderView = LottieView(animationView: LottieAnimationView(name: StringConstant.loader))
    private let userNotFound = LottieView(animationView: LottieAnimationView(name: StringConstant.userNotFound))
    private let waitingView = LottieView(animationView: LottieAnimationView(name: StringConstant.waiting))
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometryProxy in
                VStack(alignment: .leading, content: {
                    HStack(content: {
                        Text(StringConstant.searchGitHubUsers)
                            .modifier(CustomTxtModifier(size: 24, weight: .semibold))
                        Spacer()
                    }).padding(.bottom, 20)
                    HStack{
                        TextField(StringConstant.enterUserName, text: $textField)
                            .textFieldStyle(.roundedBorder)
                        Button {
                            if !textField.isEmpty {
                                viewModel.fetchUserData(userName: textField)
                                textField = ""
                            }
                            viewModel.hideKeyboard()
                        } label: {
                            Text(StringConstant.search)
                        }.buttonStyle(CustomBtnStyle())
                    }
                    if (viewModel.userDataStatus == .success) {
                        Spacer().frame(height: geometryProxy.size.height * 0.1)
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    ProfileView
                                        .padding(.trailing, 10)
                                    VStack(alignment: .leading) {
                                        Text(viewModel.userData?.login ?? StringConstant.unknown)
                                            .modifier(CustomTxtModifier(size: 18, weight: .bold))
                                        HStack {
                                            Image(StringConstant.user)
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                            Text(viewModel.userData?.name ?? StringConstant.unknown)
                                                .modifier(CustomTxtModifier(size: 14, weight: .light))
                                        }
                                        HStack {
                                            Image(StringConstant.location)
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                            Text(viewModel.userData?.location ?? StringConstant.unknown)
                                                .modifier(CustomTxtModifier(size: 14, weight: .light))
                                        }
                                    }
                                    Spacer()
                                }
                                HStack {
                                    Text(StringConstant.repos)
                                        .modifier(CustomTxtModifier(size: 14, weight: .semibold))
                                    Text("\(viewModel.userData?.publicRepos ?? 0)")
                                        .modifier(CustomTxtModifier(size: 14, weight: .light))
                                    
                                    Spacer().frame(width: geometryProxy.size.width * 0.05)
                                    
                                    Text(StringConstant.gists)
                                        .modifier(CustomTxtModifier(size: 14, weight: .semibold))
                                    Text("\(viewModel.userData?.publicGists ?? 0)")
                                        .modifier(CustomTxtModifier(size: 14, weight: .light))
                                    
                                    Spacer().frame(width: geometryProxy.size.width * 0.05)
                                    
                                    Text(StringConstant.followers)
                                        .modifier(CustomTxtModifier(size: 14, weight: .semibold))
                                    Text("\(viewModel.userData?.followers ?? 0)")
                                        .modifier(CustomTxtModifier(size: 14, weight: .light))
                                    Spacer()
                                }.padding(.leading, 10)
                                HStack {
                                    Text(StringConstant.userLastUpdate)
                                        .modifier(CustomTxtModifier(size: 10, weight: .light))
                                    
                                    Text(viewModel.userData?.updatedAt ?? "")
                                        .modifier(CustomTxtModifier(size: 10, weight: .bold))
                                }
                                .padding(EdgeInsets(top: 15, leading: 10, bottom: 0, trailing: 0))
                            }
                            NavigationLink {
                                FollowerView(followerUrl: viewModel.userData?.followersUrl ?? "")
                            } label: {
                                Image(StringConstant.more)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 10)
                            }

                        }
                        .padding(10)
                        .cornerRadius(6)
                        .background(ColorConstant.secondaryColor)
                        .transition(.slide)
                    }
                    if (viewModel.userDataStatus == .fetching) {
                        loaderView.onAppear(){
                            loaderView.playAnimation()
                        }
                    }
                    if (viewModel.userDataStatus == .failed) {
                        userNotFound.onAppear(){
                            userNotFound.playAnimation()
                        }
                    }
                    if (viewModel.userDataStatus == .initial) {
                        waitingView.onAppear(){
                            waitingView.playAnimation()
                        }.frame(height: geometryProxy.size.height * 0.5)
                        HStack {
                            Spacer()
                            Text(StringConstant.weAreWaiting)
                                .modifier(CustomTxtModifier(size: 18, weight: .medium))
                            Spacer()
                        }
                    }
                }).padding()
            }
        }
    }
    
    var ProfileView: some View {
        AsyncImage(url: URL(string: viewModel.userData?.avatarUrl ?? "")) { phase in
            switch phase {
            case .empty:
                Image(StringConstant.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
                
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            case .failure(_):
                Image(StringConstant.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
            @unknown default:
                EmptyView()
            }
        }
    }
    


}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
