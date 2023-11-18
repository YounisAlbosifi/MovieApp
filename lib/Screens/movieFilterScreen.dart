import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Screens/movieFilterResults.dart';
import '../Classes/movieResult.dart';
import '../Helpers/filterPicture.dart';
import '../Helpers/movieAPI.dart';
import '../components/Text.dart';
import '../constants.dart';

class MovieFilter extends StatefulWidget {
  const MovieFilter({super.key});
  @override
  State<MovieFilter> createState() => _MovieFilterState();
}

class _MovieFilterState extends State<MovieFilter> {
  // -------------------------------------------------------------
  List<String> selectedGenres = [];
  String? selectedLanguage;
  double selectedRating = 3.0;
  bool isSelectedLanguage = false;
  bool isRunTimeSelected = false;
  String? runtime;
  bool showYearSlider = false;
  bool showRating = false;
  bool selectLength = false;
  double selectedYear = DateTime.now().year.toDouble();
  // -------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Filter Screen")
        ),
        body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ListView.builder(
                    itemCount: genres.length,
                    itemBuilder: (context, index) {
                      print(genres[index]);
                      return FilterPicture(
                        imagePath: selectedGenres.contains(genres[index]) ? "assets/${genres[index]}_selected.png" : "assets/${genres[index]}.png",
                        genreName: genres[index],
                        onTap: () {
                          toggleGenreSelection(genres[index]);
                        },
                        isSelected: selectedGenres.contains(genres[index]), // Pass isSelected flag for ui changes (YOUNIS)
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(height: 80,),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FilterPicture(
                        imagePath: "assets/USA.png",
                        onTap: (){
                          toggleLanguageSelection("en");
                        },
                        isSelected: selectedLanguage == "en",
                      ),
                      FilterPicture(
                        imagePath: "assets/ARABIC.jpg",
                        onTap: (){
                          toggleLanguageSelection("ar");
                        },
                        isSelected: selectedLanguage == "ar",
                      ),
                      FilterPicture(
                        imagePath: "assets/KO.png",
                        onTap: (){
                          toggleLanguageSelection("ko");
                        },
                        isSelected: selectedLanguage == "ko",
                      ),
                      FilterPicture(
                        imagePath: "assets/INDIA.png",
                        onTap: (){
                          toggleLanguageSelection("hi");
                        },
                        isSelected: selectedLanguage == "hi",
                      ),
                      FilterPicture(
                        imagePath: "assets/JAPAN.png",
                        onTap: (){
                          toggleLanguageSelection("ja");
                        },
                        isSelected: selectedLanguage == "ja",
                      ),
                      FilterPicture(
                        imagePath: "assets/FRANCE.png",
                        onTap: (){
                          toggleLanguageSelection("fr");
                        },
                        isSelected: selectedLanguage == "fr",
                      ),
                      FilterPicture(
                        imagePath: "assets/SPAIN.png",
                        onTap: (){
                          toggleLanguageSelection("es");
                        },
                        isSelected: selectedLanguage == "es",

                      ),
                      FilterPicture(
                        imagePath: "assets/OTHER.jpg",
                        onTap: (){
                          toggleLanguageSelection("other");
                        },
                        isSelected: selectedLanguage == "other",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if(!showRating){
                          showRating = true;
                        }
                        else if(showRating){
                          showRating = false;
                        }
                      });
                    },
                    child: showRating == false ? const Text("Select rating") : const Text("Unselect rating")),
                if(showRating) Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Slider(
                        value: selectedRating,
                        min: 0.0,
                        max: 9.0,
                        divisions: 90,
                        onChanged: (value) {
                          setState(() {
                            selectedRating = value;
                          });
                        },
                      )
                    ),
                    CustomText("Movies Above: ${selectedRating.toStringAsFixed(1)}"),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if(!selectLength){
                          selectLength = true;
                        }
                        else if(selectLength){
                          selectLength = false;
                        }
                      });
                    },
                    child: selectLength == false ? const Text("Select length") : const Text("Unselect length")),
                if(selectLength) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // "long", "normal", "short"
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: runtime == "long" ? Colors.blue : Colors.white, shape: const StadiumBorder()),
                        onPressed: ()  {
                          toggleRunTime("long");
                        },
                        child: const CustomText(
                          "Long",
                          size: 24,
                          color: Colors.black,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: runtime == "normal" ? Colors.blue : Colors.white, shape: const StadiumBorder()),
                        onPressed: ()  {
                          toggleRunTime("normal");
                        },
                        child: const CustomText(
                          "Normal",
                          size: 24,
                          color: Colors.black,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: runtime == "short" ? Colors.blue : Colors.white, shape: const StadiumBorder()),
                        onPressed: ()  {
                          toggleRunTime("short");
                        },
                        child: const CustomText(
                          "Short",
                          size: 24,
                          color: Colors.black,
                        )),

                  ],
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if(!showYearSlider){
                          showYearSlider = true;
                        }
                        else if(showYearSlider){
                          showYearSlider = false;
                        }
                      });
                    },
                    child: showYearSlider == false ? const Text("Select year") : const Text("Unselect year")),
                const SizedBox(height: 15,),
                if(showYearSlider) Column(
                  children: [
                    Slider(
                      value: selectedYear,
                      min: 1920,
                      max: DateTime.now().year.toDouble(),
                      divisions: DateTime.now().year-1920,
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value;
                        });
                      },
                    ),
                    const SizedBox(height: 15,),
                    CustomText("Released in: ${selectedYear.toInt()}"),
                  ],
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, shape: const StadiumBorder()),
                    onPressed: () async{
                      Map<String, dynamic> appliedFilters = {
                        "year": showYearSlider ? selectedYear.toInt() : null,
                        "withGenres": selectedGenres,
                        "voteAverage": selectedRating,
                        "runtimeChoice": runtime,
                        "language" : selectedLanguage,
                      };

                      Api api = Api(
                        year: appliedFilters['year'],
                        withGenres: appliedFilters['withGenres'],
                        voteAverage: appliedFilters["voteAverage"],
                        runtimeChoice: appliedFilters['runtimeChoice'],
                        language: appliedFilters['language'],
                        page: 1,
                      );

                      List<MovieResult> movies = await api.CallMovieFilterApi();

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return movieFilterResults(
                            appliedFilters: appliedFilters,
                            movies: movies,
                          );
                        },
                      ));
                    },
                    child: const CustomText(
                      "Search in the filter screen",
                      size: 24,
                      color: Colors.white,
                    )),
              ],
            ),
            ),
        );
    }

  void toggleLanguageSelection(String language){
    setState(() {
      selectedLanguage = language;
      if(!isSelectedLanguage){
        isSelectedLanguage = true;
      }
      else if(isSelectedLanguage){
        isSelectedLanguage = false;
      }
    });
  }

  void toggleRunTime(String choice){
    setState(() {
      if(!isRunTimeSelected){
        isRunTimeSelected = true;
      }
      else if(isRunTimeSelected){
        isRunTimeSelected = false;
      }
      if(isRunTimeSelected == false) {
        runtime = null;
      } else {
        runtime = choice;
      }
    });
  }

  void toggleGenreSelection(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
      }
    });
  }
}