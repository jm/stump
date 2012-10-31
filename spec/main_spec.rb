describe "Application 'stump-test'" do
  class Hello
    def self.yield_hello(&block)
      block.call("hello")
    end

    def self.two_greetings(&block)
      block.call("hello", "hi")
    end
  end

  it "stub on object" do 
    Hello.stub!(:thing, :return => "hey!")
    Hello.should.not.be.nil
    Hello.thing.should == "hey!"

    my_obj = Object.new
    my_obj.stub!(:hello)
    my_obj.hello.should.be.nil
  end

  it "should create pure stub" do 
    my_stub = stub(:thing, :return => "dude, a thing!")
    my_stub.thing.should == "dude, a thing!"
  end

  it "should mock object" do
    my_object = "things are fun"
    my_object.mock!(:fancy, :return => "ooo fancy!")
    my_object.mock!(:tancy, :return => "ooo tancy!")
    my_object.fancy.should == 'ooo fancy!'
    my_object.tancy.should == 'ooo tancy!'
  end

  it "should create pure mock" do 
    my_mock = mock(:hello, :return => "what fun is this?")
    my_mock.hello.should == "what fun is this?"
  end

  it "should be able to yield a single object" do
    Hello.mock!(:yield_hello, yield: "goodbye")

    Hello.yield_hello do |output|
      output.should.be == "goodbye"
    end
  end

  it "should be able to yield multiple objects" do
    Hello.mock!(:two_greetings, yield: ["goodbye", "bye"])

    Hello.two_greetings do |a, b|
      a.should.be == "goodbye"
      b.should.be == "bye"
    end
  end

  # class Greeting
  #   def bonjour
  #     "Bonjour!"
  #   end
  # end

  # it "should use proxy objects" do 
  #   greet_me = Greeting.new
  #   greet_me.proxy!(:bonjour)
  #   greet_me.bonjour  # => "Bonjour!"
  # end

end
