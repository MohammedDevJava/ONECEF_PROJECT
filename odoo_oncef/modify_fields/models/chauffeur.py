# -*- coding: utf-8 -*-
from odoo import models, fields, api

class Chauffeur(models.Model):
    _inherit = 'res.partner'
    
    fleet = fields.Many2one(
        'fleet.vehicle',
        string="Fleet Vehicle",
        compute='_compute_fleet',
        inverse='_inverse_fleet',
        store=True,
    )
    
    def _compute_fleet(self):
        for partner in self:
            vehicle = self.env['fleet.vehicle'].search([('driver_id', '=', partner.id)], limit=1)
            partner.fleet = vehicle.id if vehicle else False

    def _inverse_fleet(self):
        for partner in self:
            # Remove this partner from any other vehicles where they might be the driver
            self.env['fleet.vehicle'].search([
                ('driver_id', '=', partner.id),
                ('id', '!=', partner.fleet.id if partner.fleet else False)
            ]).write({'driver_id': False})
            
            # Set this partner as driver of the selected vehicle
            if partner.fleet:
                partner.fleet.driver_id = partner.id