import Foundation

enum ExerciseURL {
    case bicycleStanding
    case runingKneesUp
    case jumping
    case reverseTwist
    case mountaineer
    case relax
    
    var getURL: String {
        switch self {
        case .bicycleStanding:
            return "bicycleStanding"
        case .runingKneesUp:
            return "runingKneesUp"
        case .jumping:
            return "jumping"
        case .reverseTwist:
            return "reverseTwist"
        case .mountaineer:
            return "mountaineer"
        case .relax:
            return "doRelax"
        }
    }
}
