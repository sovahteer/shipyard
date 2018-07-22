require_relative '../models/ship'
require_relative '../models/captain'

ship1 = Ship.new({
    'model' => 'YT-1300',
    'class' => 'LIGHT FREIGHTER',
    'sales_status' => 'FAULTY REVERSE POWER FLUX COUPLING, REQUIRES REPLACEMENT'
})
ship2 = Ship.new ({
    'model' => 'HWK-290',
    'class' => 'COURIER',
    'sales_status' => 'SOLD'
})

ship1.save
ship2.save

captain1 = Captain.new({
    'first_name' => 'Han',
    'last_name' => 'Solo',
    'ship_id' => ship1.id
})
captain2 = Captain.new({
    'first_name' => 'Jensen',
    'last_name' => 'Tythe',
    'ship_id' => ship2.id
})

captain1.save
captain2.save