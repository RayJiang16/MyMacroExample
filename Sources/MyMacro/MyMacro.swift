import Foundation

@attached(member, names: arbitrary)
public macro CaseDetection() = #externalMacro(module: "MyMacroMacros", type: "CaseDetectionMacro")
