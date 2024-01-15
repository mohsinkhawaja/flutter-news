import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/View/catogries_screen.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';
import 'package:newsapp/view_model/news_view_model.dart';

import '../models/categories_news_model.dart';
import 'news_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum FilterList{bbcNews,aryNews,googleNews,reuters,cnn,aljazeera}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel=NewsViewModel();
  FilterList? selectedMenu;
  final format=DateFormat('MMMM DD YYYY');

  String name='bbc-news';
  @override

  Widget build(BuildContext context) {
    
    final width=MediaQuery.sizeOf(context).width*1;
    final height=MediaQuery.sizeOf(context).height*1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CatogriesScreen()));
            },
            icon: Image.asset('images/category_icon.png',height: 25,width: 25,)),
       title: Center(child: Text('News',style: GoogleFonts.poppins(fontSize: 26,fontWeight: FontWeight.w700),)),

        actions: [
          PopupMenuButton<FilterList>(

            initialValue: selectedMenu,

              icon: Icon(Icons.more_vert,color: Colors.black,size: 30,),
              onSelected: (FilterList item){
              if(FilterList.bbcNews.name==item.name){
                name='bbc-news';
              }
              if(FilterList.aryNews.name==item.name){
                name='ary-news';
              }
              if(FilterList.aljazeera.name==item.name){
                name='al-jazeera-english';
              }
              if(FilterList.reuters.name==item.name){
                name='reuters';
              }
              if(FilterList.cnn.name==item.name){
                name='cnn';
              }
              if(FilterList.googleNews.name==item.name){
                name='google-news';
              }

             // newsViewModel.FetchNewsChannelHeadLinesApi();
              setState(() {
                selectedMenu=item;
              });
              },
              itemBuilder: (BuildContext context)=><PopupMenuEntry<FilterList>>[
                PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                    child: Text('BBC News')
                ),
                PopupMenuItem<FilterList>(
                    value: FilterList.aryNews,
                    child: Text('ARY News')
                ),
                PopupMenuItem<FilterList>(
                    value: FilterList.aljazeera,
                    child: Text('Aljazeera News')
                ),
                PopupMenuItem<FilterList>(
                    value: FilterList.cnn,
                    child: Text('CNN News')
                ),
                PopupMenuItem<FilterList>(
                    value: FilterList.reuters,
                    child: Text('Reuters News')
                ),
                PopupMenuItem<FilterList>(
                    value: FilterList.googleNews,
                    child: Text('Google News')
                ),
              ]
              )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height*0.55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlinesModel>(
              future: newsViewModel.FetchNewsChannelHeadLinesApi(name),
              builder: (BuildContext context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                }else{
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context,index){
                      DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return  InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailScreen(
                                newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                newsTitle:snapshot.data!.articles![index].title.toString(),
                                newsDate:snapshot.data!.articles![index].publishedAt.toString(),
                                author:snapshot.data!.articles![index].author.toString(),
                                description:snapshot.data!.articles![index].description.toString(),
                                content:snapshot.data!.articles![index].content.toString(),
                                source:snapshot.data!.articles![index].source!.name.toString(),
                            ))
                            );
                          },
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height:height*0.6,
                                  width: width*0.9,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: height*0.02,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(

                                      imageUrl:snapshot.data!.articles![index].urlToImage.toString() ,
                                      fit: BoxFit.cover,
                                      placeholder: (context,url)=>Container(child: spinKit2,),
                                      errorWidget: (context,url,error)=>Icon(Icons.error_outline,color: Colors.red,),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 15,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white ,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),

                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: height*0.22,
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width*0.7,
                                            child: Text(snapshot.data!.articles![index].title.toString(),
                                              style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,)
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width*0.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name!.toString(),
                                                  style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w500),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,),
                                                Text(format.format(dateTime),
                                                  style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w500),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      }

                  );
                }

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CatogoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
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
                      shrinkWrap: true,
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
      )
    );
  }
}

const spinKit2= SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);