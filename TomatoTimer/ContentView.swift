import SwiftUI

struct ActionButtonView: View{
    let title: String
    let color: Color
    var body: some View{
        Text(title)
            .font(.title3)
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(color)
            .cornerRadius(10)
            .shadow(radius: 3)
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    var body: some View {
        VStack() {
            Image("Image")
                .padding()
            Text("Время для твоих идей!")
                .font(.system(size: 23, weight: .regular, design: .rounded))
                .padding(.horizontal)
            Text(timerManager.formattedTime())
                .font(.system(size: 50, weight: .bold, design: .monospaced))
            Text(timerManager.isWorkTime ? "Осталось работать" : "Время в перерыве")
                .font(.title)
                .foregroundColor(timerManager.isWorkTime ? .pink : .gray)
        }
        HStack(spacing: 15){
            Button(action:{
                timerManager.pauseTimer()
            }) {
                ActionButtonView(title: "Пауза", color: .gray)
            }
            Button(action: {
                timerManager.startTimer()
            }) {
                ActionButtonView(title: timerManager.isWorkTime ? "Начать работу" : "Начать перерыв", color: .pink)
            }
            Button(action:{
                timerManager.resetTimer()
            }) {
                ActionButtonView(title: "Сброс", color: .orange)
            }
        }
    }
    private func startAction(){
        timerManager.startTimer()
    }
    private func pauseAction(){
        timerManager.pauseTimer()
    }
    private func resetAction(){
        timerManager.resetTimer()
    }
}

#Preview {
    ContentView()
}
