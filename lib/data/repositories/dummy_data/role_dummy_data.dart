final List<Map<String, dynamic>> rolesStaticList = [
  {
    "roleName": "cashier",
    "permissions": {
      "branch": false,
      "create_order": true,
      "customer": false,
      "inventory": false,
      "menu": false,
      "order": true,
      "promotion": false,
      "report": true,
      "staff": false,
      "table": false,
    }
  },
  {
    "roleName": "headbranch",
    "permissions": {
      "branch": false,
      "create_order": true,
      "customer": true,
      "inventory": true,
      "menu": true,
      "order": true,
      "promotion": true,
      "report": true,
      "staff": true,
      "table": true,
    }
  },
  {
    "roleName": "master",
    "permissions": {
      "branch": true,
      "create_order": true,
      "customer": true,
      "inventory": true,
      "menu": true,
      "order": true,
      "promotion": true,
      "report": true,
      "staff": true,
      "table": true,
    }
  }
];
