import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'loading.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List data = [];

  Future<String> getData() async {
    try{ var response = await http.get(Uri.parse('https://smsapp.bits-postman-lab.in/courses'));
    Map courses = jsonDecode(response.body);

    setState(() {
      data = courses
      ['courses'];
    });
    return 'Success!';}
        catch (e) {print(e); return 'Failure!'; }
  }

  List foundCourses = [];

  void runSearch(String enteredWord) {
    List results = [];
    if (enteredWord.isEmpty) {
      results = data;
    }

    else {
      results = data.where((courses) => courses['courseName'].toLowerCase().contains(enteredWord.toLowerCase())).toList();
    }
    setState(() {
      foundCourses = results;
    });
  }

  void runSearchByDepartment(String? enteredWord) {
    List results = [];

    if (enteredWord!.isEmpty) {
      results = data;
    }
else {
    results = data.where((courses) => courses['department'].contains(enteredWord)).toList();}
    setState(() {
      foundCourses = results;
    });
  }

  void runSearchByYear(String? enteredWord) {
    List results = [];

    if (enteredWord!.isEmpty) {
      results = data;
    }
else {
    results = data.where((courses) => courses['year'].contains(enteredWord)).toList();}
    setState(() {
      foundCourses = results;
    });
  }


  @override
  void initState() {
    super.initState();
    getData();
    foundCourses = data;

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
          drawer: Drawer(
          backgroundColor: Colors.purpleAccent[100],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  const Image(image: NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                    height: 100,),
                  const SizedBox(height: 25,),
                  const Text('Name'),
                  const Text('ID Number' ),
                  SizedBox(
                    height: 55,
                    child: TextButton(
                      onPressed: () {},
                      child: const ListTile(
                        leading: Icon(Icons.home,),
                        title: Text('Dashboard' , style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const ListTile(
                      leading: Icon(Icons.book_sharp),
                      title: Text('Resources' , style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 100),
                  CircleAvatar(radius: 30, backgroundColor: Colors.black,
                    child: Center(child: IconButton(icon: Icon(Icons.arrow_back_rounded, color: Colors.red[700],size: 42,),
                      onPressed: () {Navigator.pop(context);},)))
                ],
              ),
            ),
            ),
            appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const Text(
            'Home',
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
            ),
            ),
            ),
          body: Stack( 
            children: [
            Container(
    decoration: const BoxDecoration(
    image: DecorationImage(
    fit: BoxFit.fill ,
    image: NetworkImage('https://e0.pxfuel.com/wallpapers/562/601/desktop-wallpaper-purple-heart-simple-instagram-iphone-lavender-purple-aesthetic-background-purple-phone-purple-cute-simple-purple.jpg')
    )
    )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 18,),
                 TextField(
                   onChanged: (value)=> runSearch(value),
                   decoration: const InputDecoration(
                     labelText: 'Search by Course Name', suffixIcon: Icon(Icons.search_sharp)
                   ),
                 )

                ,const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    DropdownMenu(
                      onSelected: (department) =>  runSearchByDepartment(department),
                      width: 190,
                      label: const Text(
                        'by department',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      menuHeight: 200,
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.purple[200])
                            ),
                            label:'CS' , value: '' ),
                        DropdownMenuEntry(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.purple[200])),
                            value: '',
                            label: 'Elec.',

                        ),
                        DropdownMenuEntry(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.purple[200])),
                          value: '',
                          label: 'Mech.',

                        )

                      ],
                    ),
                    DropdownMenu(
                      onSelected: (year) => runSearchByYear(year),
                      width: 185,
                      label: const Text(
                        'by year',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      menuHeight: 200,
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.purple[200])
                            ),
                            label:'1st' ,
                            value: '' ),
                        DropdownMenuEntry(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.purple[200])),
                            value: '',
                            label: '2nd',
                        ),
                        DropdownMenuEntry(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.purple[200])
                            ),
                            label:'3rd' ,
                            value: '' ),
                        DropdownMenuEntry(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.purple[200])
                            ),
                            label:'4th' ,
                            value: '' ),
                      ],
                    )
                  ],
                )
                ],
              ),

        Padding(
          padding: const EdgeInsets.fromLTRB(13, 190, 13, 35),
          child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                 return ListView.separated(
            shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()
                ),
                itemCount: foundCourses.length,
                separatorBuilder: (context, index) => const Divider(
                thickness: 0,
                color: Colors.transparent,
                height: 25,
                ),
                itemBuilder: (context, index) =>TextButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.deepPurple[200]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))
                ),
                onPressed: () {},
                child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Text(
                'Course Name : ${foundCourses[index]['courseName']}'),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          Text('Course Code : ${foundCourses[index]['courseCode']}'),
                Text('Year : ${foundCourses[index]['year']}')
                ],
                ),
                Text(
                'Department : ${foundCourses[index]['department']}')
                ],
                ),
                )),
                );}
                 ),
        )],
      )
    );
      
  }
}

