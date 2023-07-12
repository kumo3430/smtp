//
//  ContentView.swift
//  smtp
//
//  Created by 呂沄 on 2023/7/11.
//

import SwiftUI
import SwiftSMTP

struct ContentView: View {
    
    @State private var email = "3430coco@gmail.com"
    @State private var password = ""
    @State private var verify = 0
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("你的帳號：")
                    TextField("email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                HStack {
                    Text("你的密碼：")
                    TextField("password", text: $password)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                }
                NavigationLink {
                    verifyRegister(verify: $verify)
                        .onAppear() {
                            Task {
                                await random()
                                await sendMail()
                            }
                        }
                } label: {
                    Text("進行驗證")
                }

            }
            .navigationTitle("註冊")
//            .padding()
        }
    }
    func random() async {
        verify = Int.random(in: 1..<99999999)
        print("隨機變數為：\(verify)")
    }
    
    func sendMail() async {
        let smtp = SMTP(
            hostname: "smtp.gmail.com",     // SMTP server address
            email: "3430yun@gmail.com",        // username to login
            password: "knhipliavnpqxwty"            // password to login
        )
        
//        let megaman = Mail.User(name: "coco", email: "3430coco@gmail.com")
        let megaman = Mail.User(name: "coco", email: email)
        let drLight = Mail.User(name: "Yun", email: "3430yun@gmail.com")

        
        let mail = Mail(
            from: drLight,
            to: [megaman],
            subject: "歡迎使用我習慣了！這是您的驗證信件",
            text: "以下是您的驗證碼： \(String(verify))"
        )
        
        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
            } else {
                print("Send email successful")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
