//
//  TabButtonView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 12/08/20.
//

import SwiftUI

struct tabButton : View {
    
    //MARK: - PROPERTIES
    var title : String
    @Binding var tab : String
    
    
    //MARK: - BODY
    var body: some View{
        
        Button(action: {tab = title}) {
            
            HStack(spacing: 8){
                
                Image(title)
                    .renderingMode(.template)
                    .foregroundColor(tab == title ? .white : .gray)
                
                
                Text(tab == title ? title : "")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            } //: HSTACK
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(Color("top").opacity(tab == title ? 1 : 0))
            .clipShape(Capsule())
        } //: BUTTON
    }
}
