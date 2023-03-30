class PredictedPlaces 
{
  
String? place_id;
String? main_text;
String? secondary_text;

PredictedPlaces(
  {
    this.main_text,
    this.place_id,
    this.secondary_text
  }
);

PredictedPlaces.fromJson(Map<String,dynamic> jsonData)
{
   place_id =  jsonData['id'];
    main_text =  jsonData['text'];
     secondary_text =  jsonData['place_name'];
}

}