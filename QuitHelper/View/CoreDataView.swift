//
//  CoreDataView.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/03/31.
//

import SwiftUI
import CoreData

struct CoreDataView: View {
    @State var cigarettes: Int64 = 0
    @State var date: Date = Date()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: DailyData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \DailyData.date, ascending: false)])
    private var data: FetchedResults<DailyData>
    
    var body: some View {
        List {
            ForEach(data) { dailyData in
                HStack {
                    Text("\(dailyData.cigarettes)개피")
                    Spacer()
                    Text("\(dailyData.date!, formatter: itemFormatter)")
                }
            }
            .onDelete(perform: deleteData)
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
    
    private func addData() {
        withAnimation {
            let dailyData = DailyData(context: viewContext)
            dailyData.cigarettes = cigarettes
            dailyData.date = Date()
            saveContext()
        }
    }
    
    private func deleteData(offsets: IndexSet) {
        withAnimation {
            offsets.map { data[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
