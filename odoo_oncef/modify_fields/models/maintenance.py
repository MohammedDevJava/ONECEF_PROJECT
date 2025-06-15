# -*- coding: utf-8 -*-
from odoo import models, fields, api

class MaintenanceRequest(models.Model):
    _inherit = 'maintenance.request'

    # Override email_cc field to make it computed
    email_cc = fields.Char(
        string='Email CC',
        compute='_compute_email_cc',
        store=True,
        readonly=True
    )

    @api.depends('create_date')
    def _compute_email_cc(self):
        admin_user = self.env.ref('base.user_admin')
        for record in self:
            record.email_cc = admin_user.login if admin_user else False
            

