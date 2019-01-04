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
            acc + (ele.salary + ele.bonus) * multiplier
        end
    end

    def add_employee(employee)
        self.employees << employee
        employee.boss = self
    end
end