import SwiftUI


import SwiftUI

struct TileGridView: View {
    @ObservedObject var model: GridModel
    private let columns = Array(repeating: GridItem(.flexible()), count: 4)
    private let spacing: CGFloat = 16
    private let padding: CGFloat = 16
    
    @Namespace private var tileNamespace

    // MARK: - Grid layout
    var body: some View {
        GeometryReader { geometry in
            let gridSize = geometry.size.width - 2 * padding
            let tileSize = (gridSize - spacing * 3) / 4

            VStack {
                LazyVGrid(columns: columns, spacing: spacing) {
                    ForEach(0..<model.dimensions.rows, id: \.self) { row in
                        ForEach(0..<model.dimensions.cols, id:\.self){ col in
                            let value = model.gridMatrix[row][col]
                            tileView(value: value, tileSize: tileSize)
                                .id("\(row)-\(col)")
                                
                        }
                    }
                }
                .padding(padding)
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.yellow)
            )
        }
        .aspectRatio(1, contentMode: .fit)
    }

    // MARK: - Tile View
    @ViewBuilder
    private func tileView(value: Int, tileSize: CGFloat) -> some View {
        Rectangle()
            .fill(color(for: value))
            .frame(width: tileSize, height: tileSize)
            .cornerRadius(10)
            .overlay(
                Text(displayText(for: value))
                    .font(value < 1023 ? .largeTitle : .title)
                    .fontWeight(.bold)
                    .foregroundColor(tileTextColor(for: value))
                    .accessibilityLabel("tileNumber")
            )
            .transition(.scale.combined(with: .opacity))
            .animation(.easeInOut, value: value)
    }

    // MARK: - Helpers

    private func displayText(for value: Int) -> String {
        value == 0 ? "" : String(value)
    }

    private func tileTextColor(for value: Int) -> Color {
        if value < 5 {
            return Color("Tile24Font")
        } else if value > 2048 {
            return .white
        } else {
            return Color("TileAboveFont")
        }
    }

    private func color(for value: Int) -> Color {
        switch value {
        case 2: return Color("Tile2")
        case 4: return Color("Tile4")
        case 8: return Color("Tile8")
        case 16: return Color("Tile16")
        case 32: return Color("Tile32")
        case 64: return Color("Tile64")
        case 128: return Color("Tile128")
        case 256: return Color("Tile256")
        case 512: return Color("Tile512")
        case 1024: return Color("Tile1024")
        case 2048: return Color("Tile2048")
        default:
            return value > 2048 ? Color("TileMax") : Color.gray.opacity(0.3)
        }
    }
}


struct TileGridPreviewWrapper: View {

    
    @StateObject var model = GridModel(test: true);
    

    var body: some View {
        TileGridView(model: model)
    }
    
}

#Preview {
    TileGridPreviewWrapper()
}
