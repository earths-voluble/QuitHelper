//
//  StatusViewModel.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/04/14.
//

import CoreData
import Charts
import SwiftUI

class StatusViewModel: ObservableObject {
    @AppStorage("pricePerPack") var pricePerPack: Int = 4500
    @AppStorage("wishThing") var wishThing: String = ""
    @AppStorage("wishThingPrice") var wishThingPrice: Int = 0
    
    @Published var chartIsDisabled = true
    @Published var thisMonthlySum: Int64 = 0
    @Published var totalSum: Int64 = 0

    var selectedSort = "일별"
    let sortedBy = ["일별", "월별"]
    
    let lightModeTextColor = Color.white
    let darkModeTextColor = Color.black
    
    func initializeFunctions() {
        checkData()
        calculateMonthlySum()
        calculateTotalSum()
    }
    
    func checkData() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyData")
        
        do {
            let results = try context.fetch(fetchRequest) as! [DailyData]
            let uniqueDays = Set(results.compactMap { $0.date }.map { Calendar.current.startOfDay(for: $0) })
            if uniqueDays.count > 5 {
                chartIsDisabled = false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func calculateMonthlySum() {
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        let startDate = calendar.date(from: components)!
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)!

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyData")
        let datePredicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", argumentArray: [startDate, endDate])
        fetchRequest.predicate = datePredicate

        let expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "cigarettes")])
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "sumOfCigarettes"
        expressionDescription.expression = expression
        expressionDescription.expressionResultType = .integer64AttributeType

        fetchRequest.propertiesToFetch = [expressionDescription]
        fetchRequest.resultType = .dictionaryResultType

        do {
            let results = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            if let resultDict = results.first as? [String: Int64] {
                thisMonthlySum = resultDict["sumOfCigarettes"] ?? 0
            }
        } catch {
            print("Error fetching data")
        }
    }
    
    func calculateTotalSum() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyData")

        let expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "cigarettes")])
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "sumOfCigarettes"
        expressionDescription.expression = expression
        expressionDescription.expressionResultType = .integer64AttributeType

        fetchRequest.propertiesToFetch = [expressionDescription]
        fetchRequest.resultType = .dictionaryResultType

        do {
            let results = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            if let resultDict = results.first as? [String: Int64] {
                totalSum = resultDict["sumOfCigarettes"] ?? 0
            }
        } catch {
            print("Error fetching data")
        }
    }
}
