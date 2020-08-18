//
//  LoginView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 17/08/2020.
//

import SwiftUI
import Firebase

struct LoginView : View {
    
    //MARK: - PROPERTIES
    @ObservedObject var model : ModelData
    
    
    //MARK: - BODY
    var body: some View{
        
        ZStack{
            
            // MAIN VSTACK
            VStack{
                
                Spacer(minLength: 0)
                
                ZStack{
                    
                    if UIScreen.main.bounds.height < 750{
                        
                        Image("logo-1")
                            .resizable()
                            .padding()
                            .frame(width: 130, height: 130)
                            .background(Color.white, alignment: .center)
                            .clipShape(Circle())
                    }
                    else{
                        Image("logo-1")
                            .resizable()
                            .padding(25)
                            .frame(width: 190, height: 190)
                            .background(Color.white, alignment: .center)
                            .clipShape(Circle())
                    }
                } //: ZSTACK
                    .padding(.horizontal)
                    .padding(.vertical,20)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)
                    .padding(.top)
                
                VStack(spacing: 4){
                    
                    HStack(spacing: 0){
                        
                        Text("Find")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(.white)
                        
                        Text("Player")
                            .font(.system(size: 35, weight: .heavy))
                            .foregroundColor(Color("txt"))
                    } //: HSTACK
                    
                    Text("and win every match!")
                        .foregroundColor(Color.black.opacity(0.3))
                        .fontWeight(.heavy)
                    
                } //: VSTACK
                .padding(.top)
                
                
                // VSTACK TEXTFIELD
                VStack(spacing: 20){
                    
                    CustomTextField(image: "person", placeHolder: "Email", txt: $model.email)
                    
                    CustomTextField(image: "lock", placeHolder: "Password", txt: $model.password)
                    
                } //: VSTACK
                .padding(.top)
                
                
                // BUTTON LOGIN
                Button(action: model.login) {
                    
                    Text("LOGIN")
                        .fontWeight(.bold)
                        .foregroundColor(Color("bottom"))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                } //: BUTTON
                .padding(.top,22)
                
                
                // HSTACK PER REGISTRARSI
                HStack(spacing: 12){
                    
                    Text("Don't have an account?")
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    Button(action: {model.isSignUp.toggle()}) {
                        
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                } //: HSTACK
                .padding(.top,25)
                
                Spacer(minLength: 0)
                
                
                // BUTTON PER RESETTARE LA PASSWORD
                Button(action: model.resetPassword) {
                    
                    Text("Forget Password?")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                } //: BUTTON
                .padding(.vertical,22)

            } //: VSTACK
            
            if model.isLoading{
                
                LoadingView()
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .fullScreenCover(isPresented: $model.isSignUp) {
            
            SignUpView(model: model)
        }
        // Alerts...
        .alert(isPresented: $model.alert, content: {
            
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok")))
        })
    }
}

