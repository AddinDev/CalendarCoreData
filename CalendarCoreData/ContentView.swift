//
//  ContentView.swift
//  CalendarCoreData
//
//  Created by addin on 28/01/21.
//

import SwiftUI
import CalendarList

struct ContentView: View {
    @ObservedObject var net = Net()
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: EventCD.entity(), sortDescriptors: []) var event: FetchedResults<EventCD>
    let screen = UIScreen.main.bounds
    var events: [CalendarEvent<String>] {
        var calendarEvents: [CalendarEvent<String>] = []
        for i in event {
            let newEvent = CalendarEvent(dateString: i.start ?? "", data: i.summary ?? "")
            calendarEvents.append(newEvent)
            
        }
        return calendarEvents
        
    }
    
    var body: some View {
        CalendarList(events: events) { event in
            Text("\(event.data)")
        }
        .frame(width: screen.width)
        .listStyle(PlainListStyle())
        .accentColor(.green)
        //        List(net.events) { e in
        //            Text(e.summary)
        //        }
        .onAppear {
            net.getCalendarEvents()
            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                for e in net.events {
                    let newEvent = EventCD(context: moc)
                    newEvent.id = UUID()
                    newEvent.summary = e.summary
                    newEvent.start = e.start.formattedDate
                    try? moc.save()
                }
                print(event)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
