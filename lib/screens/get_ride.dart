import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:uber_userside_clone/Requests/search.dart';
import 'package:uber_userside_clone/global/global.dart';
import 'package:uber_userside_clone/main.dart';
import 'package:uber_userside_clone/models/predicted_places.dart';
import 'package:uber_userside_clone/utils/google_maps.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:uber_userside_clone/widgets/place_prediction_tile.dart';
import '../assistants/assistant_methods.dart';
import 'package:uber_userside_clone/assistants/requests_assistants.dart';
import '../helper/shared_preferences.dart';
class GetRide extends StatefulWidget {
 
String proximity =
    '${sharedPreferences.getDouble('longitude')}%2C${sharedPreferences.getDouble('latitude')}';
  @override
  State<GetRide> createState() => _GetRideState();
}

class _GetRideState extends State<GetRide> {
  
List<PredictedPlaces> placesPredictedList = [];

void findPlaceAutoCompleteSearch(String inputText) async
{ 
  if(inputText.length > 1)
  {
       String urlAutoCompleteSearch = "https://api.mapbox.com/geocoding/v5/mapbox.places/$inputText.json?country=In&limit=5&proximity=$proximity&types=place%2Cpostcode%2Caddress&access_token=pk.eyJ1Ijoic2Fpa3VtYWFya3VzYW5naSIsImEiOiJjbDhhZGlodDYwOWd6M3VsZjUzMGU1dDhwIn0.S7o9UGqs6tgZsGAmv2ZvtQ";

      var responseAutoCompleteSearch =  await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

      if (responseAutoCompleteSearch.toString().length == 0 ) {
        return ;
      }
   if (responseAutoCompleteSearch.toString().length != 0) {
       var  placesPredictions =  responseAutoCompleteSearch['features'];

      var placesPredictionsList =  (placesPredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();
   
      placesPredictedList = placesPredictionsList;
   }
  }
}

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Stack(children: [
             
                 Container(
                       height: MediaQuery.of(context).size.height/1.9,
                      child:
                      MapView(),
                    ),
                     Positioned(
                top: 17,
                left: 17,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.black,
                          size: 32,
                        )),
                  ),
                )),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedSize(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 120),
                    child: Container(
                      height: MediaQuery.of(context).size.height/2.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                        )
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Expanded(child: Text(greeting()+userModelCurrentInfo!.name.toString(),style: TextStyle(fontSize: 24),)),
                            ),
                              Divider(color: Colors.grey,),
                              
                              Padding(
                                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                                          child: Container(
                                              decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 236, 233, 233),
                                          ),
                                            child: Stack(
                                              children: [
                                               
                                               Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                                        child: new Container(
                                          decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 236, 233, 233),
                                          ),
                                          child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: new TextField(
                          onChanged:(valueTyped){
                              findPlaceAutoCompleteSearch(valueTyped);
                          },
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          style: TextStyle(color: Colors.black, fontSize: 24),
                          decoration: new InputDecoration(
                            hintText: 'Enter Pickup Point?',
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 24),
                            border: InputBorder.none,
                          ),
                        ),
                                          ),
                                        ),
                                      ),
                                     
                                          Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 20,),
                                        child: new Container(
                                          decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 236, 233, 233),
                                          ),
                                          child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: (placesPredictedList.length > 0)? 
                   
                  
                      
                       Container(
                        height: 100,
                         child: ListView.separated(
                          
                          physics: ClampingScrollPhysics(),
                          itemCount: placesPredictedList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(color: Color.fromARGB(255, 129, 126, 126),height: 1,thickness: 1,);
                          },
                          itemBuilder: (context,index){
                            return PlacePredictionTileDesign(
                              predictedPlaces: placesPredictedList[index],
                            );
                          },
                          ),
                       )  : Container(width: double.infinity,height: 30,child: Center(child: Text('Place not found',style: TextStyle(fontSize: 18),)),),
                        
                   )
                   
                  
                                          ),
                                        ),
                                      
                                                 Positioned(
                                                  right: 10,
                                                  top: 10,
                                                  child: Icon(Icons.my_location)),
                          ]),
                                          )),
                                          
                                          Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                                        child: new Container(
                                          decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 236, 233, 233),
                                          ),
                                          child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: new TextField(
                          onChanged:(valueTyped){
                              findPlaceAutoCompleteSearch(valueTyped);
                          },
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          style: TextStyle(color: Colors.black, fontSize: 24),
                          decoration: new InputDecoration(
                            hintText: 'Where to?',
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontSize: 24),
                            border: InputBorder.none,
                          ),
                        ),
                                          ),
                                        ),
                                      ),
                                     
                                          Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 20,),
                                        child: new Container(
                                          decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color.fromARGB(255, 236, 233, 233),
                                          ),
                                          child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: (placesPredictedList.length > 0)? 
                   
                  
                      
                       Container(
                        height: 100,
                         child: ListView.separated(
                          
                          physics: ClampingScrollPhysics(),
                          itemCount: placesPredictedList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(color: Color.fromARGB(255, 129, 126, 126),height: 1,thickness: 1,);
                          },
                          itemBuilder: (context,index){
                            return PlacePredictionTileDesign(
                              predictedPlaces: placesPredictedList[index],
                            );
                          },
                          ),
                       )  : Container(width: double.infinity,height: 30,child: Center(child: Text('Place not found',style: TextStyle(fontSize: 18),)),),
                        
                   )
                   
                  
                                          ),
                                        ),
                                      
                                   Padding(
                                     padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                                     child: ElevatedButton(
                
                style:ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                onPressed: (){
       
              }, child: Container(
                height: 50,
                width: double.infinity,
                child: Center(child: Text('Get a ride',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)))
              ),
                                   ),

                
                 
                          ],
                        ),
                      ),
                    ),
                  )
                )
          ]),
        ),
      ),
    );
  }
}



class StateService {
  static final List<String> states = [
    'ANDAMAN AND NICOBAR ISLANDS',
    'ANDHRA PRADESH',
    'ARUNACHAL PRADESH',
    'ASSAM',
    'BIHAR',
    'CHATTISGARH',
    'CHANDIGARH',
    'DAMAN AND DIU',
    'DELHI',
    'DADRA AND NAGAR HAVELI',
    'GOA',
    'GUJARAT',
    'HIMACHAL PRADESH',
    'HARYANA',
    'JAMMU AND KASHMIR',
    'JHARKHAND',
    'KERALA',
    'KARNATAKA',
    'LAKSHADWEEP',
    'MEGHALAYA',
    'MAHARASHTRA',
    'MANIPUR',
    'MADHYA PRADESH',
    'MIZORAM',
    'NAGALAND',
    'ORISSA',
    'PUNJAB',
    'PONDICHERRY',
    'RAJASTHAN',
    'SIKKIM',
    'TAMIL NADU',
    'TRIPURA',
    'UTTARAKHAND',
    'UTTAR PRADESH',
    'WEST BENGAL',
    'TELANGANA',
    'LADAKH'
  ];


  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(states);
    matches.retainWhere((s) =>   s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }}

