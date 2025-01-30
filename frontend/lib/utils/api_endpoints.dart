class APIENDPOINTS {
  //
  static final String baseUrl = 'http://10.0.2.2:5000/api';

  //
  static _AuthEndpoints authEndpoints = _AuthEndpoints();

  //
  static _UserEndpoints userEndpoints = _UserEndpoints();

  //
  static _GroupEndpoints groupEndpoints = _GroupEndpoints();

  //
  static _MessageEndpoints messageEndpoints = _MessageEndpoints();

  //
  static _StatusEndpoints statusEndpoints = _StatusEndpoints();
}

//
class _AuthEndpoints {
  final String signupAuth = '/auth/signup';
  final String loginAuth = '/auth/login';
  final String logoutAuth = '/auth/logout';
  // final String verifyEmailAuth = 'auth/verify-email';
  // final String forgetPasswordAuth = 'auth/forgot-password';
  // final String resetPasswordAuth = 'auth/reset-password/:token';
}

class _UserEndpoints {
  final String profileUser = '/users/me';
  final String updateProfile = '/users/update-profile';
  final String deleteAccount = '/users/delete-account';
  final String getUsers = '/users/';
  final String followUser = '/users/follow/:id';
  final String unFollowUser = '/users/unfollow/:id';
}

class _GroupEndpoints {
  final String createGroup = '/groups/';
  final String sendMessage = '/groups/:id';
  final String getGroups = '/groups/';
  final String getGroupMessages = '/groups/:id';
  final String updateGroup = '/groups/update/:id';
  final String deleteGroup = '/groups/delete/:id';
}

class _MessageEndpoints {
  final String sendMessage = '/messages/:id';
  final String getMessages = '/messages/:id';
  final String deleteMessage = '/messages/:id';
}

class _StatusEndpoints {
  final String createStatus = '/status/';
  final String getStatus = '/status/';
  final String GetStatusByUser = '/status/:id';
  final String deleteStatus = '/status/:id';
}
