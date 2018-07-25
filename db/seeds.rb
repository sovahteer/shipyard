require_relative '../models/ship'
require_relative '../models/captain'
require_relative '../models/crew'


captain1 = Captain.new({
    'first_name' => 'Han',
    'last_name' => 'Solo'
})
captain2 = Captain.new({
    'first_name' => 'Jensen',
    'last_name' => 'Tythe'
})

captain1.save
captain2.save

ship1 = Ship.new({
    'ship_name' => 'Millenium Falcon',
    'model' => 'YT-1300',
    'class' => 'Light Freighter',
    'arrival_date' => '2018-07-22',
    'sales_status' => 'Requires Repair',
    'captain_id' => captain1.id
})
ship2 = Ship.new ({
    'ship_name' => 'Angel of Ciria',
    'model' => 'HWK-290',
    'class' => 'Courier',
    'arrival_date' => '2018-07-22',
    'sales_status' => 'Sold',
    'captain_id' => captain2.id
})

ship1.save
ship2.save

crew1 = Crew.new ({
    'first_name' => 'Chewbacca',
    'last_name' => nil,
    'role' => 'Co-Pilot',
    'captain_id' => captain1.id,
    'ship_id' => ship1.id
})

crew2 = Crew.new ({
    'first_name' => "Gar'venna",
    'last_name' => nil,
    'role' => 'Emotional Support',
    'captain_id' => captain2.id,
    'ship_id' => ship2.id

})

crew1.save
crew2.save