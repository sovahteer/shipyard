require_relative '../db/sql_runner.rb'
require_relative '../models/captain.rb'

class Ship

    attr_accessor :model, :class, :repair_status
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @model = options['model']
        @class = options['class']
        @sales_status = options['sales_status']
    end

    def save()
        sql = "INSERT INTO ships
        (
            model,
            class,
            sales_status
        )
        VALUES
        (
            $1, $2, $3
        )
        RETURNING id"
        values = [@model, @class, @sales_status]
        result = SqlRunner.run(sql, values)
        id = result.first['id']
        @id = id
    end

    def captain()
        captain = Captain.find(@captain.id)
        return captain
    end

    def update()
        sql = "UPDATE ships
        SET
        (
            model,
            class,
            sales_status,
            captain_id
        ) =
        (
            $1, $2, $3
        )
        WHERE id = $4"
    values = [@model, @class, @sales_status, @id]
    SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM ships
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * FROM ships"
        ships_data = SqlRunner.run(sql)
        ships = map_items(ship_data)
        return ships
    end

    def self.find(id)
        sql = "SELECT * FROM ships
        WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        ship = Ship.new(result)
        return ship
    end

end