class integration {
  db = FirebaseFirestore.instance;
  
    String getTestData() {
      final testRef = db.collection("testCollection");
      final query = testRef.where("testField", isEqualTo: "Success!");
      
      final docRef = db.collection("testCollection").doc("testDocument");
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
      return "";


    }

}