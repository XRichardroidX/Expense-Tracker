import 'package:shared_preferences/shared_preferences.dart';
class Database{

  String? todaysDate;

void getIndex (int index){
  todaysDate = index.toString();
}

//TODO This part of the code saves the inputted data into the list and stores it in shared preference


Future<void> saveList(List<List<dynamic>> infoList) async
{  print({"$infoList is what is being saved"});
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList(todaysDate!, infoList.map((list) => list.join(',')).toList());
}

  Future<void> Store({required List<List<dynamic>> oldList, required String title, required int amount}) async {
    final List<List<String>> newList = oldList.map((item) => item.map((dynamic element) => element.toString()).toList()).toList();
    newList.add([title, amount.toString()]);
    saveList(newList);
  }


  var newList = [[]];
//TODO This part of the code retrieves the data of list stored in shared preference

  Future<List<List<dynamic>>> getList(int selectedDateIndex) async {
  final prefs = await SharedPreferences.getInstance();
  final listString = prefs.getStringList(todaysDate!);
  newList = listString!.map((item) => item.split(',')).toList();
  if (listString == null){
    return [];
  }
   print({"$newList is the inner list"});
  return listString.map((item) => item.split(',')).toList();
  }


  void removeData({required List<List<dynamic>> oldList, required int index}){
    newList = oldList.map((item) => item.map((dynamic element) => element.toString()).toList()).toList();
    newList.removeAt(index);
    saveList(newList);
  }

  void clearAll() async {
    final prefs = await SharedPreferences.getInstance();
   // myList.removeWhere((element) => element == '');
    print({"$todaysDate This ID key will be removed"});
    prefs.remove(todaysDate.toString());
  }

  double totalAmountPerDay(List<List<dynamic>> List, int listLength){
    double sum = 0;
    for(int i = 0; i < listLength; i++){
      sum += double.parse(List[i][1]);
    }
  return sum;
  }

  List<String> listOfDates = [];
  void saveListOfDates(int day) async {
    listOfDates = await getListOfDate();
    listOfDates.add(day.toString());
  final pref = await SharedPreferences.getInstance();
  pref.setStringList('EveryDateList', listOfDates);
  }

  Future<List<String>> getListOfDate() async {
    final pref = await SharedPreferences.getInstance();
    List<String>? result = pref.getStringList('EveryDateList');
    if(result == null){
      return [];
    }
    print({"$result This is the outer list"});
    listOfDates = result;
    return result;
  }

  void clearDateList (int index) async {
    final pref = await SharedPreferences.getInstance();
    listOfDates[index] = '';
    pref.setStringList('EveryDateList', listOfDates);
  }


}
