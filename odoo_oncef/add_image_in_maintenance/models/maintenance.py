# -*- coding: utf-8 -*-

from odoo import models, fields, api


class Maintenance(models.Model):
    _inherit = 'maintenance.request'

    image  = fields.Binary(
        string='Image',
        help='Image of the equipment',
        attachment=True,
    )

    show_image = fields.Boolean(
        string='Ajouter une image',
        help='Cochez cette case pour afficher limage dans la vue du formulaire de demande de maintenance',
        default=True,  
        store=True,     
    )

