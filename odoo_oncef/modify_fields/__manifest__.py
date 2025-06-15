# -*- coding: utf-8 -*-
{
    'name': "Maintenance Fields Optimizer",

    'summary': "Customize and optimize maintenance module fields visibility and types",

    'description': """
This module extends the maintenance module functionality by:
- Modifying field types and attributes
- Hiding unnecessary fields
- Optimizing the maintenance request form view
    """,

    'author': "Your Company",
    'website': "https://www.yourcompany.com",

    'category': 'Maintenance',
    'version': '1.0',

    'depends': ['base', 'maintenance','fleet', 'mail' , 'web' ],

    'data': [
        'views/maintenance.xml',
        'views/view_chauffeur.xml',
    ],
    'installable': True,
    'application': False,
    'auto_install': False,
}

