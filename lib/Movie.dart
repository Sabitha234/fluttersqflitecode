import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moviepost/LoginPage.dart';
class Movie extends StatefulWidget {
  String name="";
  String email="";
  Movie( {Key? key,required this.name,required this.email}) : super(key: key);

  @override
  State<Movie> createState() => _MovieState(name:name,email: email);
}

class _MovieState extends State<Movie> {
  Map ?mapResponse;
  List ?listResult;
  String name;
  String email;
  _MovieState({required this.name,required this.email});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Movies"),
          ),
          drawer: Drawer(
           child: Column(
             children: [
               UserAccountsDrawerHeader(
                 accountName: Text(name),
                 accountEmail: Text(email),
                 currentAccountPicture: CircleAvatar(
                          backgroundImage: AssetImage('img/1.png'),
                        ),
               ),

                    ExpansionTile(
                      title:Text("Company Info"),
                      children: [
                        ListTile(title: Text("Company Name:"),
                        subtitle: Text("Geeksynergy Technologies Pvt Ltd"),
                        ),
                        ListTile(title: Text("Address:"),
                          subtitle: Text("Sanjayanagar, Bengaluru-56"),
                        ),
                        ListTile(title: Text("Phone:"),
                          subtitle: Text("9876543210"),
                        )
                        ,
                        ListTile(title: Text("Email"),
                          subtitle: Text("geeksynergy@gmail.com"),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FilledButton(onPressed: ()async{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      }, child: Text("LOGOUT")),
                    )
                  ],
                ),
             ),
          body:FutureBuilder(
              future: post(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                return ListView.builder(
                    itemCount:listResult==null?0:listResult!.length,
                    itemBuilder: (BuildContext context,int index){
                      final user = listResult![index];
                      final title = user!['title'];
                      final genre = user!['genre'];
                      final stars = user!['stars'];
                      final directors = user!['director'];
                      final language = user!['language'];
                      final releasedate = user!['releasedDate'];
                      final pageviews = user!['pageViews'];
                      final totalvoted = user!['totalVoted'];
                      final poster =  user!['poster'];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.arrow_drop_up),
                                Text("1"),
                                Icon(Icons.arrow_drop_down_sharp),
                                Text("Views")
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:Container(
                                height: 150,
                                width: 100,
                                child: Image.network(poster),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(title.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                                    SizedBox(height: 10,),
                                    Text('Genre: ' + genre.toString(),),
                                    SizedBox(height: 3,),
                                    Text('Director: ' + directors.join(" ")),
                                    SizedBox(height: 3,),
                                    Text('Starring: '+stars.join(" ,")),
                                    SizedBox(height: 3,),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text('Mins |'),
                                          Text(language.toString()+' |'),
                                          Text(releasedate.toString()),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 3,),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text( pageviews.toString()+' views | ',style: TextStyle(color: Colors.blue),),
                                          Text('Voted by ' + totalvoted.toString()+' People ',style: TextStyle(color: Colors.blue)),
                                        ],
                                      ),
                                    ),
                                    TextButton(onPressed: (){},
                                        child: Text("Watch Trailer",style: TextStyle(color: Colors.white,backgroundColor: Colors.blue),)),
                                    Divider(thickness: 3,),

                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      );
                    });
              }) // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Future<String> post()async{
    final data={"category": "movies", "language": "kannada", "genre": "all", "sort": "voting"};
    var header={'Content-Type':'application/json'};
    final response=await http.post( Uri.parse("https://hoblist.com/api/movieList"),
        headers:header,
        body:jsonEncode(data)
    );
    final responseData=jsonDecode(response.body);
    if(response.statusCode==200){
      mapResponse=responseData;
      listResult=mapResponse!['result'];

    }
    else{
      throw Exception("Failed");
    }
    return ' ';

  }
}
