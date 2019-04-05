import Foundation

import XCTest
@testable import Logo

class ParserTests: XCTestCase {
    
    func testInfixExpression() {
        verify(code: "2 + :b * 3", expected: "(2.0 + (:b * 3.0))")
    }
    
    func testInfixExpressionWithParenthesis() {
        verify(code: "(2 + :b) * 3", expected: "((2.0 + :b) * 3.0)")
    }

    func testIfExpression() {
        verify(code: "if (2 > 4) [ 2 + 2 ]", expected: "if ((2.0 > 4.0)) [ (2.0 + 2.0) ]")
    }
    
    func testIfElseExpression() {
        verify(code: "if (2 > 4) [ 2 + 2 ] else [ 3 + 4 ]", expected: "if ((2.0 > 4.0)) [ (2.0 + 2.0) ] else [ (3.0 + 4.0) ]")
    }
    
    func testFunctionLiteral() {
        verify(code: "to star :size :count 2 + 2 end", expected: "to star :size :count [ (2.0 + 2.0) ]")
    }
    
    func testCallExpression() {
        verify(code: "add(2) multiply(3 + 4)", expected: "add(2.0) multiply((3.0 + 4.0))")
    }
    
    func testFunctionLiteralAndCallExpression() {
        verify(code: "to star :size fd(100) rt(144) end star(3)",
               expected: "to star :size [ fd(100.0) rt(144.0) ] star(3.0)")
    }

    func testNotEqualOperator() {
        verify(code: "1 != 2", expected: "(1.0 != 2.0)")
    }
    
    func testRepeatExpression() {
        verify(code: "repeat 5 [ fd(10) ]", expected: "repeat 5 [ fd(10.0) ]")
    }
    
    func testNestedFunctionArgument() {
        verify(code: "square(multiply(2))", expected: "square(multiply(2.0))")
    }
    
    func testCallExpressionWithTwoArguments() {
        verify(code: "fern(:size * 5, :sign * 1)", expected: "fern((:size * 5.0), (:sign * 1.0))")
    }

    private func verify(code: String, expected: String) {
        let lexer = Lexer(code: code)
        let parser = Parser(lexer: lexer)
        let program = parser.parse()
        
        XCTAssertEqual(program.description, expected)
    }
}
