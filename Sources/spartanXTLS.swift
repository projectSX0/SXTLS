
import swiftTLS
import spartanX

import struct Foundation.Data

public typealias SXTLSContext = TLSServer
public typealias CString = UnsafePointer<Int8>
public typealias SXConnection = SXQueue
public typealias ShouldProceed = Bool

public let YES = true
public let NO = false

public class SXTLSLayer {
    public var supportingMethods: SendMethods = [.send]
    var service: SXService
    var servContext: SXTLSContext
    
    public init(service: SXService, context: SXTLSContext) {
        self.service = service
        self.servContext = context
        self.service.supportingMethods = [.send]
    }
}

extension TLSClient : Readable, Writable {
    
    public var availableBytesa: Int {
        return 4096
    }
    
    public func read(size: Int) throws -> Data? {
        let data: Data = try self.read(size: size)
        return data.length == 0 ? nil : data
    }
    
    public func write(data: Data) throws {
        let _: Int = try self.write(data: data)
    }
    
    public func done() {
        self.close()
    }
}

extension SXTLSLayer : SXStreamService {
    
    public func received(data: Data, from connection: SXConnection) throws -> ShouldProceed {
        return try service.received(data: data, from: connection)
    }
    
    public func exceptionRaised(_ exception: Error, on connection: SXQueue) -> ShouldProceed {
        if let error = exception as? TLSError {
            switch error {
            case TLSError.filedescriptorNotWriteable, TLSError.filedescriptorNotReadable:
                return YES
            default:
                return NO
            }
        }
        
        return self.service.exceptionRaised(exception, on: connection)
    }
    
    public func accepted(socket: SXClientSocket, as connection: SXConnection) throws {
        let client_context = try self.servContext.accept(socket: socket.sockfd)
        connection.userInfo["tls"] = client_context
        connection.readAgent = connection.userInfo["tls"] as! TLSClient
        connection.writeAgent = connection.userInfo["tls"] as! TLSClient
    }
    
    public func connectionWillTerminate(_ connection: SXQueue) {
        guard let service = service as? SXStreamService else {
            return
        }
        service.connectionWillTerminate(connection)
    }
    
    public func connectionDidTerminate(_ connection: SXQueue) {
        guard let service = service as? SXStreamService else {
            return
        }
        service.connectionDidTerminate(connection)
    }
}
