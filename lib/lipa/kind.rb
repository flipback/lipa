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
  # Implemenation of kind(template) for description
  #
  # @example
  #   tree = root :tree do 
  #     kind :some_kind do
  #       param1 "some_param"
  #     end
  #
  #     some_kind :some_instance 
  #   end
  #   tree["some_instance"].param_1 #=> "some_param"
  #
  # @see Tree#kind
  class Kind
    attr_reader :attrs, :name, :for, :block
    def initialize(name, attrs = {}, &block)
      @for =  attrs.delete(:for)
      @for ||= :node

      @attrs = attrs
      @name = name.to_sym
      @block = block if block_given?
    end
  end
end

