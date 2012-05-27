# TLS/SSL

*Sven Van Caekenberghe*

*May 2012*

*(This is a draft for inclusion as a chapter in the 'Pharo By Example 2' book.)*


## Introduction


Pharo provides the basic building blocks for networking: Sockets, SocketStreams and the NetNameResolver.
With these, UDP and TCP connections can be setup up and used for communication.
A large percentage of internet and intranet traffic flows over these connections.

There are however several problems. 
It is technically possible for anyone along the network path between 
two communicating parties to intercept the traffic and read along. 
For a client it is also hard to be sure that a server is who he claims to be,
and vice versa.

So solve these problems for TCP socket streams, Transport Layer Security (TLS),
previously called Secure Socket Layer (SSL) was introduced.
A starting point for more information is this Wikipedia article: 
[TLS/SSL](http://en.wikipedia.org/wiki/TLS/SSL).

Basically, SecureSocketStream replaces plain SocketStream in a mostly transparent way.
Anything building on top of SocketStreams can potentially use SecureSocketStream to 
protect its communication, while keeping almost the same protocol on top of the stream.

For example, HTTP uses plain socket streams. HTTPS uses secure socket streams.
For Zinc HTTP Components, there is almost no difference. 


## Zodiac


The component implementing TLS/SSL in Pharo Smalltalk is called 
[Zodiac](http://zdc.stfx.eu), or Zdc abbreviated, after its namespace prefix.
The reference Zdc implementation lives in several places:

- <http://www.squeaksource.com/Zodiac>
- <http://mc.stfx.eu/Zodiac>
- <https://www.github.com/svenvc/zodiac>

Installation instructions can be found there.
Note that Zodiac not only requires Smalltalk code but a VM plugin as well,
some VMs include the plugin by default.


## An introduction to TLS/SSL


A TLS/SSL communication starts with a handshake with the client taking the initiative, 
called a login, and the server responding, called an accept.
During the handshake parameters are exchanged and agreed upon for further use. 
Next, asymmetric public/private key cryptography is used to set up a session key. 
The session key will then be used with symmetric encryption for privacy.
Additionally, message authentication codes are used for message integrity.

To allow for both parties to verify each others identity a system of certificates
with a chains of trust is used. Currently, Zodiac's support for certificates is limited.


## HTTPS client


When using any part of Zinc HTTP Components, using HTTPS instead of HTTP is transparent.
Just specify the other scheme and it should work as expected.

    ZnClient new
      systemPolicy;
      beOneShot;
      https;
      host: 'encrypted.google.com';
      addPath: 'search';
      queryAt: 'q' put: 'Smalltalk';
      get.

    ZnEasy get: 'https://www.google.com'.

The key method dynamically deciding which socket stream to use is 
ZnNetworkingUtils>>#socketStreamToUrlDirectly: which requires Zodiac to be installed properly, of course.
As you can see there, the required #connect TLS/SSL step is executed when necessary.


## Secure POP client


In the Zodiac-Extra package you can find the ZdcSecurePOP3Client subclass of the regular POP3Client.
This means that you can check your POP based email account from Pharo over a secure channel.

    ZdcSecurePOP3Client
       retrieveMessagesFromGMailAccount: '<your-name>@gmail.com'
       password: '<your-password>'
       limit: 5.

Evaluating the above expression, with your credentials, will retrieve up to 5 message from your Gmail account
(provided you have enabled POP access).


## Secure SMTP client


In the Zodiac-Extra package you can find the ZdcSecureSMTPClient subclass of the regular SMTPClient.
Again, this means you can now send SMTP based email from Pharo over a secure channel.

    | mailMessage |
    mailMessage := MailMessage empty.
    mailMessage setField: 'subject' toString: 'ZdcSecureSMTPClient Test'.
    mailMessage body: (MIMEDocument 
                         contentType: 'text/plain' 
                         content: 'This is test from Pharo Smalltalk').
    ZdcSecureSMTPClient
       sendUsingGMailAccount: '<your-name>@gmail.com' 
       password: '<your-password>'
       to: '<email-address>' 
       message: mailMessage

First we construct a mailMessage object with some content.
Next, we send the message to a recipient using SMTP.
Here we are using the SMTP capability offer to holders of Gmail accounts (provided this is enabled).

ZdcSecureSMTPClient can connect directly to a secure SMTP server,
or can use the STARTTLS command on a regular SMTP connection to dynamically switch to a secure channel.


## HTTPS server


In the Zinc-Zodiac package you can find the ZnSecureServer subclass of ZnMultithreadedServer.
An HTTPS needs a server certificate to operate.
You can make your own, a so called self-signed developer certificate
- [here is the summary of one article explaining how to do this](http://www.eclectica.ca/howto/ssl-cert-howto.php#summy) -
or you can get a real certificate from a certificate provider.

    (ZnSecureServer on: 1443)
       certificate: '/home/sven/ssl/key-cert.pem';
       logToTranscript;
       start;
       yourself.

Provided key-cert.pem contains a compatible server certificate,
you now have an HTTPS server running !

Working with HTTPS streams is slower than working with regular HTTP.
In production environments it is advisable to put a well-know HTTP Server like Apache
as a reverse proxy in front of your Pharo Smalltalk based HTTP server.
This is true for pure HTTP, but even more so for HTTPS.


## Zodiac socket streams and IO buffers


The Zodiac source code starts with a complete re-implementation of binary socket streams.
A socket is just a network terminal that you can write data to or read data from.
A socket stream makes it a lot easier to deal with a network communication channel.

The key problem and the key selling point of a socket stream is that it adds buffer management.
You should be able to write a couple of characters alternated by a couple of strings,
and every so often, either automatically or manually, have everything that was buffered be send over the network.
Likewise, whether you read character by character, or in larger chunks, what comes in from the over the network
might be a larger buffer, or might require multiple buffers.

Zodiac delegates the buffer management to helper class called ZdcIOBuffer.
This buffer allows data to come from one side and be read from the other side,
using a static buffer and moving data around as efficiently as possible.

Zodiac offers a basic hierarchy of socket streams.

    ZdcAbstractSocketStream
       + ZdcSimpleSocketStream
            + ZdcOptimizedSocketStream
                 + ZdcSocketStream

ZdcAbstractSocketStream implements the whole binary stream read and write protocol
in terms of internal IO buffers, working on an opaque socket like object.
The following key methods are subclass responsibilities:

- fillReadBuffer
- flushWriteBuffer
- atEnd
- isConnected

All the known read and write streaming methods have naive implementations
in terms of the core #next and #nextPut: methods which fall back to the methods in the list above.
ZdcSimpleSocketStream is the simplest possible implementation of these requirements,
using the socket access API primitives defined in ZdcAbstractSocketStream.

ZdcOptimizedSocketStream re-implements the performance critical bulk IO operations 
directly on the buffers instead of falling back to the slow #next and #nextPut: methods.
More specifically, the key methods #next:putAll:startingAt: and #readInto:startingAt:count: are overwritten.  

Finally, ZdcSocketStream further optimizes its parent by bypassing the read and write buffers
themselves, when that makes sense. If the buffer is 1Kb and 10Kb should be written, it does not make
sense to even copy the data to the write buffer and then flush it: it is possible to 
give it to the socket directly, in chunks, read from the client's buffer. 
Likewise, when 10Kb should be read directy into a client's buffer,
it does not make sense to copy it from, for example, the socket 1Kb buffer at a time and then move into the client's buffer:
it is possible to get it from the socket directly into the client's buffer, in chunks.

The net result is an alternative binary socket stream implementation that has a much clearer internal implementation,
while being efficient in time and space.
Using an alternative NetworkingUtils factory, Zinc HTTP Components works transparently with
this plain ZdcSocketStream and pass all its tests. 


## Zodiac secure socket streams and SSL sessions


Zodiac uses the general socket stream framework described in the previous subsection and
adds ZdcSecureSocketStream as a subclass of ZdcOptimizedSocketStream.

Actual connection setup, encryption and decryption are delegated to a ZdcAbstractSSLSession object. 
There is currently only one implementation of the ZdcAbstractSSLSession protocol: ZdcPluginSSLSession.
The ZdcPluginSSLSession implementation uses a VM plugin that interfaces with a native library of your OS
to do all the heavy lifting of TLS/SSL: the handshake and the encryption/decryption in blocks.

This is where the buffer management and the stream framework of Zdc fit together to realize 
a true secure socket stream: ZdcSecureSocketStream.
Now, ZdcSecureSocketStream is a bit more complex internally because it manages four buffers:

- a readBuffer for unencrypted incoming data for the stream framework
- a writeBuffer for unencryted outgoiing data for the stream framework
- an in buffer for read encrypted raw data from the socket to pass to the SSLSession for decryption
- an out buffer for holding outgoing encrypted raw data to the socket produced by the SSLSession during encryption

Additionally, ZdcSecureSocketStream adds two methods: #connect to be used by a client connecting to an TLS/SSL server
and #accept to be used by a server accepting an incoming TLS/SSL client.
Of course, the sslSession can be accessed to query it for specific information.
