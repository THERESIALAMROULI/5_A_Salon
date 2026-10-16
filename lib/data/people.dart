class Person{
  final String name;
  final String phone;
  final String picture;
  const Person(this.name,this.phone,this.picture);
}

final List<Person> people =
      _people.map((e) => Person(e['name'] as String,e['phone'] as String,e['picture'] as String)).toList(growable: false);


final List<Map<String,Object>> _people =
[
  {
    "_id": "66faccc9ff344b50a0d0d55b",
    "index": 0,
    "guid": "97c555d4-42cf-4a31-b7c9-de467551a16b",
    "isActive": false,
    "balance": "\$2,324.05",
    "picture": "http://placehold.it/32x32",
    "age": 38,
    "eyeColor": "brown",
    "name": "Dorsey Lott",
    "gender": "male",
    "company": "ZOLARITY",
    "email": "dorseylott@zolarity.com",
    "phone": "+1 (850) 572-2347",
    "address": "555 Chester Court, Boling, Minnesota, 6168",
    "about": "Deserunt tempor non aliquip voluptate quis sint aute magna ullamco. Eu adipisicing deserunt nisi pariatur deserunt culpa nisi cillum consequat tempor dolore quis dolor. Tempor sint id amet adipisicing irure cillum duis sint aliqua nulla.\r\n",
    "registered": "2015-09-30T09:12:42 -07:00",
    "latitude": 22.708637,
    "longitude": 119.832188,
    "tags": [
      "reprehenderit",
      "Lorem",
      "est",
      "sint",
      "duis",
      "occaecat",
      "consequat"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Tami Stone"
      },
      {
        "id": 1,
        "name": "Sweeney Hancock"
      },
      {
        "id": 2,
        "name": "Lindsay Parker"
      }
    ],
    "greeting": "Hello, Dorsey Lott! You have 10 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66faccc9ab0c32b547e143e0",
    "index": 1,
    "guid": "17d97e8b-ffaf-4abe-b61b-b11232cc3d6f",
    "isActive": false,
    "balance": "\$2,485.44",
    "picture": "http://placehold.it/32x32",
    "age": 38,
    "eyeColor": "brown",
    "name": "Lyons Mcintyre",
    "gender": "male",
    "company": "UNI",
    "email": "lyonsmcintyre@uni.com",
    "phone": "+1 (955) 567-2717",
    "address": "573 Pleasant Place, Frank, New Hampshire, 712",
    "about": "Consectetur elit enim adipisicing laboris nisi velit. Ad consectetur amet nostrud nostrud nulla reprehenderit elit tempor eu enim. Incididunt eiusmod ad culpa consectetur irure elit irure ut cillum non ea id commodo aliquip. Aliqua non do excepteur consequat commodo est dolore veniam dolore cillum sunt dolor ex. Et sit tempor excepteur fugiat culpa est. Aliqua est Lorem nostrud reprehenderit nostrud pariatur elit ex dolor deserunt esse irure reprehenderit. Cupidatat est esse cillum sunt tempor reprehenderit.\r\n",
    "registered": "2014-02-19T10:03:31 -07:00",
    "latitude": 51.188566,
    "longitude": -26.393854,
    "tags": [
      "culpa",
      "consectetur",
      "aute",
      "ea",
      "deserunt",
      "et",
      "est"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Simone Barrera"
      },
      {
        "id": 1,
        "name": "Finley Thornton"
      },
      {
        "id": 2,
        "name": "Jeannine Morgan"
      }
    ],
    "greeting": "Hello, Lyons Mcintyre! You have 1 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66faccc952c30cfe26d38dbb",
    "index": 2,
    "guid": "c35916c9-a23d-4746-a8a9-0ad028efd16d",
    "isActive": false,
    "balance": "\$1,712.14",
    "picture": "http://placehold.it/32x32",
    "age": 29,
    "eyeColor": "brown",
    "name": "Reed Oneill",
    "gender": "male",
    "company": "QUOTEZART",
    "email": "reedoneill@quotezart.com",
    "phone": "+1 (901) 573-2104",
    "address": "916 Grattan Street, Siglerville, Virgin Islands, 3778",
    "about": "Exercitation deserunt ad magna adipisicing cillum esse ex enim ullamco aute elit. Ad ipsum cillum qui eiusmod enim nulla pariatur commodo proident. Et reprehenderit mollit non ut laboris. Laboris id reprehenderit occaecat magna irure ut esse. Ullamco aute ea dolor dolor et esse amet veniam nostrud enim. Cupidatat mollit exercitation id elit consequat in fugiat nisi qui.\r\n",
    "registered": "2014-07-28T07:32:28 -07:00",
    "latitude": 42.883276,
    "longitude": -82.700618,
    "tags": [
      "ipsum",
      "exercitation",
      "nulla",
      "exercitation",
      "reprehenderit",
      "mollit",
      "fugiat"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Janell Sawyer"
      },
      {
        "id": 1,
        "name": "Thornton Langley"
      },
      {
        "id": 2,
        "name": "Stephenson Sharp"
      }
    ],
    "greeting": "Hello, Reed Oneill! You have 2 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "66faccc979944b2dbc9816b7",
    "index": 3,
    "guid": "ffd7f728-a282-41a9-a84a-ecab27c2d59c",
    "isActive": false,
    "balance": "\$3,498.61",
    "picture": "http://placehold.it/32x32",
    "age": 24,
    "eyeColor": "green",
    "name": "June Love",
    "gender": "female",
    "company": "ZINCA",
    "email": "junelove@zinca.com",
    "phone": "+1 (969) 413-3012",
    "address": "636 Trucklemans Lane, Thornport, Massachusetts, 1313",
    "about": "Sint quis duis laborum in ex anim quis laborum dolor deserunt laboris. Irure do tempor minim cupidatat anim quis. Fugiat do adipisicing irure incididunt. Quis minim veniam sint cillum duis duis Lorem amet.\r\n",
    "registered": "2018-11-13T07:03:06 -07:00",
    "latitude": 87.386169,
    "longitude": -164.854939,
    "tags": [
      "deserunt",
      "sunt",
      "adipisicing",
      "labore",
      "qui",
      "officia",
      "ipsum"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Morris Harrison"
      },
      {
        "id": 1,
        "name": "Johnson Sanchez"
      },
      {
        "id": 2,
        "name": "Hunt Logan"
      }
    ],
    "greeting": "Hello, June Love! You have 2 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "66faccc915788c2751277dae",
    "index": 4,
    "guid": "31fcde76-a3b9-478f-a7c5-9f899dc4583d",
    "isActive": false,
    "balance": "\$2,707.44",
    "picture": "http://placehold.it/32x32",
    "age": 22,
    "eyeColor": "green",
    "name": "Galloway Abbott",
    "gender": "male",
    "company": "VIAGREAT",
    "email": "gallowayabbott@viagreat.com",
    "phone": "+1 (901) 584-2620",
    "address": "153 Beverly Road, Bentley, Montana, 1311",
    "about": "Laborum esse anim id et qui laboris dolore reprehenderit minim amet ut ut enim. Cupidatat incididunt magna ullamco do ipsum consectetur culpa aliquip voluptate eu sunt sunt. Non irure est ut mollit sit qui nulla tempor nisi ullamco esse adipisicing anim elit. Consequat quis amet ut velit do commodo quis sint aliquip reprehenderit.\r\n",
    "registered": "2022-02-06T12:26:16 -07:00",
    "latitude": -70.959149,
    "longitude": 159.193876,
    "tags": [
      "magna",
      "nostrud",
      "nulla",
      "veniam",
      "esse",
      "sunt",
      "deserunt"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Roseann Lindsey"
      },
      {
        "id": 1,
        "name": "Short Bryan"
      },
      {
        "id": 2,
        "name": "Green Young"
      }
    ],
    "greeting": "Hello, Galloway Abbott! You have 4 unread messages.",
    "favoriteFruit": "banana"
  }
];