// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_network_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserNetworkModel> _$userNetworkModelSerializer =
    new _$UserNetworkModelSerializer();

class _$UserNetworkModelSerializer
    implements StructuredSerializer<UserNetworkModel> {
  @override
  final Iterable<Type> types = const [UserNetworkModel, _$UserNetworkModel];
  @override
  final String wireName = 'UserNetworkModel';

  @override
  Iterable<Object> serialize(Serializers serializers, UserNetworkModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result
        ..add('id')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(String)));
    }
    if (object.updatedAt != null) {
      result
        ..add('updatedAt')
        ..add(serializers.serialize(object.updatedAt,
            specifiedType: const FullType(DateTime)));
    }
    if (object.username != null) {
      result
        ..add('username')
        ..add(serializers.serialize(object.username,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.firstName != null) {
      result
        ..add('firstName')
        ..add(serializers.serialize(object.firstName,
            specifiedType: const FullType(String)));
    }
    if (object.lastName != null) {
      result
        ..add('lastName')
        ..add(serializers.serialize(object.lastName,
            specifiedType: const FullType(String)));
    }
    if (object.instagramUsername != null) {
      result
        ..add('instagramUsername')
        ..add(serializers.serialize(object.instagramUsername,
            specifiedType: const FullType(String)));
    }
    if (object.twitterUsername != null) {
      result
        ..add('twitterUsername')
        ..add(serializers.serialize(object.twitterUsername,
            specifiedType: const FullType(String)));
    }
    if (object.portfolioUrl != null) {
      result
        ..add('portfolioUrl')
        ..add(serializers.serialize(object.portfolioUrl,
            specifiedType: const FullType(String)));
    }
    if (object.bio != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(object.bio,
            specifiedType: const FullType(String)));
    }
    if (object.location != null) {
      result
        ..add('location')
        ..add(serializers.serialize(object.location,
            specifiedType: const FullType(String)));
    }
    if (object.totalLikes != null) {
      result
        ..add('totalLikes')
        ..add(serializers.serialize(object.totalLikes,
            specifiedType: const FullType(int)));
    }
    if (object.totalPhotos != null) {
      result
        ..add('totalPhotos')
        ..add(serializers.serialize(object.totalPhotos,
            specifiedType: const FullType(int)));
    }
    if (object.totalCollections != null) {
      result
        ..add('totalCollections')
        ..add(serializers.serialize(object.totalCollections,
            specifiedType: const FullType(int)));
    }
    if (object.followedByUser != null) {
      result
        ..add('followedByUser')
        ..add(serializers.serialize(object.followedByUser,
            specifiedType: const FullType(bool)));
    }
    if (object.followersCount != null) {
      result
        ..add('followersCount')
        ..add(serializers.serialize(object.followersCount,
            specifiedType: const FullType(int)));
    }
    if (object.followingCount != null) {
      result
        ..add('followingCount')
        ..add(serializers.serialize(object.followingCount,
            specifiedType: const FullType(int)));
    }
    if (object.downloads != null) {
      result
        ..add('downloads')
        ..add(serializers.serialize(object.downloads,
            specifiedType: const FullType(int)));
    }
    if (object.profileImage != null) {
      result
        ..add('profileImage')
        ..add(serializers.serialize(object.profileImage,
            specifiedType: const FullType(ProfileImage)));
    }
    if (object.badge != null) {
      result
        ..add('badge')
        ..add(serializers.serialize(object.badge,
            specifiedType: const FullType(Badge)));
    }
    if (object.links != null) {
      result
        ..add('links')
        ..add(serializers.serialize(object.links,
            specifiedType: const FullType(Links)));
    }
    return result;
  }

  @override
  UserNetworkModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserNetworkModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'firstName':
          result.firstName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lastName':
          result.lastName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'instagramUsername':
          result.instagramUsername = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'twitterUsername':
          result.twitterUsername = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'portfolioUrl':
          result.portfolioUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'location':
          result.location = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'totalLikes':
          result.totalLikes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'totalPhotos':
          result.totalPhotos = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'totalCollections':
          result.totalCollections = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'followedByUser':
          result.followedByUser = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'followersCount':
          result.followersCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'followingCount':
          result.followingCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'downloads':
          result.downloads = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'profileImage':
          result.profileImage = serializers.deserialize(value,
              specifiedType: const FullType(ProfileImage)) as ProfileImage;
          break;
        case 'badge':
          result.badge = serializers.deserialize(value,
              specifiedType: const FullType(Badge)) as Badge;
          break;
        case 'links':
          result.links = serializers.deserialize(value,
              specifiedType: const FullType(Links)) as Links;
          break;
      }
    }

    return result.build();
  }
}

