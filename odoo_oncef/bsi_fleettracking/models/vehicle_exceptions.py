from odoo import api, fields, models

class VehicleExceptions(models.Model):
    _name = 'bsifleettracking.vehicleexceptions'
    _description = 'Vehicle Exceptions'
    _rec_name = "name"

    name = fields.Char(string='Sequence', default='VE0000000',copy=False,required=True,readonly=True)
    active = fields.Boolean(string='Active',default=True)

    fleet_vehicle_id = fields.Many2one(string='Fleet Vehicle', comodel_name='fleet.vehicle', required=False) 
    device_id = fields.Many2one(string='Geotab Device', comodel_name='bsifleettracking.geotabdevices', required=False)
    active_from = fields.Date('Active From Date/Time', required=False)
    active_to = fields.Date('Active To Date/Time', required=False)
    distance = fields.Float('Distance',digits=(16, 1), required=False)
    excep_state = fields.Char(string='Exception State Code', required=True)
    excep_id = fields.Char(string='Exception ID', required=True)

    @api.model_create_multi
    def create(self,vals_list):
    	for vals in vals_list:
    		if vals.get('name', ('VE0000000'))==('VE0000000'):
    			vals['name'] = self.env['ir.sequence'].next_by_code('bsifleettrack.vehicleexceptions.number')
    	return super().create(vals)    

