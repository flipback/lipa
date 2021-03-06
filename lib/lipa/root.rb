=begin
Lipa - DSL for description treelike structures in Ruby

Copyright (c) 2011 Aleksey Timin

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
=end

module Lipa 
  # Implementaion of root of description
  # @example
  #
  #   tree = Lipa::Root.new :tree do 
  #     node :object do
  #       param_1 "some_param"
  #       param_2 run{param_1 + "!!!!"}
  #     end
  #   end
  #
  #   tree.object.param_1 #=> "some_param"
  #   tree.object.param_2 #=> "some_param!!!!"
  class Root < Node
    attr_reader :kinds
    @@trees = {}
    def initialize(name, &block)
      @kinds = {}
      @root = self
      @children = {}
      @attrs = {}
      @name = "/"
      @full_name = "/"

      instance_eval &block if block_given?

      @@trees.merge! name.to_s => self
    end

    # Initialize of kind
    # @see Lipa::Kind
    #
    # @example
    #   kind :some_kind do
    #     param1 "some_param"
    #   end
    #
    #   some_kind :some_instance 
    def kind(name, attrs = {}, &block)
      @kinds[name.to_sym] = Lipa::Kind.new(name, attrs, &block)
    end

    alias_method :template, :kind

    # Accessor for node by uri
    #  
    # @param [String] uri by format [tree_name]://[path]
    # @return [Node] node
    #
    # @example
    #  Lipa::Root["some_tree://node_1/node_2"] 
    def self.[](uri)
      tree, path = uri.split("://")
      @@trees[tree][path] if @@trees[tree] 
    end

    # Load description tree from file
    #
    # @param path to file
    #
    # @example 
    #   root "lipa" do
    #     load_from File.dirname(__FILE__) + "/data/part_of_tree.rb"
    #   end
    def load_from(path)
      File.open(path,'r') do |f|
        instance_eval f.read
      end
    end
  end
end
