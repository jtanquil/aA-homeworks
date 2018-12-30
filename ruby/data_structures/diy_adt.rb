class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack << el
    end

    def pop
        @stack.pop
    end

    def peek
        @stack.last
    end
end

class Queue
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el
    end

    def dequeue
        @queue.shift
    end

    def peek
        @queue.last
    end
end

class Map
    def initialize
        @map = []
    end

    def keys
        @map.map { |ele| ele[0] }
    end

    def set(key, value)
        has_key = self.keys.include?(key)

        unless has_key
            @map << [key, value]
        else
            @map.each_with_index do |ele, idx|
                if ele[0] == key
                    @map[idx][1] = value
                end
            end
        end

        value
    end

    def get(key)
        if self.keys.include?(key)
            @map.each_with_index do |ele, idx|
                if ele[0] == key
                    return @map[idx][1]
                end
            end
        end
    end
    
    def delete(key)
        if self.keys.include?(key)
            @map.each_with_index do |ele, idx|
                if ele[0] == key
                    @map.delete_at(idx)
                    return ele[1]
                end
            end
        end
    end

    def show
        p @map
    end
end