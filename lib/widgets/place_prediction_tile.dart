import 'package:flutter/material.dart';
import 'package:uber_userside_clone/models/predicted_places.dart';

class PlacePredictionTileDesign extends StatelessWidget {

 final PredictedPlaces? predictedPlaces;

 PlacePredictionTileDesign({this.predictedPlaces});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: ListTile(
        leading:  Icon(Icons.location_on),
        title: Text(predictedPlaces!.main_text.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
              ),
          subtitle: Text(predictedPlaces!.secondary_text.toString(),
              overflow: TextOverflow.ellipsis,),
          
      )
      
      
    
    );
  }
}
