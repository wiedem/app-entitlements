import SwiftSyntax
import SwiftSyntaxMacroExpansion
import SwiftSyntaxMacrosGenericTestSupport
import Testing

extension Testing.SourceLocation {
    init(_ location: TestFailureLocation) {
        self.init(
            fileID: location.fileID,
            filePath: location.filePath,
            line: location.line,
            column: location.column
        )
    }
}

extension Issue {
    @discardableResult
    static func record(_ failure: TestFailureSpec) -> Issue {
        record(
            Comment(rawValue: failure.message),
            sourceLocation: .init(failure.location)
        )
    }
}

func assertMacroExpansion(
    _ originalSource: String,
    expandedSource expectedExpandedSource: String,
    diagnostics: [SwiftSyntaxMacrosGenericTestSupport.DiagnosticSpec] = [],
    macroSpecs: [String: SwiftSyntaxMacroExpansion.MacroSpec],
    applyFixIts: [String]? = nil,
    fixedSource expectedFixedSource: String? = nil,
    testModuleName: String = "TestModule",
    testFileName: String = "test.swift",
    indentationWidth: SwiftSyntax.Trivia = .spaces(4),
    fileID: StaticString = #fileID,
    filePath: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
) {
    assertMacroExpansion(
        originalSource,
        expandedSource: expectedExpandedSource,
        diagnostics: diagnostics,
        macroSpecs: macroSpecs,
        applyFixIts: applyFixIts,
        fixedSource: expectedFixedSource,
        testModuleName: testModuleName,
        testFileName: testFileName,
        indentationWidth: indentationWidth,
        failureHandler: { Issue.record($0) },
        fileID: fileID,
        filePath: filePath,
        line: line,
        column: column
    )
}

@discardableResult
func macroExpansionFailure(
    _ originalSource: String,
    expandedSource expectedExpandedSource: String,
    diagnostics: [SwiftSyntaxMacrosGenericTestSupport.DiagnosticSpec] = [],
    macroSpecs: [String: SwiftSyntaxMacroExpansion.MacroSpec],
    applyFixIts: [String]? = nil,
    fixedSource expectedFixedSource: String? = nil,
    testModuleName: String = "TestModule",
    testFileName: String = "test.swift",
    indentationWidth: SwiftSyntax.Trivia = .spaces(4),
    fileID: StaticString = #fileID,
    filePath: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
) -> MacroExpansionFailure? {
    var expansionFailure: MacroExpansionFailure?

    assertMacroExpansion(
        originalSource,
        expandedSource: expectedExpandedSource,
        diagnostics: diagnostics,
        macroSpecs: macroSpecs,
        applyFixIts: applyFixIts,
        fixedSource: expectedFixedSource,
        testModuleName: testModuleName,
        testFileName: testFileName,
        indentationWidth: indentationWidth,
        failureHandler: { expansionFailure = MacroExpansionFailure($0) },
        fileID: fileID,
        filePath: filePath,
        line: line,
        column: column
    )
    return expansionFailure
}

final class MacroExpansionFailure {
    let testFailure: TestFailureSpec?

    init(_ testFailure: TestFailureSpec) {
        self.testFailure = testFailure
    }
}
