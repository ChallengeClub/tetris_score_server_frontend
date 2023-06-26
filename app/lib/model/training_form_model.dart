class TrainingModel{
  final String section;
  final String id;
  final String? title;
  final String? description;
  final String? inputDescription;
  final String? outputDescription;

  TrainingModel(
    this.section,
    this.id,
    this.title,
    this.description,
    this.inputDescription,
    this.outputDescription
  );

  TrainingModel.fromJson(dynamic map)
  : section = map['Section'],
    id = map['Id'],
    title = map['Title'],
    description = map['Description'],
    inputDescription = map['InputDescription'],
    outputDescription = map['OutputDescription'];    

  @override
  bool operator == (Object other) =>
    identical(other, this) || other is TrainingModel && id == other.id && section == other.section;
    
  @override
  int get hashCode => Object.hashAll([section, id]);
}

class TrainingFormModel {
  final String user_id;
  final TrainingModel training;
  final String code;

  TrainingFormModel(
    this.user_id,
    this.training,
    this.code,
  );
}
