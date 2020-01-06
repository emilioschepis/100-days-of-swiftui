//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Emilio Schepis on 22/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

enum SortType {
    case name, date
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortSheet = false
    @State private var sort = SortType.name
    
    let filter: FilterType
        
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var sortedProspect: [Prospect] {
        switch sort {
        case .name:
            return filteredProspects.sorted(by: { $0.name < $1.name })
        case .date:
            return filteredProspects.sorted(by: { $0.added < $1.added })
        }
    }

    var scanButton: some View {
        Button(action: {
            self.isShowingScanner = true
        }) {
            Image(systemName: "qrcode.viewfinder")
            Text("Scan")
        }
    }
    
    var sortButton: some View {
        Button(action: {
            self.isShowingSortSheet = true
        }) {
            Image(systemName: "arrow.up.arrow.down")
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            self.prospects.add(person)
        case .failure(let error):
            print("Scanning failed", error)
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            // This would only trigger at 9am
            // var dateComponents = DateComponents()
            // dateComponents.hour = 9
            // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("Not authorized.")
                    }
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedProspect) { prospect in
                    HStack {
                        if self.filter == .none {
                            Image(systemName: prospect.isContacted
                                ? "checkmark.circle"
                                : "questionmark.diamond")
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark uncontacted" : "Mark contacted") {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: sortButton, trailing: scanButton)
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr],
                                simulatedData: "Paul Hudson \(Int.random(in: 1...100))\npaul@hackingwithswift.com",
                                completion: self.handleScan)
            }
            .actionSheet(isPresented: $isShowingSortSheet) {
                ActionSheet(title: Text("Sort"), buttons: [
                    ActionSheet.Button.default(Text("By name"), action: {
                        self.sort = .name
                    }),
                    ActionSheet.Button.default(Text("By date"), action: {
                        self.sort = .date
                    }),
                    ActionSheet.Button.cancel()
                ])
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
