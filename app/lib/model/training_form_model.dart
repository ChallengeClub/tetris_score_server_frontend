class TrainingModel{
  final String section;
  final String id;
  final String? title;
  final String? discription;
  TrainingModel(
    this.section,
    this.id,
    this.title,
    this.discription
  );

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
