# motion-stump

Stubbing and mocking for RubyMotion. Based on Jeremy McAnally's [stump](https://github.com/jm/stump) library.

## Features

### Stubbing right on the object

```ruby
# Returns 'hey!'
MyClass.stub!(:thing, :return => "hey!")
# Returns nil
your_object.stub!(:hello)
```

### Pure stub objects
```ruby
my_stub = stub(:thing, :return => "dude, a thing!")
my_stub.thing   # => "dude, a thing!"
```

### Mocking right on the object

```ruby
my_object = "things are fun"
my_object.mock!(:fancy, :return => "ooo fancy!")
my_object.fancy # => "ooo fancy!"
my_object.mock!(:tancy, :return => "ooo fancy!")

# if my_object.tancy is not called, it will fail the spec
```

### Pure mock objects
```ruby
my_mock = mock(:hello, :return => "what fun is this?")
my_mock.hello   # => "what fun is this?"
```


## Installation

```ruby
gem install 'motion-stump'
```

### Usage

Add following lines in your motion Rakefile

```ruby
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'rubygems'
require 'motion-stump'

Motion::Project::App.setup do |app|
  app.name = 'motion-stump'
end
```

## License

(The MIT License)

Copyright © 2012 Francis Chong

Copyright © 2008 Jeremy McAnally

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.