import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/categories_news_model.dart';

import '../view_model/news_view_model.dart';

class CatogriesScreen extends StatefulWidget {
  const CatogriesScreen({super.key});

  @override
  State<CatogriesScreen> createState() => _CatogriesScreenState();
}

class _CatogriesScreenState extends State<CatogriesScreen> {
  NewsViewModel newsViewModel=NewsViewModel();

  final format=DateFormat('MMMM DD YYYY');

  String categoryName='General';

  List<String>categoriesList=[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width*1;
    final height=MediaQuery.sizeOf(context).height*1;
    return  Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount:categoriesList.length ,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        categoryName=categoriesList[index];
                        setState(() {

                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: categoryName==categoriesList[index]? Colors.blue:Colors.grey,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Center(child: Text(categoriesList[index].toString(),
                              style: GoogleFonts.poppins(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w700),

                            ),
                            ),
                          ),
                        ),
                      ),
                    );

              }
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: FutureBuilder<CatogoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (BuildContext context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }else

                  {
                    return ListView.builder(

                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context,index){
                          DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return  Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(

                                    imageUrl:snapshot.data!.articles![index].urlToImage.toString() ,
                                    fit: BoxFit.cover,
                                    height:height*.18,
                                    width:width*.3,
                                    placeholder: (context,url)=>Container(child:  SpinKitCircle(
                                      size: 50,
                                      color: Colors.blue,
                                    ),),
                                    errorWidget: (context,url,error)=>Icon(Icons.error_outline,color: Colors.red,),
                                  ),
                                ),
                                Expanded(child: Container(
                                  height: height*.18,
                                  padding:EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data!.articles![index].title.toString(),maxLines: 3,
                                      style: GoogleFonts.poppins(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data!.articles![index].source!.name.toString(),
                                            style: GoogleFonts.poppins(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w500),
                                          ),
                                          Text(format.format(dateTime),
                                            style: GoogleFonts.poppins(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                              ],

                            ),
                          );
                        }

                    );
                  }

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
