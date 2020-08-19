//
//  SignUpView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 17/08/2020.
//

import SwiftUI
import Firebase

struct SignUpView : View {
    
    //MARK: - PROPERTIES
    @ObservedObject var model : ModelData
    
    
    //MARK: - BODY
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            
            
            // MAIN VSTACK
            VStack{
                
                Spacer(minLength: 0)
                
                ZStack{
                    
                    if UIScreen.main.bounds.height < 750{
                        Image("logo")
                            .resizable()
                            .frame(width: 130, height: 130)
                    } else {
                        Image("logo")
                    }
                } //: ZSTACK
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)
                    .padding(.top)
                
                
                // VSTACK PER IL TESTO ("New Profile, create a new...")
                VStack(spacing: 4){
                    
                    // HSTACK
                    HStack(spacing: 0){
                        
                        Text("New")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.white)
                        
                        Text("Profile")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(Color("txt"))
                    } //: HSTACK
                    
                    Text("Create a profile for you!")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                } //: VSTACK
                .padding(.top)
                
                
                // VSTACK PER I TEXTFIELD
                VStack(spacing: 20){
                    
                    CustomTextField(image: "person", placeHolder: "Nickname", txt: $model.nickname_SignUp)
                    
                    CustomTextField(image: "person", placeHolder: "Email", txt: $model.email_SignUp)
                    
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password_SignUp)
                    
                    CustomTextField(image: "lock", placeHolder: "Re-Enter", txt: $model.reEnterPassword)
                } //: VSTACK
                .padding(.top)
                
                
                //: ZSTACK
                Button(action: model.signUp) {
                    
                    Text("SIGNUP")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                } //: BUTTON
                .padding(.vertical,22)
                
                Spacer(minLength: 0)
            } //: VSTACK
            
            
            // BUTTON X (per chiudere la pagina)
            Button(action: {model.isSignUp.toggle()}) {
                
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            } //: BUTTON
            .padding(.trailing)
            .padding(.top,10)
            
            if model.isLoading{
                
                LoadingView()
            }
        })
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        // Alerts...
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok"), action: {
                 
                // if email link sent means closing the signupView....
                
                if model.alertMsg == "Email Verification Has Been Sent. Verify Your Email."{
                    
                    model.isSignUp.toggle()
                    model.email_SignUp = ""
                    model.nickname_SignUp = ""
                    model.password_SignUp = ""
                    model.reEnterPassword = ""
                }
                
            }))
        })
    }
}

