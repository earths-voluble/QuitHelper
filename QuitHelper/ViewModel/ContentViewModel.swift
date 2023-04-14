//
//  ContentViewModel.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/04/09.
//

import SwiftUI
import CoreData

class ContentViewViewModel: ObservableObject {
    @Published var cigarettes: Int64 = 0
    @Published var date: Date = Date()
    @Published var todaySmoked: Int64 = 0

    private let viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchTodaysCigarettesSum()
    }

    func incrementCigarettes() {
        cigarettes += 1
    }

    func decrementCigarettes() {
        if cigarettes > 0 {
            cigarettes -= 1
        }
    }

    func addData() {
        withAnimation {
            let dailyData = DailyData(context: viewContext)
            dailyData.cigarettes = cigarettes
            dailyData.date = Date()
            saveContext()
            cigarettes = 0
            fetchTodaysCigarettesSum()
        }
    }

    func addDataDebug(debugDate: Date) {
        withAnimation {
            let dailyData = DailyData(context: viewContext)
            dailyData.cigarettes = cigarettes
            dailyData.date = debugDate
            saveContext()
            cigarettes = 0
            fetchTodaysCigarettesSum()
        }
    }

    func clearData() {
        cigarettes = 0
        date = Date()
    }

    private func fetchTodaysCigarettesSum() {
        let fetchRequest = NSFetchRequest<DailyData>(entityName: "DailyData")

        let currentDate = Date()
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        if let startDate = Calendar.current.date(from: dateComponents) {
            dateComponents.day! += 1
            if let endDate = Calendar.current.date(from: dateComponents) {
                let predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
                fetchRequest.predicate = predicate
            }
        }

        do {
            let results = try viewContext.fetch(fetchRequest)
            let cigarettesSum = results.reduce(0) { $0 + $1.cigarettes }
            todaySmoked = cigarettesSum
        } catch {
            print("Could not fetch today's cigarettes sum")
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occurred: \(error)")
        }
    }
}
