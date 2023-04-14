//
//  SettingsViewModel.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/04/05.
//
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("startedDate") var startedDate: Date = Date()
    @AppStorage("pricePerPack") var pricePerPack: Int = 4500
    @AppStorage("wishThing") var wishThing: String = ""
    @AppStorage("wishThingPrice") var wishThingPrice: Int = 0
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: startedDate)
    }
}
