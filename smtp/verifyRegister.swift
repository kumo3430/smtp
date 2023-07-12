//
//  verifyRegister.swift
//  smtp
//
//  Created by 呂沄 on 2023/7/12.
//

import SwiftUI

struct verifyRegister: View {
    
    @State private var Verify = ""
    @Binding var verify :Int
    @State private var messenge = ""
//    @State var timeRemaining = 300
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        VStack {
            Text("\(timeRemaining / 60)分 \(timeRemaining % 60)秒")
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
                .padding(100)
                .frame(width: 300)
            HStack {
                    Text("您的驗證碼：")
                    TextField("驗證碼", text: $Verify)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                        .padding()
                }
            Button {
                print("進行驗證中")
                doVerify()
            } label: {
                Text("進行驗證")
            }
            Text(messenge)
                .foregroundColor(Color.red)
        }
        .navigationTitle("驗證帳號")
    }
    
    func doVerify() {
        print("驗證碼為：\(verify)")
        print("使用者輸入為：\(Verify)")
        if (timeRemaining == 0) {
            print("時效已過，請重新再驗證一次")
            messenge = "時效已過，請重新再驗證一次"
        } else {
            if (Verify == String(verify)) {
                // 將使用者資料加入資料庫
                print("使用者輸入正確")
//                messenge = "使用者輸入正確"
            } else {
                print("使用者輸入錯誤")
                messenge = "使用者輸入錯誤"
            }
        }
    }
}

struct verifyRegister_Previews: PreviewProvider {
    static var previews: some View {
        @State var verify: Int = 00000000
        NavigationView {
            verifyRegister(verify: $verify)
        }
    }
}
