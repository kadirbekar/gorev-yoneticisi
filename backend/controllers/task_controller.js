const Task = require("../models/task_model");
const createError = require("http-errors");

//yeni bir görev eklerken kullanılır
const addNewTask = async (req, res, next) => {
  const newTask = new Task(req.body);

  const { error, value } = newTask.joiValidation(req.body);

  if (error) {
    next(createError(400, error));
  } else {
    try {
      const result = await newTask.save();
      if (result) {
        return res.status(201).json({
          result: true,
          message: "Başarılı bir şekilde kayıt edildi.",
          islemKodu: 201,
        });
      } else {
        return res.status(400).json({
          result: false,
          message: "İşlem sırasında bir hata oluştu, lütfen tekrar deneyiniz.",
          islemKodu: 400,
        });
      }
    } catch (error) {
      next(createError(500, error));
    }
  }
};

//var olan görevi güncellerken kullanılır
const updateTask = async (req, res, next) => {
  try {
    const willBeUpdated = await Task.findOneAndUpdate(
      { _id: req.body.id },
      req.body,
      { lean: true, new: true }
    );
    if (willBeUpdated) {
      return res.status(201).json({
        result: true,
        message: "Başarılı bir şekilde güncellendi",
        islemKodu: 201,
      });
    } else {
      return res.status(400).json({
        result: false,
        message: "İşlem sırasında bir hata oluştu, lütfen tekrar deneyiniz.",
        islemKodu: 400,
      });
    }
  } catch (error) {
    next(createError(500, error));
  }
};

//var olan görevi silerken kullanılır
const deleteTask = async (req, res, next) => {
  try {
    const willBeDeleted = await Task.findByIdAndDelete({ _id: req.body.id });
    if (willBeDeleted) {
      return res.status(201).json({
        result: true,
        message: "Başarılı bir şekilde silindi",
        islemKodu: 201,
      });
    } else {
      return res.status(404).json({
        result: false,
        message: "Kayıt bulunamadı",
        islemKodu: 404,
      });
    }
  } catch (error) {
    next(createError(500, error));
  }
};

//bütün kayıtları listeler
const listAllTasks = async (req, res, next) => {
  try {
    const data = await Task.find({});
    return res.status(200).json(data);
  } catch (error) {
    next(createError(500, error));
  }
};

//get tasks by categoryId
const listTasksById = async (req, res, next) => {
  try {
    const data = await Task.find().where("categoryId").equals(req.body.categoryId);
    return res.status(200).json(data);
  } catch (error) {
    next(createError(500,error));
  }
};

module.exports = {
  addNewTask,
  updateTask,
  deleteTask,
  listAllTasks,
  listTasksById
};
