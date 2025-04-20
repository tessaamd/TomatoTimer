import SwiftUI
import Foundation
import Combine

class TimerManager: ObservableObject {
    @Published var timeRemaining: Int
    @Published var isWorkTime: Bool = true
    @Published var isTimerRunning = false
    private let workDuration = 25 * 60
    private let breakDuration = 5 * 60
    private var timer: AnyCancellable?
    
    init(){
        self.timeRemaining = workDuration
    }
    
    func formattedTime() -> String{
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func switchMode(){
        isWorkTime.toggle()
        timeRemaining = isWorkTime ? workDuration : breakDuration
    }
    
    func startTimer(){
        guard timer == nil else {return}
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink{ [weak self] _ in
                guard let self = self else{return}
                if self.timeRemaining > 0{
                    self.timeRemaining -= 1
                }else{
                    self.switchMode()
                }}
    }
    
    func pauseTimer(){
        timer?.cancel()
        timer = nil
    }
    
    func resetTimer(){
        pauseTimer()
        timeRemaining = workDuration
        isWorkTime = true
    }
    
}


@main
struct TomatoTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
