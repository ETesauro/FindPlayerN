//
//  ModelData.swift
//  FindPlayer (iOS)
//
//  Created by Emmanuel Tesauro on 17/08/2020.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ModelData : ObservableObject {
    
    //MARK: - PROPERTIES
    @Published var email = ""
    @Published var password = ""
    @Published var isSignUp = false
    @Published var email_SignUp = ""
    @Published var nickname_SignUp = ""
    @Published var password_SignUp = ""
    @Published var reEnterPassword = ""
    @Published var isLinkSend = false
    // AlertView With TextFields....
    
    // Error Alerts...
    
    @Published var alert = false
    @Published var alertMsg = ""
    
    // User Status....
    
    @AppStorage("log_Status") var status = false
    
    // Loading ...
    
    @Published var isLoading = false
    
    let db = Firestore.firestore()
    
    
    //MARK: - Login
    func login(){
        
        // checking all fields are inputted correctly...
        
        if email == "" || password == ""{
            
            self.alertMsg = "Fill the contents properly."
            self.alert.toggle()
            return
        }
        
        withAnimation{
            
            self.isLoading.toggle()
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            
            withAnimation{
                
                self.isLoading.toggle()
            }
            
            if err != nil{
                
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            // checking if user is verifed or not...
            // if not verified means lgging out...
            
            let user = Auth.auth().currentUser
            
            if !user!.isEmailVerified{
                
                self.alertMsg = "Please verify email address."
                self.alert.toggle()
                // logging out...
                try! Auth.auth().signOut()
                
                return
            }
            
            // setting user status as true....
            
            withAnimation{
                
                self.status = true
            }
        }
    }
    
    
    
    
    //MARK: - SignUp
    func signUp(){
        
        // checking....
        
        if email_SignUp == "" || password_SignUp == "" || reEnterPassword == ""{
            
            self.alertMsg = "Fill contents proprely."
            self.alert.toggle()
            return
        }
        
        if password_SignUp != reEnterPassword{
            
            self.alertMsg = "Password mismatch."
            self.alert.toggle()
            return
        }
        
        withAnimation{
            
            self.isLoading.toggle()
        }
        
        Auth.auth().createUser(withEmail: email_SignUp, password: password_SignUp) { (result, err) in
            
            withAnimation{
                
                self.isLoading.toggle()
            }
            
            if err != nil{
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            
            
            //MARK: - SALVO L'UTENTE NEL DATABASE MYSQL
            registerUser(name: self.nickname_SignUp, surname: self.password_SignUp, email: self.email_SignUp)
            
            
            
            
            // MARK: - MANDO IL LINK DI VERIFICA
            result?.user.sendEmailVerification(completion: { (err) in
                
                if err != nil{
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
//                // SALVO L'UTENTE NEL DATABASE (MI SERVE?)
//                let richiesteRef = self.db.collection("users")
//                var maxCount = 0
//
//                richiesteRef.getDocuments() { (querySnapshot, err) in
//                    maxCount = querySnapshot!.count + 1
//                    print(maxCount)
//
//                    richiesteRef.document("users\(maxCount)").setData([
//                        "nickname": self.nickname_SignUp,
//                        "email": self.email_SignUp,
//                        "id": maxCount
//                    ])
//
//                    print("Registrazione effettuata")
//                }
                
                //MARK: - AVVISO DI CONTROLLARE L'EMAIL
                self.alertMsg = "Email verification has been sent. Verify your email."
                self.alert.toggle()
            })
        }
    }
    
    
    
    
    //MARK: - Logout
    func logOut(){
        
        try! Auth.auth().signOut()
        
        withAnimation{
            
            self.status = false
        }
        
        // clearing all data...
        
        email = ""
        password = ""
        email_SignUp = ""
        password_SignUp = ""
        reEnterPassword = ""
    }
    
    
    
    
    //MARK: - ResetPassword
    func resetPassword(){
        
        let alert = UIAlertController(title: "Reset Password", message: "Enter your email to reset your password", preferredStyle: .alert)
        
        alert.addTextField { (password) in
            password.placeholder = "Email"
        }
        
        let proceed = UIAlertAction(title: "Reset", style: .default) { (_) in
            
            // Sending Password Link...
            
            if alert.textFields![0].text! != ""{
                
                withAnimation{
                    
                    self.isLoading.toggle()
                }
                
                Auth.auth().sendPasswordReset(withEmail: alert.textFields![0].text!) { (err) in
                    
                    withAnimation{
                        
                        self.isLoading.toggle()
                    }
                    
                    if err != nil{
                        self.alertMsg = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    // ALerting User...
                    self.alertMsg = "Password reset link has been sent."
                    self.alert.toggle()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(proceed)
        
        // Presenting...
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}
