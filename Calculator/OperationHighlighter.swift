import UIKit

/// A class that manages highlighting and resetting operator buttons by swapping their background and title text colors.
final class OperationHighlighter {
    
    /// Highlights the given button by swapping its background color with its title label's text color.
    /// - Parameter button: The UIButton to highlight.
    func highlight(button: UIButton) {
        guard let titleColor = button.titleLabel?.textColor else { return }
        let backgroundColor = button.backgroundColor ?? .clear
        button.backgroundColor = titleColor
        button.setTitleColor(backgroundColor, for: .normal)
    }
    
    /// Resets the given button by swapping its background color with its title label's text color back to the original.
    /// - Parameter button: The UIButton to reset.
    func reset(button: UIButton) {
        guard let titleColor = button.titleLabel?.textColor else { return }
        let backgroundColor = button.backgroundColor ?? .clear
        button.backgroundColor = titleColor
        button.setTitleColor(backgroundColor, for: .normal)
    }
    
    /// Resets an array of buttons by swapping their background color with their title label's text color back to the original.
    /// - Parameter buttons: An array of UIButtons to reset.
    func resetAll(for buttons: [UIButton]) {
        buttons.forEach { reset(button: $0) }
    }
}
