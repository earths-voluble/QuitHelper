//
//  StatusView.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/03/29.
//
import CoreData
import Charts
import SwiftUI

struct StatusView: View {
    @ObservedObject var viewModel = StatusViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: DailyData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \DailyData.date, ascending: false)])
    
    private var data: FetchedResults<DailyData>
    
    var body: some View {
        let costPerSmoke = viewModel.pricePerPack / 20
        let thisMonthCost = costPerSmoke * Int(viewModel.thisMonthlySum)
        let totalCost = costPerSmoke * Int(viewModel.totalSum)
        let actualWishThingPrice = viewModel.wishThingPrice * 10000
        let rectangleColor = colorScheme == .light ? Color.pink : Color.pink
        let textColor = colorScheme == .light ? viewModel.lightModeTextColor : viewModel.darkModeTextColor
        
        NavigationView {
            
            VStack {
                if viewModel.chartIsDisabled {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color(red: 0.8, green: 0.8, blue: 0.8))
                        .frame(height: 250)
                        .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 10, x: 0.0, y: 10)
                    
                        .overlay(
                            VStack {
                                Text("데이터를 6일 이상 기록하시면")
                                    .foregroundColor(textColor)
                                Text("이곳에서 차트를 확인할 수 있습니다.")
                                    .foregroundColor(textColor)
                            }
                        )
                        .onTapGesture {
                            viewModel.checkData()
                        }
                    
                    Spacer()
                    
                } else {
                    Chart {
                        ForEach(data) { dailyData in
                            BarMark (
                                x: .value("Day", dailyData.date ?? Date(), unit: .day),
                                y: .value("Cigarettes", dailyData.cigarettes),
                                width: .ratio(0.6)
                            )
                        }
                    }
                    .frame(height: 250)
                    Spacer()
                }
                VStack {
                    HStack {
                        createRectangle(text1: "갑당 가격", text2: "\(viewModel.pricePerPack)원", rectColor: rectangleColor, textColor: textColor)
                        
                        if viewModel.wishThing != "" && totalCost != 0 && viewModel.wishThingPrice != 0 {
                            createRectangle(text1: "\(viewModel.wishThing)", text2:"\(String(format: "%.2f", Double(totalCost) / Double(actualWishThingPrice)))개", rectColor: rectangleColor, textColor: textColor)
                        } else {
                            createRectangle(text1: "가지고 싶은 물건을", text2: "설정해 보세요", rectColor: rectangleColor, textColor: textColor)
                        }
                    }
                    
                    HStack {
                        createRectangle(text1: "이번 달 흡연량", text2: "\(viewModel.thisMonthlySum)개피", rectColor: rectangleColor, textColor: textColor)
                        createRectangle(text1: "이번 달 흡연 비용", text2: "\(thisMonthCost)원", rectColor: rectangleColor, textColor: textColor)
                    }
                    HStack {
                        createRectangle(text1: "기록 시작 후 흡연량", text2: "\(viewModel.totalSum)개피", rectColor: rectangleColor, textColor: textColor)
                        createRectangle(text1: "기록 시작 후 흡연 비용", text2: "\(totalCost)원", rectColor: rectangleColor, textColor: textColor)
                    }
                }
                
                Spacer()
                
            }
            .navigationTitle("현황")
        }
        .onAppear(perform: viewModel.initializeFunctions)
    }
    
    func createRectangle(text1: String, text2: String, rectColor: Color, textColor: Color) -> some View {
        Rectangle()
            .fill(rectColor)
            .frame(width: 185, height: 100)
            .cornerRadius(30)
            .shadow(color: colorScheme == .dark ? .clear : .gray, radius: 10, x: 0.0, y: 10)
            .overlay(
                VStack {
                    Spacer()
                    Text(text1)
                        .foregroundColor(textColor)
                    Spacer()
                    Text(text2)
                        .foregroundColor(textColor)
                        .fontWeight(.bold)
                        .font(.title2)
                    
                    Spacer()
                }
            )
    }
}