class _$UserNetworkModel extends UserNetworkModel {
  @override
  final String id;
  @override
  final DateTime updatedAt;
  @override
  final String username;
  @override
  final String name;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String instagramUsername;
  @override
  final String twitterUsername;
  @override
  final String portfolioUrl;
  @override
  final String bio;
  @override
  final String location;
  @override
  final int totalLikes;
  @override
  final int totalPhotos;
  @override
  final int totalCollections;
  @override
  final bool followedByUser;
  @override
  final int followersCount;
  @override
  final int followingCount;
  @override
  final int downloads;
  @override
  final ProfileImage profileImage;
  @override
  final Badge badge;
  @override
  final Links links;

  factory _$UserNetworkModel(
          [void Function(UserNetworkModelBuilder) updates]) =>
      (new UserNetworkModelBuilder()..update(updates)).build();

  _$UserNetworkModel._(
      {this.id,
      this.updatedAt,
      this.username,
      this.name,
      this.firstName,
      this.lastName,
      this.instagramUsername,
      this.twitterUsername,
      this.portfolioUrl,
      this.bio,
      this.location,
      this.totalLikes,
      this.totalPhotos,
      this.totalCollections,
      this.followedByUser,
      this.followersCount,
      this.followingCount,
      this.downloads,
      this.profileImage,
      this.badge,
      this.links})
      : super._();

  @override
  UserNetworkModel rebuild(void Function(UserNetworkModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserNetworkModelBuilder toBuilder() =>
      new UserNetworkModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserNetworkModel &&
        id == other.id &&
        updatedAt == other.updatedAt &&
        username == other.username &&
        name == other.name &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        instagramUsername == other.instagramUsername &&
        twitterUsername == other.twitterUsername &&
        portfolioUrl == other.portfolioUrl &&
        bio == other.bio &&
        location == other.location &&
        totalLikes == other.totalLikes &&
        totalPhotos == other.totalPhotos &&
        totalCollections == other.totalCollections &&
        followedByUser == other.followedByUser &&
        followersCount == other.followersCount &&
        followingCount == other.followingCount &&
        downloads == other.downloads &&
        profileImage == other.profileImage &&
        badge == other.badge &&
        links == other.links;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc(0, id.hashCode), updatedAt.hashCode),
                                                                                username.hashCode),
                                                                            name.hashCode),
                                                                        firstName.hashCode),
                                                                    lastName.hashCode),
                                                                instagramUsername.hashCode),
                                                            twitterUsername.hashCode),
                                                        portfolioUrl.hashCode),
                                                    bio.hashCode),
                                                location.hashCode),
                                            totalLikes.hashCode),
                                        totalPhotos.hashCode),
                                    totalCollections.hashCode),
                                followedByUser.hashCode),
                            followersCount.hashCode),
                        followingCount.hashCode),
                    downloads.hashCode),
                profileImage.hashCode),
            badge.hashCode),
        links.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserNetworkModel')
          ..add('id', id)
          ..add('updatedAt', updatedAt)
          ..add('username', username)
          ..add('name', name)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('instagramUsername', instagramUsername)
          ..add('twitterUsername', twitterUsername)
          ..add('portfolioUrl', portfolioUrl)
          ..add('bio', bio)
          ..add('location', location)
          ..add('totalLikes', totalLikes)
          ..add('totalPhotos', totalPhotos)
          ..add('totalCollections', totalCollections)
          ..add('followedByUser', followedByUser)
          ..add('followersCount', followersCount)
          ..add('followingCount', followingCount)
          ..add('downloads', downloads)
          ..add('profileImage', profileImage)
          ..add('badge', badge)
          ..add('links', links))
        .toString();
  }
}

