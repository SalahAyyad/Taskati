import 'package:hive/hive.dart';
import 'package:taskati/core/model/task_model.dart';

class TaskAdapter extends TypeAdapter<TaskModel> {
  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
        id: reader.readString(),
        title: reader.readString(),
        note: reader.readString(),
        date: reader.readString(),
        startTime: reader.readString(),
        endTime: reader.readString(),
        color: reader.readInt(),
        isCompleted: reader.readBool());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.note);
    writer.writeString(obj.date);
    writer.writeString(obj.startTime);
    writer.writeString(obj.endTime);
    writer.writeInt(obj.color);
    writer.writeBool(obj.isCompleted);
   



  }
}
