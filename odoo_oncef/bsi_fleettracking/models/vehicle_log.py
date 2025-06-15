from odoo import api, fields, models

class VehicleLog(models.Model):
    _name = 'bsifleettracking.vehiclelog'
    _description = 'Vehicle Log'
    _rec_name = "name"

    name = fields.Char(string='Sequence', default='VL0000000',copy=False,required=True,readonly=True)
    active = fields.Boolean(string='Active',default=True)

    fleet_vehicle_id = fields.Many2one(string='Fleet Vehicle', comodel_name='fleet.vehicle', required=False) 
    device_id = fields.Many2one(string='Geotab Device', comodel_name='bsifleettracking.geotabdevices', required=False)
    lat = fields.Float('Latitude',digits=(16, 7), required=False)
    lon = fields.Float('Longitude',digits=(16, 7), required=False)
    speed = fields.Integer(string='Speed',default=1, required=False)
    log_datetime = fields.Date('Date/Time', required=False)
    log_id = fields.Char(string='Log  ID', required=True)

    @api.model_create_multi
    def create(self,vals_list):
    	for vals in vals_list:
    		if vals.get('name', ('VL0000000'))==('VL0000000'):
    			vals['name'] = self.env['ir.sequence'].next_by_code('bsifleettrack.vehiclelog.number')
    	return super().create(vals)    

