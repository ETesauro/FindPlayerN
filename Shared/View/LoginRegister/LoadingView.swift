//
//  LoadingView.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 17/08/2020.
//

import SwiftUI
import Firebase

struct LoadingView : View {
    
    //MARK: - PROPERTIES
    @State var animation = false
    
    
    //MARK: - BODY
    var body: some View{
        
        VStack{
            LottieView(filename: "loading2")
                .frame(width: 200, height: 200, alignment: .center)
                .background(Color.white, alignment: .center)
            
            //            Circle()
            //                .trim(from: 0, to: 0.7)
            //                .stroke(Color("bottom"),lineWidth: 8)
            //                .frame(width: 75, height: 75)
            //                .rotationEffect(.init(degrees: animation ? 360 : 0))
            //                .padding(50)
        } //: VSTACK
        .cornerRadius(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
        .onAppear(perform: {
            withAnimation(Animation.linear(duration: 1)){
                animation.toggle()
            }
        }) //: ONAPPEAR
    }
}
