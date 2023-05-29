import 'package:shared_preferences/shared_preferences.dart';

   DateTime Date = DateTime.now();
class Database{

  List<List<dynamic>> info = [];


//TODO This part of the code saves the inputted data into the list and stores it in shared preference

Future<void> saveList(List<List<dynamic>> infoList) async
{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('infoList', infoList.map((list) => list.join(',')).toList());
}

  Future<void> Store({required List<List<dynamic>> oldList, required String title, required int amount}) async {
    print(oldList);
    final List<List<String>> newList = oldList.map((item) => item.map((dynamic element) => element.toString()).toList()).toList();
    newList.add([title, amount.toString()]);
    saveList(newList);
  }



//TODO This part of the code retrieves the data of list stored in shared preference

  Future<List<List<dynamic>>> getList() async {
  final prefs = await SharedPreferences.getInstance();
  final listString = prefs.getStringList('infoList');
  if (listString == null){
    return [];
  }
  return listString.map((item) => item.split(',')).toList();

  }

}
