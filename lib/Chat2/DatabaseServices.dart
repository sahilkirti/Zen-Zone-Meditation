import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? sid;
  DatabaseService({this.sid});

  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("customer");
  final CollectionReference groupCollection =
  FirebaseFirestore.instance.collection("groups");

  //saving the user data
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(sid).set(
      {
        "name": fullName,
        "email": email,
        "groups": [],
        "profile": "",
        "sid": sid
      },
    );
  }

  Future gettingUserData(String email) async {

    QuerySnapshot<Object?> Snapshot =
    await userCollection.where("email", isEqualTo: email).get();
    print('$Snapshot+yuuu');
    return Snapshot;
  }

  getUserGroups() async {
    return userCollection.doc(sid).snapshots();
  }

  //creating a group

  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });

    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${sid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumentReference = userCollection.doc(sid);
    return await userDocumentReference.update({
      "groups":
      FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"]),
    });
  }

  getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("message")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot["admin"];
  }

  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  searchByName(String groupName) {
    return groupCollection.where('groupName', isEqualTo: groupName).get();
  }

  //function -> bool
  Future<bool> isUserJoined(
      String groupName, String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(sid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      return true;
    } else
      return false;
  }

  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    DocumentReference userDocumentReference = userCollection.doc(sid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    if (groups.contains("${groupId}_${groupName}")) {
      await userDocumentReference.update({
        'groups': FieldValue.arrayRemove(["${groupId}_${groupName}"])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayRemove(["${sid}_${userName}"])
      });
    } else {
      await userDocumentReference.update({
        'groups': FieldValue.arrayUnion(["${groupId}_${groupName}"])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayUnion(["${sid}_${userName}"])
      });
    }
  }

  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("message").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
      "messageType": chatMessageData['type'],
    });
  }

  sendImage(String groupId, Map<String, dynamic> chatMessageData,
      String fileName) async {
    groupCollection
        .doc(groupId)
        .collection("message")
        .doc(fileName)
        .set(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      "recentMessageSender": chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
      "messageType": chatMessageData['type'],
    });
  }

  updateUrl(String groupId, String fileName, String ImgUrl) {
    groupCollection
        .doc(groupId)
        .collection("message")
        .doc(fileName)
        .update({"message": ImgUrl});
  }

  deleteImage(String groupId, String fileName) async {
    groupCollection.doc(groupId).collection("message").doc(fileName).delete();
  }
}
