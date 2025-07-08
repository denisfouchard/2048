import SwiftUI

struct BestScoreView: View {
    @ObservedObject var scoreManager: ScoreManager
    var title: String
    init(title: String, scoreManager: ScoreManager){
        self.title = title
        self.scoreManager = scoreManager
    }
    
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(Color.white)
            
            Text("\(scoreManager.bestScore)")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
    
               
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color.gray)
                .cornerRadius(4)
        )
    }
    
}

#Preview {
    ScoreView(title:"Score", model: GridModel(test:true))
}
