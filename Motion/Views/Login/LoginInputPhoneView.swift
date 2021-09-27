//
//  LoginInputPhoneView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/26.
//

import SwiftUI
import MotionComponents
import Introspect

struct LoginInputPhoneView: View {
    @StateObject var vm = LoginVM()
    var textFieldConfig = MTTextFieldStyle.Config()
    
    var body: some View {
        VStack(alignment: .center, spacing: 26.0) {
            Text("输入手机号码")
                .font(.mt.title2.mtBlod(), textColor: .black)
            
            TextField("手机号码", text: $vm.phone)
                .mtTextFieldStyle($vm.phone, config: textFieldConfig)
                .keyboardType(.numberPad)
                .introspectTextField { textField in
                    vm.phoneTextField = textField
                }
                            
            Spacer()
            
            rightBtn
        }
        .padding(.horizontal, 36)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image.mt.load(.Logo)
                    .resizable()
                    .foregroundColor(.mt.accent_purple)
                    .mtFrame(square: 44)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.58) {
                vm.phoneTextField?.becomeFirstResponder()
            }
        }
//        .onDisappear {
//            MTHelper.closeKeyboard()
//        }
        
    }
    
    @State var isPresentedLoginCode = false
    var rightBtn: some View {
        NavigationLink {
            LoginValidateCodeView()
                .environmentObject(vm)
//            isPresentedLoginCode.toggle()
        } label: {
            Image.mt.load(.Chevron_right_On)
                .foregroundColor(.white)
        }
        .mtButtonStyle(.cricleDefult(.black))
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.bottom, 16)
        .opacity(vm.isPhoneInvalidate ? 0.6 : 1)
        .disabled(vm.isPhoneInvalidate)
//        .fullScreenCover(isPresented: $isPresentedLoginCode, content: {
//            LoginValidateCodeView()
//                .environmentObject(vm)
//        })
    }
    
}

struct LoginInputPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginInputPhoneView()
                .environmentObject(LoginVM())
        }
    }
}
