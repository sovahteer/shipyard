require_relative '../db/sql_runner.rb'
require_relative '../models/ship.rb'

class Captain

    attr_accessor :first_name, :last_name
    attr_reader :id

    def initialize (options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
    end
    
    def save()
        sql = "INSERT INTO captains ( first_name, last_name ) VALUES ( $1, $2 )
               RETURNING id"
        values = [@first_name, @last_name]
        result = SqlRunner.run(sql, values)
        id = result.first['id']
        @id = id
    end

    def ship()
        ship = Ship.find(@ship.id)
        return ship
    end

    def update()
        sql = "UPDATE captains SET ( first_name, last_name ) = ( $1, $2 )
               WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM captains
               WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * FROM captains"
        captain_data = SqlRunner.run(sql)
        captains = map_items(captain_data)
        return captains
    end
    def self.map_items(captain_data)
        return captain_data.map { |captain| Captain.new(captain) }
      end

    def self.find(id)
        sql = "SELECT * FROM captains
               WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        captain = Captain.new(result)
        return captain
    end

    def full_name
        return "#{@first_name.capitalize} #{@last_name.capitalize}"
    end
end