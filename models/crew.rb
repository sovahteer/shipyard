require_relative '../db/sql_runner.rb'
require_relative '../models/ship.rb'
require_relative '../models/captain.rb'

class Crew

    attr_accessor :first_name, :last_name, :role, :captain_id, :ship_id
    attr_reader :id

    def initialize (options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @last_name = options['last_name']
        @role = options['role']
        @captain_id = options['captain_id'] && options['captain_id'] != "--" ? options['captain_id'].to_i : nil
        @ship_id = options ['ship_id'] && options['ship_id'] != "--" ? options ['ship_id'].to_i : nil
    end

    def save()
        sql = "INSERT INTO crews ( first_name, last_name, role, captain_id, ship_id ) 
               VALUES ( $1, $2, $3, $4, $5 )
               RETURNING id"
        values = [@first_name, @last_name, @role, @captain_id, @ship_id]
        result = SqlRunner.run(sql, values)
        id = result.first['id']
        @id = id
    end

    def captain()
        captain = Captain.find(@captain.id)
        return captain
    end

    def ship()
        ship = Ship.find(@captain.id)
        return ship
    end

    def update()
        sql = "UPDATE crews SET ( first_name, last_name, role, captain_id, @ship_id ) = 
               ( $1, $2, $3, $4, $5)
               WHERE id = $6"
    values = [@model, @class, @arrival_date, @sales_status, @captain_id, @id]
    SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM crews WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * FROM crews"
        crew_data = SqlRunner.run(sql)
        crew = map_items(crew_data)
        return crew
    end

    def self.map_items(crew_data)
        return crew_data.map { |crew| Crew.new(crew) }
      end

    def self.find(id)
        sql = "SELECT * FROM crews
               WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values).first
        crew = Crew.new(result)
        return crew
    end

    def full_name
        return "#{@first_name.capitalize} #{@last_name.capitalize}"
    end

    def self.search(query)
        sql = "SELECT * FROM crews
               WHERE lower(first_name || ' ' || last_name) LIKE $1 or lower(crews.first_name) LIKE $1 or lower(crews.last_name) or lower(crews.role) LIKE $1"
        values = ['%'+query.downcase+'%']
        return SqlRunner.run(sql, values)
    end
end