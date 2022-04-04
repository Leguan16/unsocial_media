class User {
  String name;
  String id;
  late String profileAvatar;

  User(this.name, this.id, [String? profileAvatarUrl]) {
    if(profileAvatarUrl != null) {
      setProfileAvatar(profileAvatarUrl);
    }
  }

  setProfileAvatar(String profileAvatarUrl) {
    profileAvatar = profileAvatarUrl;
  }

}