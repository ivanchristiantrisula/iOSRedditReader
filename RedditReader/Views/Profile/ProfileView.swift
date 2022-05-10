//
//  UserInfoView.swift
//  RedditReader
//
//  Created by Ivan Christian on 09/05/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @ObservedObject var profileViewModel : ProfileViewModel
    var body: some View {

        VStack(){
            Spacer()
            HStack{
                KFImage(URL(string: profileViewModel.userInfo?.snoovatarImg ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
            }
            HStack{
                //Comment Karma
                VStack{
                    Text(String(profileViewModel.userInfo?.commentKarma ?? 0))
                    Text("Comment Karma").font(.subheadline)
                }
                Spacer()
                //Post Karma
                VStack{
                    Text(String(profileViewModel.userInfo?.linkKarma ?? 0))
                    Text("Post Karma").font(.subheadline)
                }
                Spacer()
                //Account Age
                VStack{
                    Text(String("2y 1mo"))
                    Text("Account Age").font(.subheadline)
                }
                
            }.padding()
            List{
                NavigationLink("Posts", destination: EmptyView())
                NavigationLink("Comments", destination: EmptyView())
                
            }
        }
        .onAppear(perform: {
            profileViewModel.fetchProfile()
        })
        .navigationTitle(profileViewModel.userInfo?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
        
    
}

//struct UserInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserInfoView(userInfo: UserInfo(id: "222", name: "ayyayym8", snoovatarImg : "https://i.redd.it/snoovatar/avatars/0c3d2060-652a-47e0-a743-c11f09caabea.png", commentKarma: 100, isMod: false, isEmployee: false, linkKarma: 100, created: 1432421.0))
//    }
//}
