//import SwiftUI
//import SwiftSVG
//
//class SVGParser {
//    static func parseSVG(_ svgString: String) -> [SVGPath] {
//        var paths: [SVGPath] = []
//        
//        // Parse the SVG string and extract paths
//        let components = svgString.components(separatedBy: "<path")
//        
//        for component in components.dropFirst() {
//            if let pathString = extractPathString(from: component),
//               let id = extractID(from: component),
//               let path = createPath(from: pathString) {
//                let bounds = path.boundingRect
//                let svgPath = SVGPath(id: id, path: path, bounds: bounds)
//                paths.append(svgPath)
//            }
//        }
//        
//        return paths
//    }
//    
//    private static func extractPathString(from component: String) -> String? {
//        guard let startIndex = component.range(of: "d=\"")?.upperBound,
//              let endIndex = component.range(of: "\"", range: startIndex..<component.endIndex)?.lowerBound else {
//            return nil
//        }
//        
//        return String(component[startIndex..<endIndex])
//    }
//    
//    private static func extractID(from component: String) -> String? {
//        guard let startIndex = component.range(of: "id=\"")?.upperBound,
//              let endIndex = component.range(of: "\"", range: startIndex..<component.endIndex)?.lowerBound else {
//            return UUID().uuidString
//        }
//        
//        return String(component[startIndex..<endIndex])
//    }
//    
//    private static func createPath(from pathString: String) -> Path? {
//        var path = Path()
//        var currentPoint = CGPoint.zero
//        var lastControlPoint: CGPoint?
//        
//        let commands = pathString.components(separatedBy: .whitespacesAndNewlines)
//        
//        for command in commands {
//            if command.isEmpty { continue }
//            
//            let components = command.components(separatedBy: ",")
//            guard components.count >= 2,
//                  let x = Double(components[0]),
//                  let y = Double(components[1]) else {
//                continue
//            }
//            
//            let point = CGPoint(x: x, y: y)
//            
//            if path.isEmpty {
//                path.move(to: point)
//            } else {
//                if let controlPoint = lastControlPoint {
//                    path.addQuadCurve(to: point, control: controlPoint)
//                    lastControlPoint = nil
//                } else {
//                    path.addLine(to: point)
//                }
//            }
//            
//            currentPoint = point
//        }
//        
//        return path.isEmpty ? nil : path
//    }
//    
//    static func findPathAtPoint(_ point: CGPoint, in paths: [SVGPath]) -> SVGPath? {
//        // First try to find exact hit
//        if let exactHit = paths.first(where: { path in
//            path.bounds.contains(point) && path.path.contains(point)
//        }) {
//            return exactHit
//        }
//        
//        // If no exact hit, find the closest path
//        return paths.min(by: { path1, path2 in
//            let distance1 = distance(from: point, to: path1.bounds)
//            let distance2 = distance(from: point, to: path2.bounds)
//            return distance1 < distance2
//        })
//    }
//    
//    private static func distance(from point: CGPoint, to rect: CGRect) -> CGFloat {
//        let dx = max(rect.minX - point.x, point.x - rect.maxX, 0)
//        let dy = max(rect.minY - point.y, point.y - rect.maxY, 0)
//        return sqrt(dx * dx + dy * dy)
//    }
//} 
