import Foundation

struct Dosage: Hashable {
    let amount: Double
    let unit: String
    
    var displayString: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        let formattedAmount = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return "\(formattedAmount) \(unit)"
    }
}
