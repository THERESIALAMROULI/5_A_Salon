class Person{
  final String name;
  final String phone;
  final String picture;
  const Person(this.name, this.phone, this.picture);
}

final List<Person> people=
      _people.map((e) => Person(e['name'] as String,e['phone'] as String,e['picture'] as String)).toList(growable: false);

final List<Map<String,Object>> _people =
  [
  {
    "_id": "66fc098fa8e25a7d2dd81e9b",
    "index": 0,
    "guid": "4358901b-0bfc-414a-96e7-d8efe624cfb5",
    "isActive": true,
    "balance": "\$1,924.09",
    "picture": "http://placehold.it/32x32",
    "age": 22,
    "eyeColor": "green",
    "name": "Henderson Alford",
    "gender": "male",
    "company": "MITROC",
    "email": "hendersonalford@mitroc.com",
    "phone": "+1 (915) 511-3229",
    "address": "776 Hinsdale Street, Conway, Idaho, 2732",
    "about": "Nulla anim adipisicing dolor qui aute id in deserunt ullamco voluptate cupidatat ad. Adipisicing irure cupidatat esse ullamco quis laborum velit excepteur. Minim cupidatat nostrud ex eu est sunt do reprehenderit tempor Lorem reprehenderit magna incididunt. Consectetur voluptate exercitation cupidatat deserunt ipsum consectetur laboris dolore sunt deserunt. Aliqua proident in amet nisi. Eiusmod est non sint ipsum Lorem cupidatat ipsum esse aliquip nisi et. Qui sunt proident aute ipsum et non dolor pariatur consequat deserunt labore laborum.\r\n",
    "registered": "2017-07-20T06:15:45 -07:00",
    "latitude": 10.458689,
    "longitude": -66.957785,
    "tags": [
      "nostrud",
      "nulla",
      "laboris",
      "laboris",
      "dolore",
      "sit",
      "occaecat"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Latoya Wilkinson"
      },
      {
        "id": 1,
        "name": "Fitzpatrick Erickson"
      },
      {
        "id": 2,
        "name": "Corine Rose"
      }
    ],
    "greeting": "Hello, Henderson Alford! You have 2 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fc098f3cb955a2e674f9f5",
    "index": 1,
    "guid": "c5f8ee87-e219-4dc2-9ffe-350c180726b1",
    "isActive": false,
    "balance": "\$1,832.98",
    "picture": "http://placehold.it/32x32",
    "age": 25,
    "eyeColor": "blue",
    "name": "Laurie Beard",
    "gender": "female",
    "company": "COMVEYOR",
    "email": "lauriebeard@comveyor.com",
    "phone": "+1 (899) 541-3267",
    "address": "259 Gallatin Place, Fredericktown, Tennessee, 2235",
    "about": "Ut sint ipsum elit elit. Est mollit veniam cupidatat exercitation aliqua consequat aliquip. Nostrud laborum excepteur adipisicing esse consequat ex deserunt commodo in dolor qui cupidatat proident dolor. Fugiat cillum laborum non laborum. Velit laborum cupidatat do ea cillum mollit exercitation cillum irure voluptate exercitation eiusmod. Tempor nostrud commodo Lorem ex irure velit.\r\n",
    "registered": "2014-11-29T10:34:34 -07:00",
    "latitude": 30.815991,
    "longitude": 67.073853,
    "tags": [
      "voluptate",
      "sunt",
      "labore",
      "qui",
      "id",
      "dolor",
      "cillum"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Dawn Chavez"
      },
      {
        "id": 1,
        "name": "Savage Montgomery"
      },
      {
        "id": 2,
        "name": "Trudy Berg"
      }
    ],
    "greeting": "Hello, Laurie Beard! You have 7 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fc098fe79af79181394381",
    "index": 2,
    "guid": "7fc1862f-11a1-42dd-a24d-8538de1fc98a",
    "isActive": false,
    "balance": "\$2,176.61",
    "picture": "http://placehold.it/32x32",
    "age": 36,
    "eyeColor": "brown",
    "name": "Dale Mccormick",
    "gender": "male",
    "company": "COMVENE",
    "email": "dalemccormick@comvene.com",
    "phone": "+1 (958) 414-2165",
    "address": "733 Freeman Street, Defiance, Florida, 850",
    "about": "Cupidatat sit excepteur cillum est consectetur do esse. Nostrud quis in pariatur duis ut officia enim amet adipisicing. Ipsum velit consequat irure anim pariatur nisi. Labore Lorem pariatur Lorem veniam non nulla culpa qui nulla duis pariatur enim. Ut veniam ad id labore fugiat adipisicing et dolore sint. Veniam tempor excepteur incididunt nostrud esse culpa proident ipsum sint consequat ex deserunt et sint.\r\n",
    "registered": "2019-05-30T09:15:24 -07:00",
    "latitude": 5.738936,
    "longitude": 91.365385,
    "tags": [
      "do",
      "reprehenderit",
      "proident",
      "ea",
      "excepteur",
      "quis",
      "duis"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Cornelia Tyler"
      },
      {
        "id": 1,
        "name": "Howe Mann"
      },
      {
        "id": 2,
        "name": "Ashley Conway"
      }
    ],
    "greeting": "Hello, Dale Mccormick! You have 8 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fc098fd3e8eb5909ae65dc",
    "index": 3,
    "guid": "ea7ceed9-f1eb-444a-94af-7f8e40d3f0ac",
    "isActive": true,
    "balance": "\$1,500.28",
    "picture": "http://placehold.it/32x32",
    "age": 21,
    "eyeColor": "brown",
    "name": "West Santana",
    "gender": "male",
    "company": "SOLAREN",
    "email": "westsantana@solaren.com",
    "phone": "+1 (843) 475-3063",
    "address": "978 Harman Street, Calpine, Alabama, 242",
    "about": "Qui occaecat voluptate exercitation ipsum occaecat id dolore. Eiusmod amet culpa id culpa do consequat labore ea. Aliquip laboris anim fugiat enim dolore. Eu tempor tempor enim duis officia nisi eu. Fugiat magna laboris dolore sunt ipsum tempor cillum ea adipisicing cupidatat. Id dolor anim est fugiat veniam. Labore cupidatat non occaecat dolor anim exercitation.\r\n",
    "registered": "2018-06-20T06:24:36 -07:00",
    "latitude": -76.556769,
    "longitude": -41.774994,
    "tags": [
      "tempor",
      "labore",
      "qui",
      "laborum",
      "tempor",
      "non",
      "laboris"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Talley Sawyer"
      },
      {
        "id": 1,
        "name": "Clark Baxter"
      },
      {
        "id": 2,
        "name": "Stewart Barnett"
      }
    ],
    "greeting": "Hello, West Santana! You have 8 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fc098f867318b95f889f87",
    "index": 4,
    "guid": "3a665bb2-e53e-48e5-abfe-416118553d2d",
    "isActive": true,
    "balance": "\$3,605.59",
    "picture": "http://placehold.it/32x32",
    "age": 39,
    "eyeColor": "green",
    "name": "Kline Robbins",
    "gender": "male",
    "company": "BLURRYBUS",
    "email": "klinerobbins@blurrybus.com",
    "phone": "+1 (823) 483-3528",
    "address": "152 Amboy Street, Hoehne, Ohio, 7354",
    "about": "Incididunt laborum in cupidatat eiusmod esse enim sint laboris est enim nostrud magna ullamco. Eiusmod consectetur proident fugiat ut duis incididunt duis aute sit Lorem dolore ad velit deserunt. Aute laborum sit veniam sit esse dolore proident nisi magna dolore in in aliquip. Veniam nulla sunt non mollit sit amet. Commodo culpa eu enim duis Lorem adipisicing.\r\n",
    "registered": "2022-03-05T03:26:22 -07:00",
    "latitude": 12.329757,
    "longitude": -124.430447,
    "tags": [
      "quis",
      "ex",
      "in",
      "pariatur",
      "magna",
      "anim",
      "in"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Vilma Allison"
      },
      {
        "id": 1,
        "name": "Rosales Walter"
      },
      {
        "id": 2,
        "name": "Mathis May"
      }
    ],
    "greeting": "Hello, Kline Robbins! You have 8 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66fc098f44b8a197a01fb3af",
    "index": 5,
    "guid": "7fd6eb30-edc2-4bde-9873-77e2adcda094",
    "isActive": true,
    "balance": "\$2,005.74",
    "picture": "http://placehold.it/32x32",
    "age": 22,
    "eyeColor": "green",
    "name": "Herman Odonnell",
    "gender": "male",
    "company": "CALCULA",
    "email": "hermanodonnell@calcula.com",
    "phone": "+1 (929) 489-3258",
    "address": "797 Stoddard Place, Oberlin, Guam, 6179",
    "about": "Sunt cupidatat dolore mollit sint aute. In quis et nostrud aliquip culpa velit est eu eiusmod ex culpa duis. Mollit occaecat in veniam eu amet voluptate culpa proident ad do dolore. Minim ut eiusmod labore proident qui in tempor. Lorem irure veniam ipsum exercitation anim veniam ad non adipisicing pariatur amet.\r\n",
    "registered": "2020-03-07T12:12:14 -07:00",
    "latitude": 44.127279,
    "longitude": 173.118089,
    "tags": [
      "adipisicing",
      "et",
      "ipsum",
      "irure",
      "adipisicing",
      "dolore",
      "quis"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Desiree Soto"
      },
      {
        "id": 1,
        "name": "Amanda Irwin"
      },
      {
        "id": 2,
        "name": "Karin Gallagher"
      }
    ],
    "greeting": "Hello, Herman Odonnell! You have 10 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fc098f84eff1642e8a9244",
    "index": 6,
    "guid": "aed00849-4700-4d39-af43-2042018f4e16",
    "isActive": true,
    "balance": "\$3,327.93",
    "picture": "http://placehold.it/32x32",
    "age": 31,
    "eyeColor": "blue",
    "name": "Bennett Rodriguez",
    "gender": "male",
    "company": "PHARMEX",
    "email": "bennettrodriguez@pharmex.com",
    "phone": "+1 (953) 543-3659",
    "address": "473 Montieth Street, Fannett, Vermont, 1545",
    "about": "Consequat laboris nulla do Lorem irure adipisicing fugiat ut. Fugiat sint culpa enim duis consectetur consectetur elit. Quis Lorem est et eu laborum. Id laborum cupidatat Lorem id id consequat mollit proident irure irure nisi adipisicing magna. Laborum est minim et deserunt eu consequat esse consectetur deserunt. Lorem id reprehenderit cupidatat eiusmod exercitation laboris culpa nostrud. Ad minim magna amet do do laboris ullamco amet anim amet labore elit dolor.\r\n",
    "registered": "2015-12-01T06:14:30 -07:00",
    "latitude": 21.866109,
    "longitude": 155.089976,
    "tags": [
      "cupidatat",
      "id",
      "non",
      "amet",
      "laborum",
      "esse",
      "cupidatat"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Pruitt Black"
      },
      {
        "id": 1,
        "name": "Rita Mcfadden"
      },
      {
        "id": 2,
        "name": "June Melton"
      }
    ],
    "greeting": "Hello, Bennett Rodriguez! You have 6 unread messages.",
    "favoriteFruit": "banana"
  }
];