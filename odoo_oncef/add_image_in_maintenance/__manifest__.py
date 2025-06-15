# -*- coding: utf-8 -*-
{
    'name': "Add Image to Maintenance",
    'summary': "Adds an image field to the maintenance module.",
    'description': """
    This module extends the Maintenance app by adding an image field to maintenance requests or equipment.
    """,
    'author': "Mohammed rahmoun",
    'category': 'Maintenance',
    'version': '18.0.1.0.0',
    'depends': ['maintenance'],
    'data': [
        'views/maintenance_request_view_inherit.xml',
    ]
}

