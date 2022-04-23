import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tbr_group_test/models/country.dart';
import 'package:tbr_group_test/theme/app_colors.dart';
import 'package:http/http.dart' as http;

class ChooseCountryButton extends StatefulWidget {
  ChooseCountryButton({Key? key}) : super(key: key);

  @override
  State<ChooseCountryButton> createState() => _ChooseCountryButtonState();
}

class _ChooseCountryButtonState extends State<ChooseCountryButton> {
  String _selectedCode = '';
  String _selectedFlag = '';
  List _countries = [];

  @override
  void initState() {
    super.initState();
    _selectedFlag = 'https://flagcdn.com/ua.svg';
    _selectedCode = '380';
  }

  Future<List<Country>> getCountries() async {
    var response = await http.get(Uri.https('restcountries.com', 'v2/all'));
    var jsonData = jsonDecode(response.body);
    List<Country> countries = [];

    for (var item in jsonData) {
      Country country =
          Country(item['name'], item['callingCodes'][0], item['flags']['svg']);
      countries.add(country);
    }
    return countries;
  }

  bottomSheet(BuildContext context) async {
    _countries =
        await getCountries(); // ! ---------------------- delet wtf await async
    final controller = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.mainBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: getCountries(),
          builder: <List>(context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: Text('Loading...'));
            } else {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Country code',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(Icons.close))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextField(
                          onChanged: searchCountry,
                          controller: controller,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.bottom,
                          autofocus: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.inputBackgroundColor,
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search,
                                color: AppColors.searchTextColor),
                            hintStyle: TextStyle(
                              color: AppColors.inputHintTextColor,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _selectedFlag = snapshot.data[index].flag;
                                _selectedCode =
                                    snapshot.data[index].callingCode;
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                      width: 38,
                                      child: SvgPicture.network(
                                          snapshot.data[index].flag, // ! 'https://flagcdn.com/ua.svg' change to flag
                                          fit: BoxFit.contain),
                                    ),
                                    SizedBox(width: 12),
                                    SizedBox(
                                      width: 45,
                                      child: Text(
                                        '+${snapshot.data[index].callingCode}',
                                        style: TextStyle(
                                            color: AppColors.searchTextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bottomSheet(context);
      },
      child: Container(
        height: 48,
        // width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.inputBackgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                width: 38,
                height: 20,
                child: SvgPicture.network(
                    _selectedFlag, // ! https://flagcdn.com/ua.svg    ${snapshot.data[index].flag}
                    fit: BoxFit.contain),
              ),
              Text('+$_selectedCode'),
            ],
          ),
        ),
      ),
    );
  }

  void searchCountry(String query) {
    final suggestions = _countries.where((element) {
      final countryName = element.name.toLowerCase();
      final input = query.toLowerCase();

      return countryName.contains(input);
    }).toList();
    setState(() {
      _countries = suggestions;
    });
  }
}
