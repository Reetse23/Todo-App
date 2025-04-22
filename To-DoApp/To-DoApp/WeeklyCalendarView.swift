import SwiftUI

struct WeeklyCalendarView: View {
    @State private var isShowingMonthCalendar = false
    @State private var selectedDate = Date()
    @State private var scrollToNextWeek = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d"
        return formatter
    }()
    
    private var dateRange: [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: selectedDate))!
        let dates = (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
        return dates
    }
    
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate)!
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("MenuColor"))
                    })
                    Spacer()
                    Text(dateFormatter.string(from: selectedDate))
                        .font(.headline)
                        .foregroundColor(Color("MenuColor"))
                    Spacer()
                    
//                    Button(action: {
//                        isShowingMonthCalendar = true
//                    }, label: {
//                        Image(systemName: "calendar")
//                            .foregroundColor(Color("MenuColor"))
//                    })
//                    .popover(isPresented: $isShowingMonthCalendar, arrowEdge: .bottom) {
////                        MonthCalendarView(selectedDate: $selectedDate)
////                            .frame(width: 300, height: 400)
//                    }
                    
                    Button(action: {
                        selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate)!
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color("MenuColor"))
                    })
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                HStack(spacing: 0) {
                    ForEach(dateRange, id: \.self) { date in
                        VStack {
                            Text(dateFormatter.string(from: date))
                                .font(.caption)
                                .foregroundColor(isSameDay(selectedDate, date) ? Color("dateColor") : Color.white)
                                .multilineTextAlignment(.leading)
                            
                            
                            Spacer()
                        }
                        .frame(width: geometry.size.width / 12)
                        .padding(10)
                        .background(isSameDay(selectedDate, date) ? Color.blue.opacity(0) : Color.clear)
                        .onTapGesture {
                            selectedDate = date
                            if date == dateRange.last {
                                scrollToNextWeek = true
                            }
                        }
                    }
                }
                .frame(height: 75)
                Divider()
            }
        }
    }
}

struct WeeklyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
