require_relative '../db/sql_runner.rb'
require_relative '../models/captain.rb'

class Ship

    attr_accessor :model, :class, :arrival_date, :sales_status, :captain_id
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @model = options['model']
        @class = options['class']
        @arrival_date = options['arrival_date']
        @sales_status = options['sales_status']
        @captain_id = options['captain_id'].to_i
    end

    def save()
        sql = "INSERT INTO ships ( model, class, arrival_date, sales_status ) 
               VALUES ( $1, $2, $3, $4 )
               RETURNING id"
        values = [@model, @class, @arrival_date, @sales_status]
        result = SqlRunner.run(sql, values)
        id = result.first['id']
        @id = id
    end

    def captain()
        captain = Captain.find(@captain.id)
        return captain
    end

    def update()
        sql = "UPDATE ships SET ( model, class, arrival_date, sales_status, captain_id ) = 
               ( $1, $2, $3, $4, $5 )
               WHERE id = $6"
    values = [@model, @class, @arrival_date, @repair_status, @captain_id, @id]
    SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM ships WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * FROM ships"
        ship_data = SqlRunner.run(sql)
        ships = map_items(ship_data)
        return ships
    end

    def self.map_items(ship_data)
        return ship_data.map { |ship| Ship.new(ship) }
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