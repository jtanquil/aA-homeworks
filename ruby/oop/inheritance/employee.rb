class Employee
    attr_reader :name, :title, :salary
    attr_accessor :boss

    def initialize(name, title, salary, boss = nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end

    def bonus(multiplier)
        self.salary * multiplier
    end
end

class Manager < Employee
    attr_reader :employees

    def initialize(name, title, salary, boss = nil, employees = [])
        super(name, title, salary, boss)
        @employees = employees
    end

    def bonus(multiplier)
        self.employees.reduce(0) do |acc, ele|
            new_total = acc
            
            begin
                new_total += ele.salary * multiplier + ele.bonus(multiplier) if ele.employees
            rescue NoMethodError
                new_total += ele.bonus(multiplier)
            end

            new_total
        end
    end

    def add_employee(employee)
        self.employees << employee
        employee.boss = self
    end
end

ned = Manager.new("Ned", "Founder", 1000000)
darren = Manager.new("Darren", "TA Manager", 78000)
shawna = Employee.new("Shawna", "TA", 12000)
david = Employee.new("David", "TA", 10000)

ned.add_employee(darren)
darren.add_employee(shawna)
darren.add_employee(david)

puts ned.bonus(5).to_s
puts darren.bonus(4).to_s
puts david.bonus(3).to_s