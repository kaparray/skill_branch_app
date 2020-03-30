import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart' hide ErrorWidget;
import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:skill_branch_flutter/blocs/collection_bloc.dart';
import 'package:skill_branch_flutter/network/models/models.dart';
import 'package:skill_branch_flutter/res/colors.dart';
import 'package:skill_branch_flutter/ui/lib/empty.dart';
import 'package:skill_branch_flutter/ui/lib/error.dart';

class CollectionsView extends StatefulWidget {
  CollectionsView(this.collection);

  final Collections collection;

  @override
  State<StatefulWidget> createState() {
    return CollectionsViewState();
  }
}

class CollectionsViewState extends State<CollectionsView> {
  CollectionBloc collectionBloc;

  @override
  void initState() {
    super.initState();
    collectionBloc = CollectionBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: PagewiseGridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1,
        pageSize: 12,
        showRetry: false,
        pageFuture: (int pageIndex) async {
          return await collectionBloc.getCollectionPhotosById(widget.collection.id.toString(), pageIndex + 1);
        },
        itemBuilder: (BuildContext context, FeedNetworkModel _, int index) {
          return buildImage(index);
        },
        errorBuilder: (context, error) => ErrorWidget(),
        loadingBuilder: (BuildContext context) {
          return CircularProgressIndicator();
        },
        noItemsFoundBuilder: (BuildContext context) => EmptyWidget(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: collectionBloc.pop,
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(
        'Collection',
        style: TextStyle(color: Colors.black),
      ),
      elevation: 0.0,
    );
  }

  Widget buildImage(int index) {
    return GestureDetector(
      onTap: () {
        collectionBloc.goToFullScreen(index);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          color: AppColors.white,
          height: collectionBloc.calculateHeight(context, index),
          child: CachedNetworkImage(
            imageUrl: collectionBloc.regularUserFeedPhoto(index),
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
