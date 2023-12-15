import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import MyMacroMacros

let testMacros: [String: Macro.Type] = [
    "CaseDetection": CaseDetectionMacro.self,
]

final class MyMacroTests: XCTestCase {
    
    func testCaseDetectionMacro() {
        assertMacroExpansion(
            """
            @CaseDetection
            enum Animal {
                case cat
            }
            """,
            expandedSource: """
            enum Animal {
                case cat
            
                var isCat: Bool {
                    if case .cat = self {
                        true
                    }
                    else {
                        false
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
}
