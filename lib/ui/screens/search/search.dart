import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:skill_branch_flutter/blocs/search_bloc.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/res/res.dart';
import 'package:skill_branch_flutter/static.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchViewState();
  }
}

class SearchViewState extends State<SearchView> {
  TextEditingController _controller;

  static SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    searchBloc = SearchBloc();
    searchBloc.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PagewiseLoadController controller = PagewiseLoadController(
    pageFuture: (int pageIndex) {
      return searchBloc.search(pageIndex);
    },
    pageSize: kPerPageUserPhotos,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Type like "Sunset"',
              ),
              onSubmitted: (String value) {
                searchBloc.lastSearchWord = value;
                controller.reset();
                controller.fetchNewPage();
              },
            ),
          ),
          Expanded(
            child: PagewiseGridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: 1,
              pageLoadController: controller,
              padding: EdgeInsets.all(15.0),
              showRetry: false,
              itemBuilder: (BuildContext context, entry, int index) {
                return buildImage(entry);
              },
              errorBuilder: (BuildContext context, Object error) {
                return Container(color: Colors.red);
              },
              loadingBuilder: (BuildContext context) {
                return CircularProgressIndicator();
              },
              noItemsFoundBuilder: (BuildContext context) {
                return Center(
                  child: Text('Нет элементов :('),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildImage(FeedNetworkModel entry) {
    return Container(
      color: AppColors.alto,
      height: (entry?.height ?? 1.0) * MediaQuery.of(context).size.width / (entry?.width ?? 1.0),
      child: CachedNetworkImage(
        imageUrl: entry.urls?.regular ?? '',
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}
