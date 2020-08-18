//
//  CustomTextFieldView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 17/08/2020.
//

import SwiftUI

struct CustomTextField : View {
    
    //MARK: - PROPERTIES
    var image : String
    var placeHolder : String
    @Binding var txt : String
    
    
    //MARK: - BODY
    var body: some View{
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            Image(systemName: image)
                .font(.system(size: 24))
                .foregroundColor(Color("bottom"))
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
            
            ZStack{
                if placeHolder == "Password" || placeHolder == "Re-Enter"{
                    SecureField(placeHolder, text: $txt)
                }
                else {
                    TextField(placeHolder, text: $txt)
                }
                
            } //: ZSTACK
            .padding(.horizontal)
            .padding(.leading,65)
            .frame(height: 60)
            .background(Color.white.opacity(0.2))
            .clipShape(Capsule())
        } //: ZSTACK
        .padding(.horizontal)
    }
}
