private import AppEntitlementsCore
public import SwiftSyntax
public import SwiftSyntaxMacros

public struct EntitlementMacro: AccessorMacro {
    static let appEntitlementsNamespace = "AppEntitlements"
    static let entitlementIdentifyingType = "Entitlement"

    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        // Extract property type from declaration
        guard let varDecl = declaration.as(VariableDeclSyntax.self),
              let binding = varDecl.bindings.first,
              let propertyType = binding.typeAnnotation?.type
        else {
            throw MacroError.invalidDeclaration
        }

        // Get the base type (remove optional)
        let baseType = extractBaseType(from: propertyType)

        // Check if there's an identifier argument
        guard let arguments = node.arguments?.as(LabeledExprListSyntax.self),
              let firstArgument = arguments.first
        else {
            throw MacroError.missingIdentifierArgument
        }

        var identifier = firstArgument.expression.trimmedDescription

        // If identifier starts with '.', prepend 'Entitlement'
        if identifier.hasPrefix(".") {
            identifier = "\(Self.entitlementIdentifyingType)\(identifier)"
        }

        // Type-inferred variant: @Entitlement(.identifier)
        let getter = generateGetter(
            identifier: identifier,
            propertyType: baseType
        )
        return [getter]
    }
}

private extension EntitlementMacro {
    static func generateGetter(
        identifier: String,
        propertyType: String
    ) -> AccessorDeclSyntax {
        // Check if type is an array
        if let arrayElementType = extractArrayElementType(from: propertyType) {
            // Array type: use getArray
            return """
            get throws {
                try \(raw: appEntitlementsNamespace).getArray(for: \(raw: identifier), elementType: \(raw: arrayElementType).self)
            }
            """
        } else {
            // Non-array type: use getValue
            return """
            get throws {
                try \(raw: appEntitlementsNamespace).getValue(for: \(raw: identifier), as: \(raw: propertyType).self)
            }
            """
        }
    }

    static func extractBaseType(from type: TypeSyntax) -> String {
        // Handle optional types (String? -> String, [String]? -> [String])
        if let optionalType = type.as(OptionalTypeSyntax.self) {
            return optionalType.wrappedType.trimmedDescription
        }
        return type.trimmedDescription
    }

    static func extractArrayElementType(from type: String) -> String? {
        // Check if type is in format [ElementType]
        if type.hasPrefix("["), type.hasSuffix("]") {
            let startIndex = type.index(after: type.startIndex)
            let endIndex = type.index(before: type.endIndex)
            return String(type[startIndex..<endIndex])
        }
        return nil
    }
}

enum MacroError: Error, CustomStringConvertible {
    case missingIdentifierArgument
    case invalidDeclaration

    var description: String {
        switch self {
        case .missingIdentifierArgument:
            return "@Entitlement requires an identifier argument, e.g., @Entitlement(.teamIdentifier) or @Entitlement(CustomEntitlement.key)"
        case .invalidDeclaration:
            return "@Entitlement can only be applied to variable declarations with an explicit type annotation"
        }
    }
}
