class EndPoints {
  static const baseUrl = 'http://13.53.134.38:4000/';
  static const signUpApi = '${baseUrl}api/createUser';
  static const Update = baseUrl + "api/updateUserFields";
  static const login = baseUrl + "api/loginUser";
  static const Alluser = baseUrl + "api/getAllUsers";
  static const adddetail = baseUrl + "api/updateAdditionalDetails";
  static const addLikedDislikeProfile = baseUrl + "api/addLikeDislikeProfile";
  static const uploadImage = baseUrl + 'api/uploadImage';
  static const getSingleProfile = baseUrl + 'api/getSingleProfile';
  static const getProfile = baseUrl + 'api/getProfile';
  static const getLikedDislikeProfiles = baseUrl + 'api/getLikedDislikeProfile';
  static const commentApi = baseUrl + 'api/addComment';
  static const changePasswordApi = baseUrl + 'api/changePassword';
  static const filterApi = baseUrl + 'api/getFilterProfile';
  static const notificationApi = baseUrl + 'api/notifications';
  static const updateRequestStatusApi = baseUrl + 'api/updateRequestStatus';
  static const getAllChatApi = baseUrl + 'api/getAllChatRoom';
  static const deleteImageApi = baseUrl + 'api/deleteImage';
}
