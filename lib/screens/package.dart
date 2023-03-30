import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PackageDelivery extends StatefulWidget {
  const PackageDelivery({super.key});

  @override
  State<PackageDelivery> createState() => _PackageDeliveryState();
}

class _PackageDeliveryState extends State<PackageDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Package delivery',style: TextStyle(color: Colors.black,fontSize: 28),),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon:Icon(Icons.arrow_back_sharp,color: Colors.black,size: 28,)),
      ),
      body: SafeArea(child: 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2.5,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(20),
                  border: Border.all(color: Colors.black38)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                     borderRadius: BorderRadius.circular(10.0),
                    child:  Image.asset('assets/images/package_cover.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Introducing Connect',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                    ),
                    
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text('Your items delivered in the time it takes to drive there.',style: TextStyle(fontSize: 18,color: Colors.black45),),
                     )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/2.8,),
              ElevatedButton(
                
                style:ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                onPressed: (){
       
              }, child: Container(
                height: 50,
                width: double.infinity,
                child: Center(child: Text('Send a package',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)))
              )
            ],
          ),
        ),
      )),
    );
  }
}