import Foundation

/// A formatter for converting Float values to display strings and parsing strings to Float values.
public final struct CalculatorFormatter {
    
    /// Formats a Float value to a display string.
    ///
    /// - Parameter value: The Float value to format.
    /// - Returns: A string representation of the value. Integers are displayed without decimal places, while non-integers are displayed with minimal fractional digits without scientific notation.
    public static func format(_ value: Float) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", value)
        } else {
            // Format with up to 6 fractional digits, trimming trailing zeros
            var formatted = String(format: "%f", value)
            while formatted.contains(".") && (formatted.last == "0" || formatted.last == ".") {
                formatted.removeLast()
            }
            return formatted
        }
    }
    
    /// Parses a string into a Float value.
    ///
    /// - Parameter text: The string to parse.
    /// - Returns: The parsed Float value, or 0.0 if the string is nil, empty, or not a valid number.
    public static func parse(_ text: String?) -> Float {
        guard let text = text, !text.isEmpty else {
            return 0.0
        }
        return Float(text) ?? 0.0
    }
}
