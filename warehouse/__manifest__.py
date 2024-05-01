{
    'name': "test_module",
    'version': '1.0',
    'depends': ['base'],
    'author': "Niema",
    'category': 'Test',
    'description': """
    This module is a simple test that hide the price from the poduct in inventory module
    """,
    # data files always loaded at installation
    'data': [
        'views/inherit_product_view.xml',
    ],
    # data files containing optionally loaded demonstration data
    'demo': [
        #'demo/demo_data.xml',
    ],
}