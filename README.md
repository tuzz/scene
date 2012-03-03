## Introduction

Super Simple Scene is a gem that attempts to make things as easy as possible to get started with OpenGL. It handles all of the messy window setup and provides sensible defaults for various things. Under the hood it uses the GLUT windowing system, which is well-known and widely documented. It has been tested in Ruby 1.8.7+ on Mac OSX Snow Leopard and Windows 7 x64.

<img src='http://i44.tinypic.com/veyp3.png' width="400" height="400" />

## Getting Started

**Install the gem:**

```ruby
gem install scene
```

**Require it in your project:**

```ruby
require 'scene'
```

You may need to require 'rubygems' too, if you are running an old version of Ruby.

**Windows users:**

You'll need the glut dll, which you can download [here](http://dl.dropbox.com/u/5490406/github/glut32.dll). Copy that into your Windows > SysWOW64 folder, or System32 if you don't have that.

**Running the default scene:**

```ruby
Scene.display
```

Press H to display help in the terminal.

**Creating your own scene:**

```ruby
class MyScene < Scene
  
  def initialize
  end
  
  def display
  end
  
  def timer(elapsed)
  end
  
  def keyboard(key, x, y)
  end
  
  def mouse(button, state, x, y)
  end
  
  def reshape(width, height)
  end
  
end

MyScene.display
```

There is no need to instantiate the class, simply call display and Scene will handle everything for you.

## Initialize

Place any code that you wish to run before the first frame is displayed in the initializer. This can include overrides for the default window, or camera settings, e.g.

```ruby
def initialize
  glutReshapeWindow(1000, 1000)  # Set the window size to 1000x1000 instead of 800x800
  glClearColor(1, 1, 1, 1)       # Set the window background to white instead of black
end
```

## Display

The display method will be called every 10 milliseconds, or thereabouts- depending on your machine. There is no need to clear or swap buffers, Scene will handle that for you. The following will draw a red square:

```ruby
def display
  glColor3f(1, 0, 0)
  glBegin(GL_POLYGON)
    glVertex3f(-1, -1, 0)
    glVertex3f(-1, 1, 0)
    glVertex3f(1, 1, 0)
    glVertex3f(1, -1, 0)
  glEnd
end
```

The camera is positioned at 0, 0, -4 and is focussed on the origin by default. Feel free to change this in your initializer.

## Timer

The timer method is called after each frame is drawn. This is a good place to control animations, for example, you could rotate by x many degrees every time this method is called. Is is given the elapsed time since the previous timer method was called. This allows for building time-accurate animations. It is also a good indication of whether or not your machine is struggling to display the animation if it strays too far from 10ms.

```ruby
def timer(elapsed)
  glRotatef(elapsed * 60, 1, 0, 0) # Rotate in the x-axis at a rate of 60 degrees per second
end
```

## Keyboard

The keyboard method is used for responding to keyboard events. It is given the character string and the mouse's x- and y-coordinates at the time of the key-press.

```ruby
def keyboard(key, x, y)
  puts "You pressed #{key} when the mouse was at: #{x}, #{y}"
  exit(0) if key == 'q'
end
```

## Mouse

The mouse method takes a button, state and coordinates. It may be more semantic to use the constant's provided by GLUT, e.g. GLUT_LEFT_BUTTON and GLUT_DOWN.

```ruby
def mouse(button, state, x, y)
  puts "Button: #{button}, State: #{state}, Coordinates: #{x}, #{y}"
end
```

## Reshape

The reshape method allows you to specify what happens when the window is resized. Usually you will want to resize the viewport:

```ruby
def reshape(width, height)
  min = [width, height].min
  x = (width - min) / 2
  y = (height - min) / 2
  glViewport(x, y, min, min)
end
```

## Contribution

Please feel free to contribute, either through pull requests or feature requests here on Github.

I'm thinking of including several default scenes in the gem. If you have something cool, let me know and it might get included!

For news and latest updates, follow me on Twitter ([@cpatuzzo](https://twitter.com/#!/cpatuzzo)).