//
//  ProfileView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 12/08/20.
//

import SwiftUI
import Firebase

struct ProfileView : View {
    
    @ObservedObject var model : ModelData
    
    var body: some View{

        VStack{
            
            Spacer()
            
            Text("Email: \(Auth.auth().currentUser?.email ?? "")")
            
            Button(action: model.logOut) {
                
                Text("Logout")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width / 3)
                    .background(Color("top"))
                    .clipShape(Capsule())
            }
            .padding(.vertical,22)
            
            Spacer()
        }
    }
}