class UserNetworkModelBuilder
    implements Builder<UserNetworkModel, UserNetworkModelBuilder> {
  _$UserNetworkModel _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _firstName;
  String get firstName => _$this._firstName;
  set firstName(String firstName) => _$this._firstName = firstName;

  String _lastName;
  String get lastName => _$this._lastName;
  set lastName(String lastName) => _$this._lastName = lastName;

  String _instagramUsername;
  String get instagramUsername => _$this._instagramUsername;
  set instagramUsername(String instagramUsername) =>
      _$this._instagramUsername = instagramUsername;

  String _twitterUsername;
  String get twitterUsername => _$this._twitterUsername;
  set twitterUsername(String twitterUsername) =>
      _$this._twitterUsername = twitterUsername;

  String _portfolioUrl;
  String get portfolioUrl => _$this._portfolioUrl;
  set portfolioUrl(String portfolioUrl) => _$this._portfolioUrl = portfolioUrl;

  String _bio;
  String get bio => _$this._bio;
  set bio(String bio) => _$this._bio = bio;

  String _location;
  String get location => _$this._location;
  set location(String location) => _$this._location = location;

  int _totalLikes;
  int get totalLikes => _$this._totalLikes;
  set totalLikes(int totalLikes) => _$this._totalLikes = totalLikes;

  int _totalPhotos;
  int get totalPhotos => _$this._totalPhotos;
  set totalPhotos(int totalPhotos) => _$this._totalPhotos = totalPhotos;

  int _totalCollections;
  int get totalCollections => _$this._totalCollections;
  set totalCollections(int totalCollections) =>
      _$this._totalCollections = totalCollections;

  bool _followedByUser;
  bool get followedByUser => _$this._followedByUser;
  set followedByUser(bool followedByUser) =>
      _$this._followedByUser = followedByUser;

  int _followersCount;
  int get followersCount => _$this._followersCount;
  set followersCount(int followersCount) =>
      _$this._followersCount = followersCount;

  int _followingCount;
  int get followingCount => _$this._followingCount;
  set followingCount(int followingCount) =>
      _$this._followingCount = followingCount;

  int _downloads;
  int get downloads => _$this._downloads;
  set downloads(int downloads) => _$this._downloads = downloads;

  ProfileImage _profileImage;
  ProfileImage get profileImage => _$this._profileImage;
  set profileImage(ProfileImage profileImage) =>
      _$this._profileImage = profileImage;

  Badge _badge;
  Badge get badge => _$this._badge;
  set badge(Badge badge) => _$this._badge = badge;

  Links _links;
  Links get links => _$this._links;
  set links(Links links) => _$this._links = links;

  UserNetworkModelBuilder();

  UserNetworkModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _updatedAt = _$v.updatedAt;
      _username = _$v.username;
      _name = _$v.name;
      _firstName = _$v.firstName;
      _lastName = _$v.lastName;
      _instagramUsername = _$v.instagramUsername;
      _twitterUsername = _$v.twitterUsername;
      _portfolioUrl = _$v.portfolioUrl;
      _bio = _$v.bio;
      _location = _$v.location;
      _totalLikes = _$v.totalLikes;
      _totalPhotos = _$v.totalPhotos;
      _totalCollections = _$v.totalCollections;
      _followedByUser = _$v.followedByUser;
      _followersCount = _$v.followersCount;
      _followingCount = _$v.followingCount;
      _downloads = _$v.downloads;
      _profileImage = _$v.profileImage;
      _badge = _$v.badge;
      _links = _$v.links;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserNetworkModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$UserNetworkModel;
  }

  @override
  void update(void Function(UserNetworkModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserNetworkModel build() {
    final _$result = _$v ??
        new _$UserNetworkModel._(
            id: id,
            updatedAt: updatedAt,
            username: username,
            name: name,
            firstName: firstName,
            lastName: lastName,
            instagramUsername: instagramUsername,
            twitterUsername: twitterUsername,
            portfolioUrl: portfolioUrl,
            bio: bio,
            location: location,
            totalLikes: totalLikes,
            totalPhotos: totalPhotos,
            totalCollections: totalCollections,
            followedByUser: followedByUser,
            followersCount: followersCount,
            followingCount: followingCount,
            downloads: downloads,
            profileImage: profileImage,
            badge: badge,
            links: links);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
