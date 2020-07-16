const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const Joi = require("@hapi/joi");
const { date } = require("@hapi/joi");

//yönetici için alanlarımızı belirledik
const TaskSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      unique: true,
      trim: true,
    },
    description : {
        type : String,
        trim : true
    },
    createdDate: {
      type: Date,
      default: Date.now,
    },
    categoryId: {
      type: String,
    },
  },
  { collection: "task",versionKey : false }
);

//joi kütüphanesi ile minimum gereksinimleri belirledik
const schema = Joi.object({
  name: Joi.string().trim(),
  description : Joi.string().trim(),
  categoryId: Joi.string(),
});

TaskSchema.methods.joiValidation = function (taskObject) {
  schema.required();
  return schema.validate(taskObject);
};

const Task = mongoose.model("Task", TaskSchema);

module.exports = Task;
