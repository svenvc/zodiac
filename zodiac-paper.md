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
Note that Zodiac not only requires Smalltalk code but a VM plugin as well.


## An introduction to TLS/SSL


## HTTPS client


## Secure POP client


## Secure SMTP client


## HTTPS server


## Zodiac socket streams and IO buffers


## Zodiac secure socket streams and SSL sessions


