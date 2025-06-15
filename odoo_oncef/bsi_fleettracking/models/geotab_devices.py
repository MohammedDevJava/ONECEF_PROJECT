from odoo import api, fields, models

class GeotabDevices(models.Model):
    _name = 'bsifleettracking.geotabdevices'
    _description = 'Geotab Devices'

    name = fields.Char(string='Sequence', default='GD00000',copy=False,required=True,readonly=True)
    active = fields.Boolean(string='Active',default=True)

    device_id = fields.Char(string='Geotab Device ID', required=True)
    device_name = fields.Char(string='Geotab Device Name', required=True)

    @api.model_create_multi
    def create(self,vals_list):
    	for vals in vals_list:
    		if vals.get('name', ('GD00000'))==('GD00000'):
    			vals['name'] = self.env['ir.sequence'].next_by_code('geotabdevice.number')
    	return super().create(vals)    
