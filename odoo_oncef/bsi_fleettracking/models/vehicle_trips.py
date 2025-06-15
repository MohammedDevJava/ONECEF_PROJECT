from odoo import api, fields, models

class VehicleTrips(models.Model):
    _name = 'bsifleettracking.vehicletrips'
    _description = 'Vehicle Trips'

    name = fields.Char(string='Sequence', default='VT0000000',copy=False,required=True,readonly=True)
    active = fields.Boolean(string='Active',default=True)

    fleet_vehicle_id = fields.Many2one(string='Fleet Vehicle', comodel_name='fleet.vehicle', required=False) 
    device_id = fields.Many2one(string='Geotab Device', comodel_name='bsifleettracking.geotabdevices', required=False)
    idle_duration = fields.Char(string='Idling Duration', required=False)
    engine_hours = fields.Integer(string='Engine Hours',default=1, required=False)
    distance = fields.Float('Distance',digits=(16, 2), required=False)
    driving_duration = fields.Char(string='Driving Duration', required=False)
    max_speed = fields.Integer(string='Max Speed',default=1, required=False)
    stop_point_lat = fields.Float('Stop Point Latitude',digits=(16, 7), required=False)
    stop_point_long = fields.Float('Stop Point Longitude',digits=(16, 7), required=False)
    stop_duration = fields.Char(string='Stop Duration', required=False)
    start_datetime = fields.Date('Start Date/Time', required=False)
    stop_datetime = fields.Date('Stop Date/Time', required=False)
  
    @api.model_create_multi
    def create(self,vals_list):
    	for vals in vals_list:
    		if vals.get('name', ('VT0000000'))==('VT0000000'):
    			vals['name'] = self.env['ir.sequence'].next_by_code('bsifleettrack.vehicletrips.number')
    	return super().create(vals)    

