require_relative '../db/sql_runner.rb'
require_relative '../models/ship.rb'

class Captain

    attr_accessor :first_name, :last_name
    attr_reader :id

    def initialize (options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @ship_id = options['ship_id'].to_i
    end

        def save()
            sql = "INSERT INTO captains
            (
                first_name,
                last_name,
                ship_id
            )
            VALUES
            (
                $1, $2, $3
            )
            RETURNING id"
            values = [@first_name, @last_name, @ship_id]
            result = SqlRunner.run(sql, values)
            id = result.first['id']
            @id = id
        end
    
        def ship()
            ship = Ship.find(@ship.id)
            return ship
        end
    
        def update()
            sql = "UPDATE captains
            SET
            (
                first_name,
                last_name,
                ship_id,
            ) =
            (
                $1, $2, $3
            )
            WHERE id = $4"
        values = [@first_name, @last_name, @ship_id, @id]
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
    
        def self.find()
            sql = "SELECT * FROM captains
            WHERE id = $1"
            values = [id]
            result = SqlRunner.run(sql, values).first
            captain = Captain.new(result)
            return captain
        end
    
end