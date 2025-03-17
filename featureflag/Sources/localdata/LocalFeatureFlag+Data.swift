import Foundation

struct LocalFlag: Codable {
    
    static internal var data: Data {
        return """
    {
        "IOS-123": true
    }
""".data(using: .utf8)!
    }
    
    static var info: LocalFlag? {
        do {
            let info = try JSONDecoder().decode(
                LocalFlag.self,
                from: LocalFlag.data
            )
            
            return info
        } catch {
            return nil
        }
    }
    
    var dic: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        
        guard let json = try? JSONSerialization.jsonObject(
            with: data,
            options: []
        ) else { return [:] }
        
        guard let dic = json as? [String: Any] else { return [:] }
        
        return dic
    }
    
    static var dic: [String: Any] {
        
        guard let info = LocalFlag.info else { return [:] }
        
        guard let data = try? JSONEncoder().encode(info) else { return [:] }
        
        guard let json = try? JSONSerialization.jsonObject(
            with: data,
            options: []
        ) else { return [:] }
        
        guard let dic = json as? [String: Any] else { return [:] }
        
        return dic
    }
}
