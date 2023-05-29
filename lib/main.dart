import 'package:flutter/material.dart';
import 'backend.dart';

dynamic main(){
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Center(
            child: Text('MCE + Spend')
          ),
          elevation: 0,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              GestureDetector(
                onTap: ()
            {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Eachday()));
            },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 5,
                                color: Colors.black
                            ),
                            left: BorderSide(
                                width: 5,
                                color: Colors.black
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: const Text("hewjnsdkn"),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 5,
                                color: Colors.black
                            ),
                            right: BorderSide(
                                width: 5,
                                color: Colors.black
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: const Text("hkn"),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10,  horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 5,
                                color: Colors.black
                            ),
                            left: BorderSide(
                                width: 5,
                                color: Colors.black
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: const Text("hewjnsdkn"),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 5,
                                color: Colors.black
                            ),
                            right: BorderSide(
                                width: 5,
                                color: Colors.black
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: const Text("hewjnsdkn"),
                      ),
                    ],
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}

class Eachday extends StatefulWidget {

   Eachday({Key? key}) : super(key: key);

  @override
  State<Eachday> createState() => _EachdayState();
}

class _EachdayState extends State<Eachday> {
   TextEditingController Title = TextEditingController();

   TextEditingController Amount = TextEditingController();

   Database infoObject = Database();

   List<List<dynamic>> retrievedList = [];


   void retrievedData() async {
     setState(() async {
       retrievedList = await infoObject.getList();
     });
   }

   bool notDisplayed = true;

   @override
  void initState() {
    // TODO: implement initState
     setState(() {
       retrievedData();
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: notDisplayed ? GestureDetector(
        onTap: (){
          setState(() {
            notDisplayed = false;
          });
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Center(child: Text("Tap to display records"),),
        ),
      ) : Stack(
        alignment: Alignment.topCenter,
            children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 60, 10, 0),
                  child: ListView.builder(
                  itemCount: retrievedList.length,
                  itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children: [
                          InkWell(
                            onLongPress: ()
                          {
                             setState(() {
                               infoObject.removeData(oldList: retrievedList, index: index);
                               retrievedData();
                             });
                          },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      "${retrievedList[index][0]}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                  Text(
                                      "₦${retrievedList[index][1]}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                  );
                  }
              ),
                ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: Title,
                        decoration: InputDecoration(
                          hintText: "Reason for spending",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/10),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: Amount,
                        decoration: InputDecoration(
                          hintText: "Amount spent",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              infoObject.Store(
                  oldList: retrievedList,
                  title: Title.text,
                  amount: int.parse(Amount.text)
              );
              retrievedData();
              Title.clear();
              Amount.clear();
            setState(() {});
          },
            icon: Icon(Icons.add),
            label: Text('Add'),
          ),
    );

  }

}
