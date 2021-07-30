//
//  DateButtonView.swift
//  Todo App
//
//  Created by datNguyen on 7/30/21.
//

import SwiftUI

struct DateButtonView: View {
    var title: String
    @ObservedObject var homeData: HomeViewModel
    var body: some View {
        Button(action: {homeData.updateDate(value: title)}, label: {
            Text(title)
                .foregroundColor(homeData.checkDate() == title ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(
                    homeData.checkDate() == title ?
                        LinearGradient(gradient: .init(colors: [Color("Color"), Color("Color1")]), startPoint: .leading, endPoint: .trailing)
                        : LinearGradient(gradient: .init(colors: [.white]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(6)
        })
    }
}

struct DateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DateButtonView(title: "ok", homeData: HomeViewModel())
    }
}
