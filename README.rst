======
UnitAS
======
I can't find any well maintained out of the box working unit test framework for AS3.
I tryed compiling "flexunit" and "asunit" with ant, was a major waste of time.
Here you just clone and run "make" in your shell or cygwin for Windows users.

Requirements
============
- **Flex SDK**
- **Flash Debugger**
- **Cygwin** - *for windows user only*


Installation
============
- just clone this repository inside your project in a tests folder (or any other name).

Tips:
~~~~
You might want to disable the flash debugger dialog by adding ``SuppressDebuggerExceptionDialogs=1`` in your mm.cfg.

Commands
========
``make clean``  = remove build

``make``        = make clean, compile flash sources and run test with adl

Note: *When test are runned, output will be in your flashlog.txt file. You can change this behavior easily via inheritance or a simple function allocation*

``make deploy`` = publish master on gh-pages branch

Example
=======

::

  UnitAS.test("Test from space", function(assert:Function):void {

    // Your tests here
    var expected:uint = 1;
    var actual:uint = 1;

    // success example
    assert(expected, actual);
  }


Folder architecture
===================

**src**     = raw sources  

**build**   = compiled source  
