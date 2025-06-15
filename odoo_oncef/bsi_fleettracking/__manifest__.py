# -*- coding: utf-8 -*-
{
    'name': 'BSI Fleet Tracking mohammed',
    'version': '1.2409.2',
    'category': 'Tools',
    'description': u"""
BSI Fleet Tracking
""",
    'author': 'BUSINESS SYSTEMS INTEGRATORS, INC.',
    'price': 0.00,
    'currency': 'USD',
    'support': 'support@businesssysinteg.com',
    'depends': [
        'fleet',
    ],
    'data': [
        'data/data.xml', 
        'data/geotab_devices_data.xml',
        'data/vehicle_exceptions_data.xml',
        'data/vehicle_log_data.xml',
        'data/vehicle_trips_data.xml',
        'security/bsifleettrack_groups.xml',
        'security/bsifleettrack_security.xml',
        'security/ir.model.access.csv',
        'views/fleet_vehicle_views_inherit.xml',
    ],
    'demo': [
    ],
    'images': [
        'images/ConnectingYourWorld.png',
    ],
    'application': True,
    'license': 'OPL-1',
}
