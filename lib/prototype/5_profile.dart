// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   runApp(MyApp());
// }

// class UserProfile {
//   final String name;
//   final String profileImage;

//   UserProfile(this.name, this.profileImage);
// }

// class Friend {
//   final String name;
//   final String profileImage;

//   Friend(this.name, this.profileImage);
// }

// class UserProfileCubit extends Cubit<UserProfile> {
//   UserProfileCubit() : super(UserProfile('Your Name', 'your_profile_image_url'));

//   void updateProfile(UserProfile profile) => emit(profile);
// }

// class FriendListCubit extends Cubit<List<Friend>> {
//   FriendListCubit() : super([]);

//   void updateFriends(List<Friend> friends) => emit(friends);
// }

// class MyApp extends StatelessWidget {
//   final UserProfileCubit userProfileCubit = UserProfileCubit();
//   final FriendListCubit friendListCubit = FriendListCubit();

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: userProfileCubit),
//         BlocProvider.value(value: friendListCubit),
//       ],
//       child: MaterialApp(
//         title: 'Flutter App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: ChatScreen(),
//       ),
//     );
//   }
// }

// class ChatScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('프로필 화면'),
//       ),
//       drawer: Drawer(
//         child: FriendList(),
//       ),
//       body: UserProfileCard(),
//     );
//   }
// }

// class UserProfileCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserProfileCubit, UserProfile>(
//       builder: (context, userProfile) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: NetworkImage(userProfile.profileImage),
//             ),
//             SizedBox(height: 16),
//             Text(userProfile.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ],
//         );
//       },
//     );
//   }
// }

// class FriendList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FriendListCubit, List<Friend>>(
//       builder: (context, friendList) {
//         return ListView.builder(
//           itemCount: friendList.length,
//           itemBuilder: (context, index) {
//             final friend = friendList[index];
//             return ListTile(
//               leading: CircleAvatar(
//                 radius: 24,
//                 backgroundImage: NetworkImage(friend.profileImage),
//               ),
//               title: Text(friend.name),
//               onTap: () {
//                 // 친구를 탭하면 해당 친구와의 채팅 화면으로 이동하도록 추가 기능 구현
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
