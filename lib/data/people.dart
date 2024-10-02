class Person{
  final String name ;
  final String phone ;
  final String picture;
  const Person(this.name, this.phone, this.picture);
}

final List<Person> people =
      _people.map((e) => Person(e['name'] as String, e['phone'] as String, e['picture'] as String)).toList(growable: false);

final List<Map<String,Object>> _people =
  [
  {
    "_id": "66fbde546b8a2adae0e4ccee",
    "index": 0,
    "guid": "dc73e7b4-c840-4a26-b5d3-990e3e7560b1",
    "isActive": false,
    "balance": "\$3,481.34",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "brown",
    "name": "Monique Henry",
    "gender": "female",
    "company": "DELPHIDE",
    "email": "moniquehenry@delphide.com",
    "phone": "+1 (994) 418-2154",
    "address": "186 Autumn Avenue, Brecon, Federated States Of Micronesia, 4218",
    "about": "Id ex proident ut voluptate minim aliquip dolore ullamco dolore ea adipisicing. Mollit anim in consequat est et consequat dolor ullamco sit nostrud ex sint ipsum dolore. Exercitation officia reprehenderit duis cupidatat elit sunt reprehenderit irure. Nostrud commodo non amet commodo incididunt velit. Proident commodo sint eiusmod laborum amet. Veniam nisi minim occaecat esse sit fugiat qui aliquip ea non ullamco duis eiusmod non. Nisi esse Lorem esse laborum mollit amet velit tempor est nisi.\r\n",
    "registered": "2022-05-19T08:25:50 -07:00",
    "latitude": -27.208862,
    "longitude": -93.726442,
    "tags": [
      "do",
      "aliquip",
      "commodo",
      "tempor",
      "ex",
      "nulla",
      "anim"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Carmen Bowers"
      },
      {
        "id": 1,
        "name": "Branch Powell"
      },
      {
        "id": 2,
        "name": "Pansy Rivas"
      }
    ],
    "greeting": "Hello, Monique Henry! You have 7 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66fbde54061ca39ffd167a5c",
    "index": 1,
    "guid": "1f06c933-8426-4168-832e-f4f508a2fb44",
    "isActive": false,
    "balance": "\$3,402.36",
    "picture": "http://placehold.it/32x32",
    "age": 22,
    "eyeColor": "green",
    "name": "Boyle Dickson",
    "gender": "male",
    "company": "ZIZZLE",
    "email": "boyledickson@zizzle.com",
    "phone": "+1 (831) 463-3180",
    "address": "379 Bridgewater Street, Eastmont, Virgin Islands, 6294",
    "about": "Ipsum cillum excepteur velit magna mollit voluptate aute aliquip. Labore veniam nulla officia deserunt do reprehenderit. Sit mollit do eu exercitation dolor nisi.\r\n",
    "registered": "2024-04-04T02:05:10 -07:00",
    "latitude": 3.772148,
    "longitude": 8.971708,
    "tags": [
      "culpa",
      "ut",
      "anim",
      "anim",
      "laborum",
      "proident",
      "do"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Jayne Cherry"
      },
      {
        "id": 1,
        "name": "Hannah Coffey"
      },
      {
        "id": 2,
        "name": "Helen England"
      }
    ],
    "greeting": "Hello, Boyle Dickson! You have 6 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66fbde54521b34dd18642fef",
    "index": 2,
    "guid": "e8a6541a-bb96-4072-9fe0-62270c75d0a0",
    "isActive": false,
    "balance": "\$3,306.19",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "brown",
    "name": "Preston Shaffer",
    "gender": "male",
    "company": "COMVEYER",
    "email": "prestonshaffer@comveyer.com",
    "phone": "+1 (829) 579-2074",
    "address": "294 Pleasant Place, Coaldale, Florida, 6348",
    "about": "Sit officia commodo in ipsum id in. Dolore consequat consequat aliqua culpa dolore laboris sint. Eiusmod mollit incididunt quis aliqua. Ipsum fugiat anim tempor duis. Occaecat eiusmod sint laborum ipsum ex exercitation excepteur sit deserunt consequat in dolor. Sit aute eiusmod eiusmod reprehenderit occaecat enim ut nisi ut ex reprehenderit est. Deserunt ad dolor et exercitation nulla mollit officia consequat nulla ut.\r\n",
    "registered": "2019-02-24T03:54:58 -07:00",
    "latitude": 57.394667,
    "longitude": -47.333825,
    "tags": [
      "aute",
      "qui",
      "officia",
      "eu",
      "magna",
      "labore",
      "ad"
    ],
    "friends": [
      {
        "id": 0,
        "name": "King Pugh"
      },
      {
        "id": 1,
        "name": "Henderson Yates"
      },
      {
        "id": 2,
        "name": "Sears Wall"
      }
    ],
    "greeting": "Hello, Preston Shaffer! You have 2 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fbde54c89d3001f3e969c9",
    "index": 3,
    "guid": "8110062c-f04b-432b-9e59-702960207a58",
    "isActive": true,
    "balance": "\$2,729.25",
    "picture": "http://placehold.it/32x32",
    "age": 31,
    "eyeColor": "brown",
    "name": "Marcie Guy",
    "gender": "female",
    "company": "TRASOLA",
    "email": "marcieguy@trasola.com",
    "phone": "+1 (911) 433-3757",
    "address": "490 Verona Place, Lacomb, Minnesota, 3405",
    "about": "Adipisicing commodo proident Lorem nostrud sit culpa amet ea ex sint ex voluptate. Esse pariatur minim nulla mollit nostrud et duis enim. Pariatur sunt sit veniam reprehenderit occaecat duis laboris incididunt culpa enim eiusmod incididunt ut qui. Nostrud Lorem irure aute id nostrud labore.\r\n",
    "registered": "2017-01-14T03:33:27 -07:00",
    "latitude": -86.098828,
    "longitude": 6.891508,
    "tags": [
      "eu",
      "cillum",
      "nostrud",
      "exercitation",
      "irure",
      "aute",
      "non"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Little Mcguire"
      },
      {
        "id": 1,
        "name": "Essie Rivera"
      },
      {
        "id": 2,
        "name": "Antoinette Vincent"
      }
    ],
    "greeting": "Hello, Marcie Guy! You have 10 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "66fbde542073ea1fcb596d39",
    "index": 4,
    "guid": "d804bec7-dd6f-431f-b24c-364ce7882031",
    "isActive": true,
    "balance": "\$1,847.52",
    "picture": "http://placehold.it/32x32",
    "age": 28,
    "eyeColor": "green",
    "name": "Simpson Valdez",
    "gender": "male",
    "company": "MUSAPHICS",
    "email": "simpsonvaldez@musaphics.com",
    "phone": "+1 (825) 492-3755",
    "address": "749 Amity Street, Chesterfield, North Dakota, 3158",
    "about": "Cupidatat aute pariatur cupidatat nulla dolore id non amet enim velit qui nostrud ea dolor. Ex mollit sint laboris aute cillum est elit veniam. Dolore officia aute nostrud magna deserunt elit cupidatat aute ut irure. Proident est id consequat officia sunt.\r\n",
    "registered": "2017-08-23T08:00:17 -07:00",
    "latitude": 83.682031,
    "longitude": -67.704281,
    "tags": [
      "voluptate",
      "proident",
      "irure",
      "amet",
      "velit",
      "nisi",
      "ipsum"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Alejandra Deleon"
      },
      {
        "id": 1,
        "name": "Dalton Sharpe"
      },
      {
        "id": 2,
        "name": "Ferguson Norris"
      }
    ],
    "greeting": "Hello, Simpson Valdez! You have 1 unread messages.",
    "favoriteFruit": "apple"
  }
];