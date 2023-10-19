import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({
    super.key, 
    required this.imgUrl,
    required this.name,
    required this.title,
    required this.phoneNo,
    required this.location,
    required this.avatarUrl
  });
  final String imgUrl;
  final String name;
  final String title;
  final String phoneNo;
  final String location;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      decoration: BoxDecoration(
          color: Colors.grey[600],
          image: DecorationImage(
            image: AssetImage(imgUrl), 
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
            child: CircleAvatar(
              radius: 75.0,
              backgroundColor: Colors.green,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(avatarUrl),
              ),
            ),
          ),

          const SizedBox(height: 30.0,),

          Text(
            name, 
            style: const TextStyle(color: Colors.white, fontSize: 25.0, fontFamily: 'Inconsolata'),
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
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
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