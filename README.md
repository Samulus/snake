# Snake
This is a multiplayer Haxe/Flash implementation of Snake for a coding challenge.

The game supports:

* Configurable playing field size
* Multiple control scheme support
* Support for as many snake players as you want
* Support for a basic AI

The game will support in the future:

* Replay system (by extending the ``InputDevice.hx`` interface)


# Running
0. Edit ``Settings.hx`` to your liking (add extra players etc.)
1. Run ``haxe compile.hxml``
2. Open ``Snake.html`` in your browser

# Notes
When changing the resolution make sure that it matches in the following files:
* ``Snake.html``
* ``compile.hxml``
* ``Settings.hx``