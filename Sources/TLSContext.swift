
import swiftTLS
import spartanX

import struct Foundation.Data
public typealias SXTLSContext = TLSServer
public typealias CString = UnsafePointer<Int8>

public class SXTLSLayer :  SXStreamSocketService {
    
    public var context: TLSServer
    public var dataHandler: (SXQueue, Data) -> Bool
    public var errHandler: ((SXQueue, Error) -> ())?
    public var acceptedHandler: ((inout SXClientSocket) -> ())?
    
    public var clientsMap = [Int32: TLSClient]()
    
    public init(service: SXService, context: TLSServer) {
        
        self.context = context
        
        self.dataHandler = service.dataHandler
        self.errHandler = { queue, error in
            switch error {
            case TLSError.filedescriptorNotWriteable, TLSError.filedescriptorNotReadable:
                break
            default:
                service.errHandler?(queue, error)
            }
        }
        
        self.acceptedHandler = { client in
            do {
                self.clientsMap[client.sockfd] = try self.context.accept(socket: client.sockfd)
                client.readMethod = { client_socket throws -> Data? in
                    return try self.clientsMap[client_socket.sockfd]?.read(size: 16 * 1024)
                }
                
                client.writeMethod = { client_socket, data throws in
                    _ = try self.clientsMap[client_socket.sockfd]?.write(data: data)
                }
            } catch {
                
            }
        }
    }
}
