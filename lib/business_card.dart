import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key, required this.imgUrl});
  final String imgUrl;
  final String name = "John Juvi De Villa";
  final String title = "Embedded System Engineer";
  final String phoneNo = "0995 428 9231";
  final String location = "sa puso mo";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imgUrl), 
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(Color.fromARGB(137, 0, 0, 0), BlendMode.darken)
          ), 
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: -10.0
                )
              ]
            ),
            child: const CircleAvatar(
              radius: 75.0,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Robert_Downey%2C_Jr._2012.jpg/1200px-Robert_Downey%2C_Jr._2012.jpg'),
              ),
            ),
          ),

          const SizedBox(height: 30.0,),

          Text(
            name, 
            style: const TextStyle(color: Colors.white, fontSize: 25.0),
          ),
          const SizedBox(height: 10.0,),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14.0, fontWeight: FontWeight.w300),
          ),

          const SizedBox(height: 30.0,),

          CardDetails(
            icon: const Icon(Icons.phone, color: Colors.white,), 
            details: phoneNo,
          ),
          const SizedBox(height: 18.0,),
          CardDetails(
            icon: const Icon(Icons.location_on, color: Colors.white,),
            details: location,
          )
        ],
      ),
    );
  }
}



class CardDetails extends StatelessWidget {
  const CardDetails({super.key, required this.icon, required this.details});
  final Icon icon;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 70.0),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 15.0,),
          Text(details, style: const TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}