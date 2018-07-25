require_relative '../db/sql_runner.rb'
require_relative '../models/captain.rb'

class Ship

    attr_accessor :ship_name, :model, :class, :arrival_date, :sales_status, :captain_id
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @ship_name = options['ship_name']
        @model = options['model']
        @class = options['class']
        @arrival_date = options['arrival_date']
        @sales_status = options['sales_status']
        @captain_id = options['captain_id'] && options['captain_id'] != "--" ? options['captain_id'].to_i : nil
        p @captain_id 
    end

    def save()
        sql = "INSERT INTO ships ( ship_name, model, class, arrival_date, sales_status, captain_id ) 
               VALUES ( $1, $2, $3, $4, $5, $6 )
               RETURNING id"
        values = [@ship_name, @model, @class, @arrival_date, @sales_status, @captain_id]
        result = SqlRunner.run(sql, values)
        id = result.first['id']
        @id = id
    end

    def self.allWithCaptain()
        sql = "SELECT * from ships
               WHERE captain_id IS NOT null"
        ship_data = SqlRunner.run(sql)
        ships = map_items(ship_data)
        return ships
    end

    def captain()
        captain = Captain.find(@captain_id)
        return captain
    end

    def update()
        sql = "UPDATE ships SET ( ship_name, model, class, arrival_date, sales_status, captain_id ) = 
               ( $1, $2, $3, $4, $5, $6)
               WHERE id = $7"
    values = [@ship_name, @model, @class, @arrival_date, @sales_status, @captain_id, @id]
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

    def self.search(query)
        sql = "SELECT * FROM ships
               WHERE lower(ships.ship_name) LIKE $1 OR lower(ships.model) LIKE $1 OR lower(ships.class) LIKE $1"
        values = ['%'+query.downcase+'%']
        return SqlRunner.run(sql, values)
    end
end