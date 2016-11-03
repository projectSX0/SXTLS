# SXTLS

SXTLS is an optional TLS module that can add a TLS layer to any spartanX stream socket service.

# Build

SXTLS is using swiftTLS to handle TLS functionality, which requires libressl installed on your machine. Details on how to set up [swiftTLS](https://github.com/projectSX0/swiftTLS), please see the [readme file]( https://github.com/projectSX0/swiftTLS/blob/master/README.md)

# Usage

For this example we are making the HTTPService from [SXF97](https://github.com/projectSX0/SXF97) to https service (http over tls)

```Swift
var https: SXTLSLayer!
var tlsContext: SXTLSContext!
let service = HTTPService { (request, ip) -> HTTPResponse? in
        return HTTPResponse(status: 200, text: "Hello World")
    }

do {    
    tlsContext = try SXTLSContext(cert: "/path/to/your/.crt", cert_passwd: nil, key: "/path/to/your/.key", key_passwd: nil)
} catch {
    // something wrong with the tls context 
}

https = SXTLSLayer(service: service, context: tlsContext)
```

After that, you can start the service just like any [spartanX](https://github.com/projectSX0/spartanX) services.
