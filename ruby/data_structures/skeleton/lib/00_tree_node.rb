class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        # remove self from the list of the old parent's children
        # then add self to the list of the new parent's children
        @parent.children.delete(self) if @parent
        node.children << self if node

        @parent = node
    end

    # setting the parent already modifies the children array correctly
    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Not a child node!" unless @children.include?(child_node)
        
        child_node.parent = nil
    end

    # override inspect for test readability
    def inspect
        @value.inspect
    end

    # dfs description:
    # if the node has the right value, return it
    # otherwise, do dfs on each child node; once you find the value, return that node
    # otherwise, return nil
    def dfs(target_value)
        return self if self.value == target_value

        self.children.each do |child|
            result = child.dfs(target_value)
            return result if result
        end

        nil
    end

    # bfs description:
    # check self; if it has the value, return it
    # otherwise, remove self from the queue and push its children onto it
    # then check each child in FIFO order
    def bfs(target_value)
        queue = [self]

        until queue.empty?
            head = queue.shift
            return head if head.value == target_value

            head.children.each { |child| queue << child }
        end
    end
end