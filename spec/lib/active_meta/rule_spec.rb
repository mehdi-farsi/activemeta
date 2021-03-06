require 'spec_helper'

describe ActiveMeta::Rule do
  it { should have_attr_accessor :attribute }
  it { should have_attr_accessor :rule_name }
  it { should have_attr_accessor :arguments }
  it { should have_attr_accessor :parent }

  it { should alias_its_method :name, :rule_name }
  it { should alias_its_method :args, :arguments }

  context 'instance methods' do
    context '#initialize' do
      it 'should raise an ArgumentError if passed attribute is invalid' do
        ->{ subject.new('Foo', 't') }.should raise_error ArgumentError
      end

      it 'should raise an ArgumentError if passed attribute is invalid' do
        ->{ subject.new('t', 'Foo') }.should raise_error ArgumentError
      end

      it 'should store `attribute` as @attribute' do
        subject.new('test_attribute', 't').attribute.should == 'test_attribute'
      end

      it 'should store `rule_name` as @rule_name' do
        subject.new('t', 'test_rule_name').rule_name.should == 'test_rule_name'
      end

      it 'should store `*arguments` or [] as @arguments' do
        subject.new('t', 't', :foo, :bar).arguments.should == %i(foo bar)
        subject.new('t', 't').arguments.should == []
      end
    end

    context '#opts' do
      it 'should retrieve the last element of @arguments if a hash' do
        subject.new('t', 't', :foo, foo: :bar).opts.should == { foo: :bar }
      end

      it 'should return empty hash if last elements of @arguments not hash' do
        subject.new('t', 't', :foo, :bar).opts.should == {}
        subject.new('t', 't').opts.should == {}
      end
    end
  end
end
