//
//import swiftTLS
//import spartanX
//
//import struct Foundation.Data
//
//public class SXTLSLayer {
//    public var supportingMethods: SendMethods = [.send]
//    var service: SXStreamService
//    var servContext: SXTLSContext
//    
//    public init(service: SXStreamService, context: SXTLSContext) {
//        self.service = service
//        self.servContext = context
//    }
//}
//
//extension TLSClient : Readable, Writable {
//    
//    public var availableBytesa: Int {
//        return 4096
//    }
//
//    public func write(data: Data) throws {
//        return try self.write(data: data)
//    }
//    
//    public func read(size: Int) throws -> Data? {
//        return try self.read(size: size)
//    }
//    
//    public func done() {
//        self.close()
//    }
//}
//
//extension SXTLSLayer {
//    public func received(data: Data, from connection: SXQueue) throws -> Bool {
//        return try service.recevied(data: data, from: connection)
//    }
//    
//    public func exceptionRaised(_ exception: Error, on connection: SXQueue) {
//        if let error = exception as? TLSError {
//            switch error {
//            case TLSError.filedescriptorNotWriteable, TLSError.filedescriptorNotReadable:
//                return
//            default:
//                break
//            }
//        }
//        
//        self.service.exceptionRaised(exception, on: connection)
//    }
//    
//    public func accpeted(socket: SXClientSocket, as connection: SXQueue) throws {
//        let client_context = try self.servContext.accept(socket: socket.sockfd)
//        connection.userInfo["tls"] = client_context
//        connection.readAgent = connection.userInfo["tls"] as! TLSClient
//        connection.writeAgent = connection.userInfo["tls"] as! TLSClient
//    }
//}
