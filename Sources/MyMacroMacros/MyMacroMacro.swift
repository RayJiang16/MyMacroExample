import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CaseDetectionMacro {
    
}

extension CaseDetectionMacro: MemberMacro {
    
    public static func expansion<Declaration: DeclGroupSyntax, Context: MacroExpansionContext>(
        of node: AttributeSyntax,
        providingMembersOf declaration: Declaration,
        in context: Context
    ) throws -> [DeclSyntax] {
        var names: [String] = []
        for member in declaration.memberBlock.members { // 循环获取所有属性、方法
            let elements = member.decl.as(EnumCaseDeclSyntax.self)?.elements
            if let propertyName = elements?.first?.name.description {
                names.append(propertyName) // 取出枚举名
            }
        }
        
        return names.map { // 拼接实现代码
            """
            var \("is" + capitalized($0)): Bool {
                if case .\($0) = self { true }
                else { false }
            }
            """
        }.map {
            DeclSyntax(stringLiteral: $0)
        }
    }
    
    /// 首字母大写
    private static func capitalized(_ str: String) -> String {
        var str = str
        let firstChar = String(str.prefix(1)).uppercased()
        str.replaceSubrange(...str.startIndex, with: firstChar)
        return str
    }
}

@main
struct MyMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CaseDetectionMacro.self,
    ]
}
