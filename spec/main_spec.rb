describe "Application 'stump-test'" do

  # Test class for mocking.
  class Dog
    def self.create
      return Dog.new
    end

    def bark
      "Woof!"
    end

    def eat(food)
      "#{food}! Yum!"
    end

    # Calls the given block on the nearest toy, a stuffed mouse.
    def get_toy(&block)
      block.call("stuffed mouse")
    end

    # Calls the given block on true (for a succesful fetch) and 2 (the time it
    # took to fetch.
    def fetch(&block)
      block.call(true, 20)
    end
  end

  before do
    @dog = Dog.new
  end

  describe "#stub!" do
    it "should stub a class method" do 
      Dog.stub!(:thing, return: :thing)
      Dog.should.not.be.nil
      Dog.thing.should == :thing
    end

    it "should stub an instance method" do
      my_obj = Object.new
      my_obj.stub!(:hello, return: "hi")
      my_obj.hello.should.be == "hi"
    end

    it "should stub using block" do
      my_obj = Object.new
      my_obj.stub!(:hello) do |a, b|
        a.should == "foo"
        b.should == "bar"
        "#{a},#{b}"
      end
      my_obj.hello("foo", "bar").should.be == "foo,bar"
    end
  end
  
  describe "#stub" do
    it "should create a pure stub" do
      my_stub = stub(:thing, return: "dude, a thing!")
      my_stub.thing.should == "dude, a thing!"
    end

    it "should create a stub using block" do
      my_stub = stub(:thing) do |a, b|
        a.should == "a"
        b.should == "thing!"
        "dude, #{a} #{b}"
      end
      my_stub.thing("a", "thing!").should == "dude, a thing!"
    end
  end

  describe "#mock!" do
    it "should mock an instance method on an object" do
      @dog.mock!(:bark, return: "Meow!")
      @dog.mock!(:eat, return: "Yuck!")
      @dog.bark.should == "Meow!"
      @dog.eat("broccoli").should == "Yuck!"
    end

    it "should mock using block" do
      @dog.mock!(:bark) do |a|
        a.should == "Meow!"
        a
      end
      @dog.bark("Meow!").should == "Meow!"
    end

    it "should mock a class method" do
      Dog.mock!(:create, return: "Dog")
      Dog.create.should == "Dog"
    end

    it "should be able to yield a single object" do
      @dog.mock!(:get_toy, yield: "stuffed fox")
      @dog.get_toy do |toy|
        toy.should.be == "stuffed fox"
      end
    end

    it "should be able to yield multiple objects" do
      @dog.mock!(:fetch, yield: [false, 10])
      @dog.fetch do |success, time|
        success.should.be == success
        time.should.be == 10
      end
    end
  end

  describe "#mock" do
    it "should create pure mock" do 
      my_mock = mock(:hello, return: "hi")
      my_mock.hello.should == "hi"
    end
  end

  describe "#should_not_call" do
    it "should raise an error with an instance method" do
      @dog.should_not_call(:bark)
      should.raise(Bacon::Error) do
        @dog.bark
      end
    end

    it "should succeed if the call is not made" do
      should.not.raise(Bacon::Error) do
        @dog.should_not_call(:bark)
      end
    end

    it "should not fail in another test" do
      should.not.raise(Bacon::Error) do
        @dog.bark
      end
    end

    it "should raise an error with a class method" do
      Dog.should_not_call(:create)
      should.raise(Bacon::Error) do
        Dog.create
      end
    end
  end
end
