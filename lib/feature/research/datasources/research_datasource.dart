import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_research/feature/research/model/research_model.dart';

class ResearchDatasource {
  final collection = FirebaseFirestore.instance.collection('researchs');

  Future<ResearchModel> loadResearch(String id) async {
    return await collection.doc(id).get().then(
          (value) => ResearchModel.fromMap(
            value.data() ?? {},
          ),
        );
  }
}
