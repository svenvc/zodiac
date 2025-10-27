# Zodiac TLS/SSL

Zodiac is an open-source, cross-smalltalk implementation of regular and secure socket streams. 
The primary goal of the project is to offer TLS/SSL streams that can then be used to implement 
for example HTTPS when combined with a suitable client such as Zinc HTTP Components.

This project is used by the [Zinc HTTP Components](https://github.com/svenvc/zinc) project.

[![CI](https://github.com/svenvc/zodiac/actions/workflows/CI.yml/badge.svg)](https://github.com/svenvc/zodiac/actions/workflows/CI.yml)

## For documentation there is the [TLS/SSL](https://github.com/svenvc/zodiac/blob/master/zodiac-paper.md) paper

## Installation

```
  Metacello new
    repository: 'github://svenvc/zodiac/repository';
    baseline: 'Zodiac';
    load.
```

*Sven Van Caekenberghe*

[MIT Licensed](https://github.com/svenvc/zodiac/blob/master/license.txt)
