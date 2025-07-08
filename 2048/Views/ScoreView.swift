import SwiftUI

struct ScoreView: View {
    @ObservedObject var model : GridModel
    var title: String
    init(title: String, model: GridModel){
        self.title = title
        self.model = model
    }
    
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(Color.white)
            
            Text("\(model.score)")
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
