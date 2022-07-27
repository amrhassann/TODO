abstract class AppStates{}
class AppInitialState extends AppStates{}
class DatabaseCreateState extends AppStates{}
class InsetLoadingState extends AppStates{}
class DatabaseInsertState extends AppStates{}
class GetDataFromDatabaseState extends AppStates{}
class GetDataByDateFromDatabaseState extends AppStates{}
class UpdateTaskState extends AppStates{
  final String change;
  UpdateTaskState({required this.change});
}
class DeleteTaskState extends AppStates{}
class SelectDateState extends AppStates{}
class GoToTodayState extends AppStates{}
class SelectedColorState extends AppStates{}