class FormModel {
  final String repository_url;
  final String branch_name;
  final int level;
  final int drop_interval;

  FormModel(
      this.repository_url, this.branch_name, this.level, this.drop_interval);
}
