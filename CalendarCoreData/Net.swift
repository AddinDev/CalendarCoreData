//
//  Net.swift
//  CalendarCoreData
//
//  Created by addin on 28/01/21.
//

import Foundation

class Net: ObservableObject {
    @Published var events: [Event] = []
    
    func getCalendarEvents() {
        guard let url = URL(string: "https://www.googleapis.com/calendar/v3/calendars/id.indonesian%23holiday%40group.v.calendar.google.com/events?key=AIzaSyD-6C-J66zB693n-r_n6BFVDSEoyRglf_0") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(Calendar.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.events = result.items
                    }
                } catch {
                    print("error: \(error)")
                }
            }
        }.resume()
    }
    
}

