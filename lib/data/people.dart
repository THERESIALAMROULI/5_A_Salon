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
    "name": "Barberman 1",
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

        
        //dont use this bs anymore