/// Errors that can occur when working with property list values.
public enum PropertyListValueError: Error, Sendable {
    /// An error occurred while decoding the property list value.
    case decodingError(any Error)
    /// The data type is not supported for this operation.
    case unsupportedDataType
    /// The requested type is not supported for automatic conversion.
    case unsupportedType(Any.Type)
    /// The property list value could not be converted to the requested type.
    case typeMismatch(expected: Any.Type, actual: PropertyListValue)
}
