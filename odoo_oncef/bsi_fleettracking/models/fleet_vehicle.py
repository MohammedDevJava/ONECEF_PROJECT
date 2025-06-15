from odoo import api, fields, models

class FleetVehicle(models.Model):
    _inherit = 'fleet.vehicle'

    geotab_device = fields.Many2one(string='Geotab Device', comodel_name='bsifleettracking.geotabdevices', required=False)
    lat = fields.Float('Latitude',digits=(16, 7), required=False)
    lon = fields.Float('Longitude',digits=(16, 7), required=False)

