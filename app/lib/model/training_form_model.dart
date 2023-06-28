class TrainingModel{
  final String section;
  final String id;
  final String? title;
  final String? description;
  final String? inputTemplate;
  final String? inputDescription;
  final String? inputSample;
  final String? outputTemplate;
  final String? outputDescription;
  final String? outputSample;

  TrainingModel(
    this.section,
    this.id,
    this.title,
    this.description,
    this.inputTemplate,
    this.inputDescription,
    this.inputSample,
    this.outputTemplate,
    this.outputDescription,
    this.outputSample,
  );

  TrainingModel.fromJson(dynamic map)
  : section = map['Section'],
    id = map["Id"].toString(),
    title = map['Title'],
    description = map['Description'],
    inputTemplate = map['InputTemplate'],
    inputDescription = map['InputDescription'],
    inputSample = map['InputSample'],
    outputTemplate = map['OutputTemplate'],
    outputDescription = map['OutputDescription'],
    outputSample = map['OutputSample'];    

  @override
  bool operator == (Object other) =>
    identical(other, this) || other is TrainingModel && id == other.id && section == other.section;
    
  @override
  int get hashCode => Object.hashAll([section, id]);
}

class TrainingFormModel {
  final TrainingModel training;
  final String status;
  final String? error_message;
  final List<String>? results;
  
  TrainingFormModel(
    this.training,
    this.status,
    this.error_message,
    this.results,
  );

  TrainingFormModel copyWith({TrainingModel? training, String? status, String? error_message, List<String>? results}){
    return TrainingFormModel(
      training ?? this.training,
      status ?? this.status,
      error_message ?? this.error_message,
      results ?? this.results,
    );
  }
}
